import UIKit

class ProfileViewController: UIViewController {

    
    @IBAction func deleteAccountAction() {
        UserDefaultsService.cleanUserDefaults()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func logOutAction() {
        navigationController?.popToRootViewController(animated: true)
    }
}
