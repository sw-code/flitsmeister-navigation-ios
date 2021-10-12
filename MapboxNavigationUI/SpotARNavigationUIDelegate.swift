import UIKit

public protocol SpotARNavigationUIDelegate {
    func wantsToPresent(viewController: UIViewController) -> Void
    func didArrive() -> Void
    func didCancel() -> Void
}
