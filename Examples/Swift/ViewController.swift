import UIKit
import MapboxCoreNavigation
import MapboxNavigation
import MapboxNavigationUI
import MapboxDirections
import UserNotifications
import MapKit

private typealias RouteRequestSuccess = (([Route]) -> Void)
private typealias RouteRequestFailure = ((NSError) -> Void)


class ViewController: UIViewController, MGLMapViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var longPressHintView: UIView!
    @IBOutlet weak var simulationButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var clearMap: UIButton!
    @IBOutlet weak var bottomBarBackground: UIView!
    
    var navigationViewController: SpotARNavigationViewController!
    var navigationView: UIViewController?
    
    // MARK: Properties
    var mapView: NavigationMapView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let mapView = mapView {
                configureMapView(mapView)
                view.insertSubview(mapView, belowSubview: longPressHintView)
            }
        }
    }
    var waypoints: [Waypoint] = [] {
        didSet {
            waypoints.forEach {
                $0.coordinateAccuracy = -1
            }
        }
    }

    var routes: [Route]? {
        didSet {
            startButton.isEnabled = (routes?.count ?? 0 > 0)
            guard let routes = routes,
                  let current = routes.first else { mapView?.removeRoutes(); return }

            mapView?.showRoutes(routes)
            mapView?.showWaypoints(current)
        }
    }

    // MARK: Directions Request Handlers

    fileprivate lazy var defaultSuccess: RouteRequestSuccess = { [weak self] (routes) in
        guard let current = routes.first else { return }
        self?.mapView?.removeWaypoints()
        self?.routes = routes
        self?.waypoints = current.routeOptions.waypoints
        self?.clearMap.isHidden = false
        self?.longPressHintView.isHidden = true
    }

    fileprivate lazy var defaultFailure: RouteRequestFailure = { [weak self] (error) in
        self?.routes = nil //clear routes from the map
        print(error.localizedDescription)
    }

    var alertController: UIAlertController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startMapView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) { _,_ in
                DispatchQueue.main.async {
                    CLLocationManager().requestWhenInUseAuthorization()
                }
            }
        }
    }

    // MARK: Gesture Recognizer Handlers
    @objc func didLongPress(tap: UILongPressGestureRecognizer) {
        guard let mapView = mapView, tap.state == .began else { return }

        if let annotation = mapView.annotations?.last, waypoints.count > 2 {
            mapView.removeAnnotation(annotation)
        }

        if waypoints.count > 1 {
            waypoints = Array(waypoints.suffix(1))
        }
        
        let coordinates = mapView.convert(tap.location(in: mapView), toCoordinateFrom: mapView)
        // Note: The destination name can be modified. The value is used in the top banner when arriving at a destination.
        let waypoint = Waypoint(coordinate: coordinates, name: "Dropped Pin #\(waypoints.endIndex + 1)")
        waypoints.append(waypoint)

        requestRoute()
    }

    @IBAction func simulateButtonPressed(_ sender: Any) {
        simulationButton.isSelected = !simulationButton.isSelected
    }

    @IBAction func clearMapPressed(_ sender: Any) {
        clearMap.isHidden = true
        mapView?.removeRoutes()
        mapView?.removeWaypoints()
        waypoints.removeAll()
        longPressHintView.isHidden = false
    }

    @IBAction func startButtonPressed(_ sender: Any) {
        startStyledNavigation()
    }

    // MARK: - Public Methods
    // MARK: Route Requests
    func requestRoute() {
        guard waypoints.count > 0 else { return }
        guard let mapView = mapView else { return }

        let userWaypoint = Waypoint(location: mapView.userLocation!.location!, heading: mapView.userLocation?.heading, name: "User location")
        waypoints.insert(userWaypoint, at: 0)

        let routeOptions = NavigationRouteOptions(waypoints: waypoints, profileIdentifier: MBDirectionsProfileIdentifier.walking)
        
        requestRoute(with: routeOptions, success: defaultSuccess, failure: defaultFailure)
    }

    fileprivate func requestRoute(with options: RouteOptions, success: @escaping RouteRequestSuccess, failure: RouteRequestFailure?) {
        let handler: Directions.RouteCompletionHandler = {(waypoints, potentialRoutes, potentialError) in
            if let error = potentialError, let fail = failure { return fail(error) }
            guard let routes = potentialRoutes else { return }
            return success(routes)
        }

        _ = Directions.shared.calculate(options, completionHandler: handler)
    }

    func startStyledNavigation() {
        navigationViewController = SpotARNavigationViewController()
        navigationViewController.delegate = self
        navigationViewController.startNavigation(routes: routes!, simulated: simulationButton.isSelected)
    }

    func presentAndRemoveMapview(_ viewController: UIViewController) {
        self.navigationView = viewController
        present(viewController, animated: true) {
            self.mapView?.removeFromSuperview()
            self.mapView = nil
        }
    }
    
    func startMapView() {
        self.routes = nil
        self.waypoints = []
        self.mapView = NavigationMapView(frame: view.bounds)

        // Reset the navigation styling to the defaults if we are returning from a presentation.
        if (presentedViewController != nil) {
            DayStyle().apply()
        }
    }

    func configureMapView(_ mapView: NavigationMapView) {
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.navigationMapDelegate = self
        mapView.userTrackingMode = .follow
        mapView.logoView.isHidden = true

        let singleTap = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(tap:)))
        mapView.gestureRecognizers?.filter({ $0 is UILongPressGestureRecognizer }).forEach(singleTap.require(toFail:))
        mapView.addGestureRecognizer(singleTap)
    }

    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        self.mapView?.localizeLabels()
        
        if let routes = routes, let currentRoute = routes.first, let coords = currentRoute.coordinates {
            mapView.setVisibleCoordinateBounds(MGLPolygon(coordinates: coords, count: currentRoute.coordinateCount).overlayBounds, animated: false)
            self.mapView?.showRoutes(routes)
            self.mapView?.showWaypoints(currentRoute)
        }
    }
}

