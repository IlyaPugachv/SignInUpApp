import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var yourEmailLbl: UILabel!
    
    var userModel: UserModel?
    
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
         yourEmailLbl.text = "\(userModel?.email ?? "") to our cool App"
        }
   
   
  
    

}


