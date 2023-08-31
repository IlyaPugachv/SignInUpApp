import UIKit

class SignInViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
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
        
        if let _ = UserDefaultsService.getUserModel() {
            goToTabBarController()
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func signInAction() {
        errorLabel.isHidden = true
        guard let email = emailTextField.text,
              let pass = passwordTextField.text,
              let userModel = UserDefaultsService.getUserModel(),
              email == userModel.email,
              pass == userModel.pass else {
            errorLabel.isHidden = false
            return
        }
        goToTabBarController()
    }
    
    private func goToTabBarController() {
        let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func setupUI() {
        createNewAccount.backgroundColor = .white
        createNewAccount.titleLabel?.textColor = .black
        signInButton.titleLabel?.textColor = .white
    }
    
    private func roundingCorners() {
        createNewAccount.layer.cornerRadius = 15
        signInButton.layer.cornerRadius = 12
    }
}

