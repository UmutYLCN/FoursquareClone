//
//  PlaceVC.swift
//  FoursquareClone
//
//  Created by umut yalçın on 5.10.2023.
//

import UIKit
import ParseSwift

class PlaceVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var placeNameArray = [String]()
    var placeIdArrya = [String]()
    
    var selectedPlaceId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
       
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogOut))
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTapped))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getDataFromParse()
    }
    
    @objc func addTapped(){
        performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
    }
    

    @objc func handleLogOut(_ sender: Any) {
        
        // Logs out the user asynchronously
        User.logout { [weak self] result in // Handle the result (of type Result<Void, ParseError>)
          switch result {
          case .success: 
              self?.performSegue(withIdentifier: "toLoginVC", sender: nil)

          case .failure(let error):
              self?.alert(message: "Failed to log out: \(error.message)", title: "Error")
          }
        }
        
    }
    
    func getDataFromParse(){
        let query = Place.query()
        
        
        query.find { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let items):
                    
                    placeNameArray.removeAll(keepingCapacity: false)
                    placeIdArrya.removeAll(keepingCapacity: false)
                    for item in items {
                        if let placeName = item.name as? String {
                            placeNameArray.append(placeName)
                        }
                        if let placeId = item.objectId as? String {
                            placeIdArrya.append(placeId)
                        }
                    }
                        
                    tableView.reloadData()
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.alert(message: "\(error.message)")
                    }
                }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as? DetailVC
            destinationVC?.choosenPlaceId = selectedPlaceId
        }
    }

}


extension PlaceVC :UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceId = placeIdArrya[indexPath.row]
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
    }
    
    
    
    
    
}
