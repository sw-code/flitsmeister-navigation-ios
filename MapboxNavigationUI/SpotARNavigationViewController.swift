import Foundation
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections

public class SpotARNavigationViewController {
    private var routes: [Route]?
    
    public var navigationViewController: NavigationViewController!
    public var delegate: SpotARNavigationUIDelegate?
    
    public var navigationView: UIView {
        get {
            return navigationViewController.view
        }
    }
    
    public init() {}
    
    public func startNavigation(routes: [Route], simulated: Bool = false) {
        guard let route = routes.first else { return }
        self.routes = routes
        
        navigationViewController = NavigationViewController(
            for: route,
            locationManager: getNavigationLocationManager(simulated: simulated)
        )
        navigationViewController.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(progressDidChange(_ :)), name: .routeControllerProgressDidChange, object: nil)
        
        delegate?.wantsToPresent(viewController: navigationViewController)
    }
    
    public func readjustMapCenter() {
        if navigationViewController.mapView != nil {
            let halfMapHeight = navigationViewController.mapView!.bounds.height / 2
            let topPadding = halfMapHeight - 30
            navigationViewController.mapView?.setContentInset(UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0), animated: true, completionHandler: nil)
        }
    }
    
    @objc func progressDidChange(_ notification: NSNotification  ) {
        let routeProgress = notification.userInfo![RouteControllerNotificationUserInfoKey.routeProgressKey] as! RouteProgress
        let location = notification.userInfo![RouteControllerNotificationUserInfoKey.locationKey] as! CLLocation
    
        addManeuverArrow(routeProgress)
        updateUserPuck(location)
        readjustMapCenter()
    }
    
    private func addManeuverArrow(_ routeProgress: RouteProgress) {
        if routeProgress.currentLegProgress.followOnStep != nil {
            navigationViewController.mapView?.addArrow(route: routeProgress.route, legIndex: routeProgress.legIndex, stepIndex: routeProgress.currentLegProgress.stepIndex + 1)
        } else {
            navigationViewController.mapView?.removeArrow()
        }
    }
    
    private func updateUserPuck(_ location: CLLocation) {
        navigationViewController.mapView?.updateCourseTracking(location: location, animated: true)
    }
    
    private func getNavigationLocationManager(simulated: Bool) -> NavigationLocationManager {
        guard let route = routes?.first else { return NavigationLocationManager() }
        return simulated ? SimulatedLocationManager(route: route) : NavigationLocationManager()
    }
}
