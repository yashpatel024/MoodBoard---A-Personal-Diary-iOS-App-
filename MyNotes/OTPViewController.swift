//
//  OTPViewController.swift
//  MyNotes
//
//  Created by User on 03/08/22.
//

import UIKit

class OTPViewController: UIViewController {

    @IBOutlet weak var emailTF: UILabel!
    var email:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTF.text = email
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        let alertController = showAlertViewController(title: "Success", message: "OTP has been verified", completionHandler: {
//            self.navigationController?.popViewController(animated: true)
            // SHOW THE ROOT VIEW CONTROLLER
            let vc = Notes_MainScreenViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        })
        self.present(alertController, animated: true,completion: nil)
    }
}
