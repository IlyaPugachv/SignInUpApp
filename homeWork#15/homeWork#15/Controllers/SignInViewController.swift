import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel! {
        didSet { errorLabel.isHidden = true }
    }
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var createNewAccount: UIButton! {
        didSet { createNewAccount.backgroundColor = .red }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        signInButton.isEnabled = false
        createNewAccount.backgroundColor = .red
     
    }
    
//    setThisTimeBtn.backgroundColor = .black
//    setThisTimeBtn.layer.cornerRadius = 20
//    setThisTimeBtn.setImage(nil, for: .normal)
//    clearButton.setImage(nil, for: .normal)

    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
