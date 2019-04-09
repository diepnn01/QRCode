//
//  LoginParams.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

struct LoginParams: CoreParameter {
    
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func toDictionary() -> [String : AnyObject] {
        let params = ["email": email,
                      "password": password]
        return params as [String : AnyObject]
    }
}
