//
//  FruitModel.swift
//  FoursquareClone
//
//  Created by umut yalçın on 5.10.2023.
//

import Foundation
import ParseSwift

struct Fruit : ParseObject {
    //MARK: Zorunlu gelen özellikler
    var originalData: Data?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseSwift.ParseACL?
    
    //MARK: Sizin belirlediğiniz özellikler
    var name : String?
    var calories : String?
}
