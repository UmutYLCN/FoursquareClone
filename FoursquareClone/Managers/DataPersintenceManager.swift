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
    
    func createPlaceObject(name: String, type: String, atmosphere : String, latitude : String , longitude : String ,image : ParseFile) {
        
        let item = Place(name: name,type: type ,atmosphere: atmosphere, latitude: latitude,longitude: longitude,image: image)
            
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
