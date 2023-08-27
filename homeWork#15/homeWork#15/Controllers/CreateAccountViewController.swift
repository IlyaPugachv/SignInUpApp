import UIKit

class CreateAccountViewController: BaseViewController {
    
    // Enter your email
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorEmailLbl: UILabel!
    
    // Enter your name
    @IBOutlet weak var nameTextField: UITextField!
    
    // Create strong password
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorPasswrodLbl: UILabel!
    
    // strongPassIndicatorsViews
    @IBOutlet var strongPassIndicatorsViews: [UIView]!
    
    // confirmPassTextField
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var errorConfirmPassLbl: UILabel!
    
    // continueButton
    @IBOutlet weak var continueButton: UIButton!
    
    // scrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var isValidEmail = false
    private var isConfPass = false
//    private var passwordStrenght

    override func viewDidLoad() {
        super.viewDidLoad()
        strongPassIndicatorsViews.forEach { view in view.alpha = 0.2 }
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
    }
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerivicationService.isValidEmail(email: email) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
        errorEmailLbl.isHidden = isValidEmail
    }
    
    @IBAction func passTFAction(_ sender: UITextField) {
    }
    
    @IBAction func confPassTFAction(_ sender: UITextField) {
        if let confPassText = sender.text,
           !confPassText.isEmpty,
           let passText = passwordTextField.text,
           !passText.isEmpty {
            isConfPass = VerivicationService.isPassConfirm(pass1: passText, pass2: confPassText)
        } else {
            isConfPass = false
        }
        errorConfirmPassLbl.isHidden = isConfPass
    }
    
    
    
    
    
    
    
    
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
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
