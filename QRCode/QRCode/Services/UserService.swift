//
//  UserService.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation
import KumulosSDK

final class UserService {
    
    enum MethodName {
        static let signUp = "signUp"
        static let login = "login"
        static let updateProfile = "updateProfile"
    }
    
    func signUp() -> ServiceRequest<EmptyResponse> {
        
        let request = ServiceRequest<EmptyResponse>()
//        Kumulos.call(MethodName.signUp, parameters: <#T##Dictionary<String, AnyObject>#>)
        return request
    }
}
