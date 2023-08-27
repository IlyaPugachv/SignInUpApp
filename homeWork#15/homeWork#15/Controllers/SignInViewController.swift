import UIKit

class SignInViewController: UIViewController {

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
        signInButton.backgroundColor = .black
        signInButton.titleLabel?.textColor = .black
    }
    
    private func roundingCorners() {
        createNewAccount.layer.cornerRadius = 15
        signInButton.layer.cornerRadius = 12
    }
  

    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
