//
//  SignUpViewController.swift
//  MyNotes
//
//  Created by User on 02/08/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var retypePasswordTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var fnameTF: UITextField!
    
    let appContext =  ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sign up"
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func signupTapped(_ sender: Any) {
        
        
        if let email = emailTF.text, let password = passwordTF.text ,let fname = fnameTF.text, let lname = lnameTF.text, let retypePassword = retypePasswordTF.text ,email.isEmpty == false, password.isEmpty == false,fname.isEmpty == false, lname.isEmpty == false, password == retypePassword {
            
            let user = User(context: self.appContext)
            user.password = password
            user.email = email
            user.firstname = fname
            user.lastname  = lname
            do{
                try self.appContext.save()
                
                UserDefaults.standard.set(email, forKey: "email")
                print("user is saved")
            }catch{
                print("error in fetching data")
            }
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController
            vc?.email = email
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
    }
    
}
