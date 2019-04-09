//
//  User.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

struct User: CoreResponse {
    
    var email: String?
    var firstName: String?
    var lastName: String?
    var userID: String?
    
    
    init(data: [String : Any]?) {
        email = data?["email"] as? String
        firstName = data?["firstName"] as? String
        lastName = data?["lastName"] as? String
        userID = data?["id"] as? String
    }
}
