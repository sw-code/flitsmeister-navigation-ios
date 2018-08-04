import UIKit
import MapboxNavigation
import CarPlay

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CPApplicationDelegate {

    var window: UIWindow?

    let carPlayManager: CarPlayManager = CarPlayManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        if isRunningTests() {
            window!.rootViewController = UIViewController()
        }
        return true
    }

    private func isRunningTests() -> Bool {
        return NSClassFromString("XCTestCase") != nil
    }

    // MARK: CPApplicationDelegate

    @available(iOS 12.0, *)
    func application(_ application: UIApplication, didConnectCarInterfaceController interfaceController: CPInterfaceController, to window: CPWindow) {

        carPlayManager.application(application, didConnectCarInterfaceController: interfaceController, to: window)

        let mapTemplate = CPMapTemplate()
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainMap") as! ViewController
        interfaceController.setRootTemplate(mapTemplate, animated: false)
        window.rootViewController = viewController
    }

    @available(iOS 12.0, *)
    func application(_ application: UIApplication, didDisconnectCarInterfaceController interfaceController: CPInterfaceController, from window: CPWindow) {
        carPlayManager.application(application, didConnectCarInterfaceController: interfaceController, to: window)
    }

}
