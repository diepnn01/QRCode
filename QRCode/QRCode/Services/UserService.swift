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
    
    /* Input: Signup parameters email and password
     * Response: User object
     */
    func signUp(params: SignUpParams) -> ServiceRequest<User> {
        let request = ServiceRequest<User>()
        Kumulos.call(MethodName.signUp, parameters: params.toDictionary()).success { (response, _) in
            request.handleResponseJSONArray(response: response)
            }.failure { (error: Error?, _) in
                request.handleError(error: error)
        }
        return request
    }
    
    /* Input: Login parameters email & password & firstName & lastName
     * Response: User object
     */
    func login(params: LoginParams) -> ServiceRequest<User> {
        let request = ServiceRequest<User>()
        Kumulos.call(MethodName.login, parameters: params.toDictionary()).success { (response, _) in
            request.handleResponseJSONArray(response: response)
            }.failure { (err, _) in
                request.handleError(error: err)
        }
        return request
    }
    
    /* Input: User Information
     * Response: User object
     */
    func updateProfile(params: User) -> ServiceRequest<User> {
        let request = ServiceRequest<User>()
        Kumulos.call(MethodName.updateProfile, parameters: params.toDictionary()).success { (response, _) in
            request.handleResponseJSONArray(response: response)
            }.failure { (error: Error?, _) in
                request.handleError(error: error)
        }
        return request
    }
}
