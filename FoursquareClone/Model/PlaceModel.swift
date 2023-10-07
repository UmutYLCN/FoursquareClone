//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by umut yalçın on 6.10.2023.
//

import Foundation
import UIKit


class PlaceModel {
    
    static let shared = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()  
    var placeLatitude = ""
    var placeLongitude = ""
    private init(){}
}
