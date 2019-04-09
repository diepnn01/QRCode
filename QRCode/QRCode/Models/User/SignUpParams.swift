//
//  SignUpParams.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

struct SignUpParams: CoreParameter {
    
    var email: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    
    func toDictionary() -> [String : AnyObject] {
        var params = [String: Any]()
        if let email = email {
            params["email"] = email
        }
        
        if let password = password {
            params["password"] = password
        }
        
        if let firstName = firstName {
            params["firstName"] = firstName
        }
        
        if let lastName = lastName {
            params["lastName"] = lastName
        }
        return params as [String : AnyObject]
    }
}
