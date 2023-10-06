//
//  DataPersintenceManager.swift
//  FoursquareClone
//
//  Created by umut yalçın on 5.10.2023.
//

import Foundation
import ParseSwift
import UIKit


class DataPersintenceManager {
    
    static let shared = DataPersintenceManager()
    
    func createObject(name: String, calories: String?) {
        
        let item = Fruit(name: name, calories: calories)
            
        item.save { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(_):
                
                print("uploaded")
               
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    

}
