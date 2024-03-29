import UIKit

class CreateAccountViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorEmailLbl: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorPasswrodLbl: UILabel!
    @IBOutlet weak var passEyeButton: UIButton!
    @IBOutlet var strongPassIndicatorsViews: [UIView]!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var errorConfirmPassLbl: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Checking information
    
    private var isValidEmail = false { didSet { updateContinueBtState() } }
    private var isConfPass = false { didSet { updateContinueBtState() } }
    private var passwordStrenght: PasswordStrength = .veryWeak { didSet { updateContinueBtState() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        strongPassIndicatorsViews.forEach { view in view.alpha = 0.2 }
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
        setupUI()
    }
    
    // MARK: - IBAction
    
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
    
    @IBAction func passwordDisplay(_ sender: UIButton) {
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
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueAction() {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            let userModel = UserModel(name: nameTextField.text, email: email, pass: password)
            performSegue(withIdentifier: "goToVerifScreen", sender: userModel)
        }
    }
    
    // MARK: - UpdateContinueBtState and setupStrongIndicatorsViews
    
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
    
    // MARK: - Working with the keyboard
    
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
    
    private func setupUI() {
        signInButton.titleLabel?.textColor = .white
        continueButton.titleLabel?.textColor = .white
        continueButton.layer.cornerRadius = 15
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? VerificationsVC,
              let userModel = sender as? UserModel else { return }
            destVC.userModel = userModel
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    

     

