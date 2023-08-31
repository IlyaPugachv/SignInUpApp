import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var yourNameLbl: UILabel!
    @IBOutlet weak var yourEmailLbl: UILabel!
    
    var userModel  = UserDefaultsService.getUserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func deleteAccountAction() {
        UserDefaultsService.cleanUserDefaults()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func logOutAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func setupUI() {
        yourEmailLbl.text = "\(userModel?.email ?? "")"
        yourNameLbl.text = "\(userModel?.name ?? "")"
    }
}


