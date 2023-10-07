//
//  Place.swift
//  FoursquareClone
//
//  Created by umut yalçın on 7.10.2023.
//

import Foundation
import ParseSwift
import UIKit

struct Place : ParseObject {
    
    //MARK: Zorunlu gelen özellikler
    var originalData: Data?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseSwift.ParseACL?
    
    //MARK: Sizin belirlediğiniz özellikler
    var name : String?
    var type : String?
    var atmosphere : String?
    var latitude : String?
    var longitude : String?
    var image : ParseFile?
}
