//
//  User.swift
//  FoursquareClone
//
//  Created by umut yalçın on 5.10.2023.
//

import Foundation

import ParseSwift

struct User: ParseUser {
  // Additional properties required by the ParseUser protocol
  var authData: [String : [String : String]?]?
  var originalData: Data?
  var objectId: String?
  var createdAt: Date?
  var updatedAt: Date?
  var ACL: ParseACL?
  
  // Main properties linked to the user's information
  var username: String?
  var email: String?
  var emailVerified: Bool?
  var password: String?
    
}
