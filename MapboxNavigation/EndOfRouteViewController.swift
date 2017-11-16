import UIKit
import MapboxDirections

enum ConstraintSpacing: CGFloat {
    case closer = 16.0
    case further = 45.0
}

class EndOfRouteViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var primary: UILabel!
    @IBOutlet weak var secondary: UILabel!
    @IBOutlet weak var endNavigationButton: UIButton!
    @IBOutlet weak var stars: RatingControl!
    @IBOutlet weak var commentView: UITextView!
    @IBOutlet weak var showCommentView: NSLayoutConstraint!
    @IBOutlet weak var hideCommentView: NSLayoutConstraint!
    @IBOutlet weak var ratingCommentsSpacing: NSLayoutConstraint!
    
    //MARK: - Properties
    lazy var geocoder: CLGeocoder = CLGeocoder()
    var dismiss: (() -> Void)?
    var comment: String?
    var rating: Int = 0 {
        didSet {
            rating == 0 ? hideComments() : showComments()
        }
    }
    
    open var destination: Waypoint? {
        didSet {
            guard isViewLoaded else { return }
            updateInterface()
        }
    }

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        clearInterface()
        stars.didChangeRating = { (new) in self.rating = new }
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    //MARK: - IBActions
    @IBAction func endNavigationPressed(_ sender: Any) {
        dismiss?()
    }
    
    //MARK: - Private Functions
    private func showComments(animated: Bool = true) {
        showCommentView.isActive = true
        hideCommentView.isActive = false
        ratingCommentsSpacing.constant = ConstraintSpacing.closer.rawValue
        
        let layout = view.layoutIfNeeded
        
        animated ? UIView.animate(withDuration: 0.3, animations: layout) : layout()
    }
    
    private func hideComments(animated: Bool = true) {
        showCommentView.isActive = false
        hideCommentView.isActive = true
        ratingCommentsSpacing.constant = ConstraintSpacing.further.rawValue
        
        let layout = view.layoutIfNeeded
        
        animated ? UIView.animate(withDuration: 0.3, animations: layout) : layout()
    }
    
    
    private func updateInterface() {
        primary.text = string(for: destination)
        guard let coordinate = destination?.coordinate else { return }
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { (places, error) in
            guard let place = places?.first,
                  let city = place.locality,
                  let state = place.administrativeArea,
                  error == nil else { return self.secondary.text = nil }
            self.secondary.text = "\(city), \(state)"
        }
    }

    private func clearInterface() {
        [primary, secondary].forEach { $0.text = nil }
        stars.rating = 0
    }
    
    //FIXME: Temporary Placeholder
    private func string(for destination: Waypoint?) -> String {
        guard let destination = destination else { return "Unknown" }
        guard destination.name?.isEmpty ?? false else { return destination.name! }
        let coord = destination.coordinate
        return String(format: "%.2f", coord.latitude) + "," + String(format: "%.2f", coord.longitude)
    }
}

//MARK: - UITextViewDelegate
extension EndOfRouteViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else { return true }
        textView.resignFirstResponder()
        return false
    }
}

//MARK: - Keyboard Handling

extension EndOfRouteViewController {
    fileprivate func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(EndOfRouteViewController.keyboardWillShow(notification:)), name:.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EndOfRouteViewController.keyboardWillHide(notification:)), name:.UIKeyboardWillHide, object: nil)
        
    }
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let curve = UIViewAnimationCurve(rawValue: userInfo[UIKeyboardAnimationCurveUserInfoKey] as! Int)
        let options = (duration: userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double,
                       curve: curve!)
        let keyboard = (size: (userInfo[UIKeyboardFrameBeginUserInfoKey] as! CGRect).size,
                        offset: (userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect).size)
        
        let animation = {
            //TODO: EDGE CASE - What if someone enables predictive while keyboard is presented?
           if (keyboard.size.height == keyboard.offset.height) { //predictive is off
                self.view.frame.origin.y -= keyboard.size.height
            } else { //predictive is on
                self.view.frame.origin.y += keyboard.size.height - keyboard.offset.height
            }
        }
        
        let opts = UIViewAnimationOptions(curve: options.curve)
        UIView.animate(withDuration: options.duration, delay: 0, options: opts, animations: animation, completion: nil)
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! CGRect).size
        let curve = UIViewAnimationCurve(rawValue: userInfo[UIKeyboardAnimationCurveUserInfoKey] as! Int)
        let options = (duration: userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double,
                       curve: curve!)
        
        let animation = { self.view.frame.origin.y += keyboardSize.height }
        let opts = UIViewAnimationOptions(curve: options.curve)
        UIView.animate(withDuration: options.duration, delay: 0, options: opts, animations: animation, completion: nil)
    }
}

fileprivate extension UIViewAnimationOptions {
    init(curve: UIViewAnimationCurve) {
        switch curve {
        case .easeIn:
            self = .curveEaseIn
        case .easeOut:
            self = .curveEaseOut
        case .easeInOut:
            self = .curveEaseInOut
        case .linear:
            self = .curveLinear
        }
    }
}
