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
    
    private var isValidEmail = false { didSet { updateContinueBtState() } }
    private var isConfPass = false { didSet { updateContinueBtState() } }
    private var passwordStrenght: PasswordStrength = .veryWeak { didSet { updateContinueBtState() } }

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
        if let passText = sender.text,
           !passText.isEmpty {
            passwordStrenght = VerivicationService.isValidPassword(pass: passText)
        } else {
            passwordStrenght = .veryWeak
        }
        errorConfirmPassLbl.isHidden = passwordStrenght != .veryWeak
        setupStrongIndicatorsViews()
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
    
    @IBAction func signInAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func continueAction() {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            
        }
    }
    
    
    
    
    
    
    
    
    private func updateContinueBtState() {
        continueButton.isEnabled = isValidEmail && isConfPass && passwordStrenght != .veryWeak
    }
    
    private func setupStrongIndicatorsViews() {
        strongPassIndicatorsViews.enumerated().forEach { index, view in
            if index <= (passwordStrenght.rawValue - 1) {
                view.alpha = 1
            } else {
                view.alpha = 0.2
            }
        }
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