// MARK: - NavigationMapViewDelegate
extension ViewController: NavigationMapViewDelegate {
    func navigationMapView(_ mapView: NavigationMapView, didSelect waypoint: Waypoint) {
        guard let routeOptions = routes?.first?.routeOptions else { return }
        let modifiedOptions = routeOptions.without(waypoint: waypoint)

        presentWaypointRemovalActionSheet { _ in
            self.requestRoute(with:modifiedOptions, success: self.defaultSuccess, failure: self.defaultFailure)
        }
    }

    func navigationMapView(_ mapView: NavigationMapView, didSelect route: Route) {
        guard let routes = routes else { return }
        guard let index = routes.index(where: { $0 == route }) else { return }
        self.routes!.remove(at: index)
        self.routes!.insert(route, at: 0)
    }

    private func presentWaypointRemovalActionSheet(completionHandler approve: @escaping ((UIAlertAction) -> Void)) {
        let title = NSLocalizedString("Remove Waypoint?", comment: "Waypoint Removal Action Sheet Title")
        let message = NSLocalizedString("Would you like to remove this waypoint?", comment: "Waypoint Removal Action Sheet Message")
        let removeTitle = NSLocalizedString("Remove Waypoint", comment: "Waypoint Removal Action Item Title")
        let cancelTitle = NSLocalizedString("Cancel", comment: "Waypoint Removal Action Sheet Cancel Item Title")

        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let remove = UIAlertAction(title: removeTitle, style: .destructive, handler: approve)
        let cancel = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        [remove, cancel].forEach(actionSheet.addAction(_:))

        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension ViewController: SpotARNavigationUIDelegate {
    func wantsToPresent(viewController: UIViewController) {
        presentAndRemoveMapview(viewController)
    }
    
    func didArrive() {
        self.navigationView?.dismiss(animated: true, completion: nil)
    }
    
    func didCancel() {
        self.navigationView?.dismiss(animated: true) {
            self.startMapView()
        }
    }
}
