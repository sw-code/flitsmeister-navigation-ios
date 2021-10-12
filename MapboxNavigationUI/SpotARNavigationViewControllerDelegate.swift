import MapboxNavigation
import MapboxDirections

extension SpotARNavigationViewController: NavigationViewControllerDelegate {
    // By default, when the user arrives at a waypoint, the next leg starts immediately.
    // If you implement this method, return true to preserve this behavior.
    // Return false to remain on the current leg, for example to allow the user to provide input.
    // If you return false, you must manually advance to the next leg. See the example above in `confirmationControllerDidConfirm(_:)`.
    public func navigationViewController(_ navigationViewController: NavigationViewController, didArriveAt waypoint: Waypoint) -> Bool {
        delegate?.didCancel()
        return true
    }
    
    // Called when the user hits the exit button.
    // If implemented, you are responsible for also dismissing the UI.
    public func navigationViewControllerDidDismiss(_ navigationViewController: NavigationViewController, byCanceling canceled: Bool) {
        delegate?.didCancel()
    }
}
