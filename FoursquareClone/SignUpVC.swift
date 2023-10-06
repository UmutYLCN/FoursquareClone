//
//  SignUpVC.swift
//  FoursquareClone
//
//  Created by umut yalçın on 5.10.2023.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
    
        if username.text != "" {
            if email.text != "" {
                if password.text != "" {
                    
                    signUp(username: username.text!, email: email.text!, password: password.text!)
                }else{
                    alert(message: "password alanı boş")
                }
            }else{
                alert(message: "email alanı boş")
            }
        }else{
            alert(message: "isim alanı boş")
        }
    }
    
func signUp(username: String, email: String?, password: String) {
   var newUser = User(username: username, email: email, password: password)

   newUser.signup { [weak self] result in
         switch result {
           case .success(let signedUpUser):
             self?.alert(message: "SignUp Successed", title: "\(signedUpUser)")
             self?.username.text = nil
             self?.email.text = nil
             self?.password.text = nil
             self?.dismiss(animated: true)
           case .failure(let error):
             self?.alert(message: "\(error.localizedDescription)", title: "Error")
         }
       }
     }
}
