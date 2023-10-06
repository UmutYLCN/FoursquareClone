//
//  HomeController.swift
//  FoursquareClone
//
//  Created by umut yalçın on 5.10.2023.
//

import UIKit
import ParseSwift

class HomeController: UIViewController {
    
  /// When set, it updates the usernameLabel's text with the user's username.
  var user: User? {
    didSet {
      usernameLabel.text = "Hello \(user?.username ?? "N/A")!"
    }
  }
    
  private let usernameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = .boldSystemFont(ofSize: 18)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
    
  private let logOutButton: UIButton = {
    let button = UIButton(type: .roundedRect)
    button.setTitle("Log out", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
    
  override func viewDidLoad() {
    super.viewDidLoad()
        
    // Sets up the layout (usernameLabel and logOutButton)
    view.backgroundColor = .systemBackground
    navigationItem.hidesBackButton = true
    navigationItem.title = "Back4App"
    view.addSubview(usernameLabel)
    view.addSubview(logOutButton)
        
    usernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
    usernameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
    logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8).isActive = true
    logOutButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
    // Adds the method that will be called when the user taps the logout button
    logOutButton.addTarget(self, action: #selector(handleLogOut), for: .touchUpInside)
  }
    
    @objc private func handleLogOut() {
        
        // Logs out the user asynchronously
        User.logout { [weak self] result in // Handle the result (of type Result<Void, ParseError>)
          switch result {
          case .success:
            // After the logout succeeded we dismiss the home screen
            self?.navigationController?.popViewController(animated: true)
          case .failure(let error):
              self?.alert(message: "Failed to log out: \(error.message)", title: "Error")
          }
        }
      }
}
