import UIKit

class VerificationsVC: UIViewController {

    var userModel: UserModel?
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? VerificationsVC,
              let userModel = sender as? UserModel else { return }
        destVC.userModel = userModel
    }
}
