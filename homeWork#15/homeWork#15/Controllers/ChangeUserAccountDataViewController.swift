import UIKit

class ChangeUserAccountDataViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var strongPassword: [UIView]!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var doneButton: UIButton! {
        didSet { doneButton.isEnabled = false }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var isValidEmail = false { didSet { updateContinueBtState() } }
    private var isConfPass = false { didSet { updateContinueBtState() } }
    private var passwordStrenght: PasswordStrength = .veryWeak { didSet { updateContinueBtState() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        strongPassword.forEach { view in view.alpha = 0.2 }
        startKeyboardObserver()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - IBAction
    
    @IBAction func emailTextFieldAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerivicationService.isValidEmail(email: email) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
    }
    
    @IBAction func passwordTextFieldAction(_ sender: UITextField) {
        if let passText = sender.text,
           !passText.isEmpty {
            passwordStrenght = VerivicationService.isValidPassword(pass: passText)
        } else {
            passwordStrenght = .veryWeak
        }
        setupStrongIndicatorsViews()
    }
    
    @IBAction func confirmPassTFAction(_ sender: UITextField) {
        if let confPassText = sender.text,
           !confPassText.isEmpty,
           let passText = passwordTextField.text,
           !passText.isEmpty {
            isConfPass = VerivicationService.isPassConfirm(pass1: passText, pass2: confPassText)
        } else {
            isConfPass = false
        }
    }
    
    @IBAction func doneBtnAction(_ sender: UIButton) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            let userModel = UserModel(name: nameTextField.text, email: email, pass: password)
            UserDefaultsService.saveUserModel(userModel: userModel)
            dismiss(animated: true)
        }
    }
    
    @IBAction func eyeButtonAction(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            if let image = UIImage(systemName: "eye.fill") {
                sender.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(systemName: "eye.slash.fill") {
                sender.setImage(image, for: .normal)
            }
        }
    }
    
    private func updateContinueBtState() {
        doneButton.isEnabled = isValidEmail && isConfPass && passwordStrenght != .veryWeak
    }
    
    // MARK: - Working with the keyboard
    
    private func setupStrongIndicatorsViews() {
        strongPassword.enumerated().forEach { index, view in
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
}
