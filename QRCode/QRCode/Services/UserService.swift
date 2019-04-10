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
        static let profileDetail = "getProfileDetail"
    }
    
    /* Input: Signup parameters email and password
     * Response: User object
     */
    func signUp(params: SignUpParams) -> ServiceRequest<UserCollection> {
        let request = ServiceRequest<UserCollection>()
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
    func login(params: LoginParams) -> ServiceRequest<UserCollection> {
        let request = ServiceRequest<UserCollection>()
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
    func updateProfile(params: User) -> ServiceRequest<EmptyResponse> {
        let request = ServiceRequest<EmptyResponse>()
        Kumulos.call(MethodName.updateProfile, parameters: params.toDictionary()).success { (response, _) in
            request.handleResponseJSON(response: response)
            }.failure { (error: Error?, _) in
                request.handleError(error: error)
        }
        return request
    }
    
    func getProfileDetail(userID: String) -> ServiceRequest<UserCollection> {
        let request = ServiceRequest<UserCollection>()
        let params = ["userID": userID]
        Kumulos.call(MethodName.profileDetail, parameters: params as Dictionary<String, AnyObject>).success { (response, _) in
            request.handleResponseJSONArray(response: response)
            }.failure { (error, _) in
                request.handleError(error: error)
        }
        return request
    }
}
