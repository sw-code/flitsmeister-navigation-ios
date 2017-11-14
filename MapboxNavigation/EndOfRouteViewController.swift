import UIKit

class EndOfRouteViewController: UIViewController {

    @IBOutlet weak var endNavigationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        
        view.layer.mask = maskLayer
    }

    var dismiss: (() -> Void)?
    
    @IBAction func endNavigationPressed(_ sender: Any) {
        dismiss?()
    }
}
