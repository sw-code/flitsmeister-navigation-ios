import Foundation
#if canImport(CarPlay)
import CarPlay

@available(iOS 12.0, *)
class CarPlayMapViewController: UIViewController, MGLMapViewDelegate {
    
    static let defaultAltitude: CLLocationDistance = 16000
    
    var styleManager: StyleManager!
    /// A very coarse location manager used for distinguishing between daytime and nighttime.
    fileprivate let coarseLocationManager: CLLocationManager = {
        let coarseLocationManager = CLLocationManager()
        coarseLocationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        return coarseLocationManager
    }()
    
    var isOverviewingRoutes: Bool = false
    
    var mapViewWrapper: NavigationMapView {
        get {
            return self.view as! NavigationMapView
        }
    }

    lazy var recenterButton: CPMapButton = {
        let recenterButton = CPMapButton { [weak self] button in
            guard let strongSelf = self else {
                return
            }
            
            strongSelf.mapViewWrapper.setUserTrackingMode(.followWithCourse, animated: true)
            button.isHidden = true
        }
        
        let bundle = Bundle.mapboxNavigation
        recenterButton.image = UIImage(named: "carplay_locate", in: bundle, compatibleWith: traitCollection)
        return recenterButton
    }()
    
    override func loadView() {
        let mapViewWrapper = NavigationMapView()
        mapViewWrapper.delegate = self
//        mapView.navigationMapDelegate = self
        mapViewWrapper.logoView.isHidden = true
        mapViewWrapper.attributionButton.isHidden = true
        
        self.view = mapViewWrapper
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        styleManager = StyleManager(self)
        styleManager.styles = [DayStyle(), NightStyle()]
        
        resetCamera(animated: false, altitude: CarPlayMapViewController.defaultAltitude)
        mapViewWrapper.setUserTrackingMode(.followWithCourse, animated: true)
    }
    
    public func zoomInButton() -> CPMapButton {
        let zoomInButton = CPMapButton { [weak self] (button) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.mapViewWrapper.setZoomLevel(strongSelf.mapViewWrapper.zoomLevel + 1, animated: true)
        }
        let bundle = Bundle.mapboxNavigation
        zoomInButton.image = UIImage(named: "carplay_plus", in: bundle, compatibleWith: traitCollection)
        return zoomInButton
    }
    
    public func zoomOutButton() -> CPMapButton {
        let zoomInOut = CPMapButton { [weak self] (button) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.mapViewWrapper.setZoomLevel(strongSelf.mapViewWrapper.zoomLevel - 1, animated: true)
        }
        let bundle = Bundle.mapboxNavigation
        zoomInOut.image = UIImage(named: "carplay_minus", in: bundle, compatibleWith: traitCollection)
        return zoomInOut
    }

    
    // MARK: - MGLMapViewDelegate

    func mapView(_ mapViewWrapper: MGLMapView, didFinishLoading style: MGLStyle) {
        if let mapViewWrapper = mapViewWrapper as? NavigationMapView {
            mapViewWrapper.localizeLabels()
        }
    }
    
    func resetCamera(animated: Bool = false, altitude: CLLocationDistance? = nil) {
        let camera = mapViewWrapper.camera
        if let altitude = altitude {
            camera.altitude = altitude
        }
        camera.pitch = 60
        mapViewWrapper.setCamera(camera, animated: animated)

    }
    
    override func viewSafeAreaInsetsDidChange() {
        mapViewWrapper.setContentInset(mapViewWrapper.safeArea, animated: false)
        
        guard isOverviewingRoutes else {
            super.viewSafeAreaInsetsDidChange()
            return
        }
        
        
        guard let routes = mapViewWrapper.routes,
            let active = routes.first else {
                super.viewSafeAreaInsetsDidChange()
                return
        }
        
        mapViewWrapper.fit(to: active, animated: false)
    }
}

@available(iOS 12.0, *)
extension CarPlayMapViewController: StyleManagerDelegate {
    func locationFor(styleManager: StyleManager) -> CLLocation? {
        return mapViewWrapper.userLocationForCourseTracking ?? mapViewWrapper.userLocation?.location ?? coarseLocationManager.location
    }
    
    func styleManager(_ styleManager: StyleManager, didApply style: Style) {
        let styleURL = style.previewMapStyleURL
        if mapViewWrapper.styleURL != styleURL {
            mapViewWrapper.style?.transition = MGLTransition(duration: 0.5, delay: 0)
            mapViewWrapper.styleURL = styleURL
        }
    }
    
    func styleManagerDidRefreshAppearance(_ styleManager: StyleManager) {
        mapViewWrapper.reloadStyle(self)
    }
}
#endif

