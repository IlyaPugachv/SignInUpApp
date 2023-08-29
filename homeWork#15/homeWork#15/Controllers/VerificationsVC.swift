import UIKit

class VerificationsVC: BaseViewController {

    var userModel: UserModel?
    let randomInt = Int.random(in: 100000 ... 999999)
    var sleepTime = 3
    
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var secretCodeTF: UITextField!
    @IBOutlet weak var errorTF: UILabel!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
    }
    
    @IBAction func codeTFAction(_ sender: UITextField) {
        errorTF.isHidden = true
        guard let text = sender.text, !text.isEmpty, text == randomInt.description else {
            errorTF.isHidden = false
            sender.isUserInteractionEnabled = false
            errorTF.text = "Error code. Please wait \(sleepTime) seconds"
            
            let dispatchAfter = DispatchTimeInterval.seconds(sleepTime)
            let deadLine = DispatchTime.now() + dispatchAfter
            DispatchQueue.main.asyncAfter(deadline: deadLine) {
                sender.isUserInteractionEnabled = true
                self.errorTF.isHidden = true
                self.sleepTime *= 2
            }
            return
        }
        performSegue(withIdentifier: "goToWelcomeScreen", sender: nil)
    }
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        centerConstraint.constant -= keyboardSize.height / 2
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        centerConstraint.constant += keyboardSize.height / 2
    }

    private func setupUI() {
        infoLbl.text = "Please enter code \(randomInt) from \(userModel?.email ?? "")"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? WelcomeViewController else { return }
        destVC.userModel = userModel
    }
}
