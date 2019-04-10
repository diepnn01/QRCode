//
//  User.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

struct User: CoreResponse, CoreParameter, Equatable {
    
    var email: String?
    var firstName: String?
    var lastName: String?
    var userID: Int?
    var avatarUrl: String?
    var phoneNumber: String?
    
    init(data: [String : Any]?) {
        
        email = data?["email"] as? String
        firstName = data?["firstName"] as? String
        lastName = data?["lastName"] as? String
        userID = data?["userID"] as? Int
        avatarUrl = data?["avatarUrl"] as? String
        phoneNumber = data?["phoneNumber"] as? String
    }
    
    func toDictionary() -> [String : AnyObject] {
        var params = [String: Any]()
        
        if let email = email {
            params["email"] = email
        }
        
        if let firstName = firstName {
            params["firstName"] = firstName
        }
        
        if let lastName = lastName {
            params["lastName"] = lastName
        }
        
        if let avatar = avatarUrl {
            params["avatarUrl"] = avatar
        }
        
        if let userId = userID {
            params["userID"] = userId
        }
        
        if let phone = phoneNumber {
            params["phoneNumber"] = phone
        }
        
        return params as [String : AnyObject]
    }
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.email == rhs.email
               && lhs.firstName == rhs.firstName
               && lhs.lastName == rhs.lastName
               && lhs.userID == rhs.userID
               && lhs.phoneNumber == rhs.phoneNumber
    }
}


