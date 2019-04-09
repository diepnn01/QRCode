//
//  User.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

struct User: CoreResponse, CoreParameter {
    
    var email: String?
    var firstName: String?
    var lastName: String?
    var userID: String?
    var avatarUrl: String?
    
    init(data: [String : Any]?) {
        email = data?["email"] as? String
        firstName = data?["firstName"] as? String
        lastName = data?["lastName"] as? String
        userID = data?["id"] as? String
        avatarUrl = data?["avatarUrl"] as? String
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
        
        return params as [String : AnyObject]
    }
}
