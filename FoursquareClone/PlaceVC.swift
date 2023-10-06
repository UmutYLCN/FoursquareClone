//
//  PlaceVC.swift
//  FoursquareClone
//
//  Created by umut yalçın on 5.10.2023.
//

import UIKit

class PlaceVC: UIViewController {

    
    @IBOutlet weak var usernameLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        navigationItem.title = "Back4App"
    }
    

    @IBAction func handleLogOut(_ sender: Any) {
        
        // Logs out the user asynchronously
        User.logout { [weak self] result in // Handle the result (of type Result<Void, ParseError>)
          switch result {
          case .success: break
              

          case .failure(let error):
              self?.alert(message: "Failed to log out: \(error.message)", title: "Error")
          }
        }
        
    }
    

}
