import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var infoLbl: UILabel!

    var userModel: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func continueAction() {
        guard let userModel = userModel else { return }
        UserDefaultsService.saveUserModel(userModel: userModel)
        navigationController?.popToRootViewController(animated: true)
    }
   
    private func setupUI() {
        infoLbl.text = "\(userModel?.name ?? "") to our cool App"
    }
}



