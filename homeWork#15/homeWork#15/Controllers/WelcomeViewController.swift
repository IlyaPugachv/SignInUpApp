//
//  WelcomeViewController.swift
//  homeWork#15
//
//  Created by Илья Пугачёв on 28.08.23.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var infoLbl: UILabel!

    var userModel: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func continueAction() { navigationController?.popToRootViewController(animated: true) }
   
    private func setupUI() {
        infoLbl.text = "\(userModel?.name ?? "") to our cool App"
    }
}



