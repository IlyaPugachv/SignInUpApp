import UIKit

class SignInViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel! {
        didSet { errorLabel.isHidden = true }
    }
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var createNewAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        roundingCorners()
    }
    
    private func setupUI() {
        signInButton.isEnabled = false
        createNewAccount.backgroundColor = .white
        createNewAccount.titleLabel?.textColor = .black
        signInButton.titleLabel?.textColor = .white
    }
    
    private func roundingCorners() {
        createNewAccount.layer.cornerRadius = 15
        signInButton.layer.cornerRadius = 12
    }
}

