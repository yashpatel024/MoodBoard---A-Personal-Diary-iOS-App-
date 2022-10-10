//
//  ViewController.swift
//  MyNotes
//
//  Created by User on 01/08/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var logoImgView: UIImageView!
    
    @IBOutlet weak var illustrationImgView: UIImageView!
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    let appContext =  ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    var records:[User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    
    
    @IBAction func loginBtnTapped(_ sender: Any) {
       
        if let email = emailTF.text, let password = passwordTF.text, email.isEmpty == false, password.isEmpty == false{
            if validateUser(email: email,password: password) == true{
                // successfully logged in
                print("successfully loged in")
                UserDefaults.standard.set(email, forKey: "email")
                let vc = Notes_MainScreenViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }else{
                let alertController =  showAlertViewController(title: "Bummer!", message: "Email or password is not matching", completionHandler: {
         //            self.navigationController?.popViewController(animated: true)
                 })
                 self.present(alertController, animated: true,completion: nil)
            }
        }else{
            let alertController =  showAlertViewController(title: "Bummer!", message: "Please enter Email or password", completionHandler: {
     //            self.navigationController?.popViewController(animated: true)
             })
             self.present(alertController, animated: true,completion: nil)
        }
    }
    
   
    
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        fetchAllRecords()
    }
    @IBAction func forgotpasswordTapped(_ sender: Any) {
        // needs to implement this.
        
    }
    
    func validateUser(email:String,password:String) -> Bool{
        return self.records.filter { model in
            return model.email == email && model.password == password
        }.count > 0
    }
    
    func fetchAllRecords(){
        do{
             self.records = try self.appContext.fetch(User.fetchRequest())
        }catch{
             print("error in fetching records")
        }
    }
    
    @IBAction func signupBtnTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

