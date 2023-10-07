//
//  ViewController.swift
//  FoursquareClone
//
//  Created by umut yalçın on 4.10.2023.
//

import UIKit
import ParseSwift

class LoginVC: UIViewController {

    
    @IBOutlet weak var usernametf: UITextField!
    
    @IBOutlet weak var passwordtf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           
        
        
    }
    @IBAction func donthaveacountClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    
    @IBAction func signInClicked(_ sender: UIButton) {
        if usernametf.text != "" && passwordtf.text != "" {
            logIn(with: usernametf.text!, password: passwordtf.text!)
        }else {
            alert(message: "Do not leave the fields blank.")
        }
    }
    
    
    private func logIn(with username: String, password: String) {
    
        User.login(username: username, password: password) { [weak self] result in // Handle the result (of type Result<User, ParseError>)
          switch result {
          case .success(let loggedInUser):
            self?.usernametf.text = nil
            self?.passwordtf.text = nil
              self?.performSegue(withIdentifier: "toPlaceVC", sender: nil)
              
          case .failure(let error):
              self?.alert(message: "Failed to log in: \(error.message)",title: "Error")
          }
        }
    }
}

