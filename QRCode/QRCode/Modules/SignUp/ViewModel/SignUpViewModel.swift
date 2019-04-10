//
//  SignUpViewModel.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/7/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

final class SignUpViewModel {
    
    //MARK:- Private properties
    private let service = UserService()
    private var signUpParams = SignUpParams()
    
    //MARK:- Public properties
    var emailViewModel = EmailViewModel()
    var passwordViewModel = PasswordViewModel()
    var userNameViewModel = UserNameViewModel()
    
    var errorMessage: DataBinding<String> = DataBinding(value: "")
    var signupCompleted: DataBinding<Bool> = DataBinding(value: false)
    
    func validateCredentials() -> Bool {
        
        // validate email
        guard emailViewModel.validateCredentials() else {
            errorMessage.value = emailViewModel.errorMessage
            return false
        }
        signUpParams.email = emailViewModel.data.value
        
        // validate password
        guard passwordViewModel.validateCredentials() else {
            errorMessage.value = passwordViewModel.errorMessage
            return false
        }
        signUpParams.password = passwordViewModel.data.value
        
        // validate user's name
        guard userNameViewModel.validateCredentials() else {
            errorMessage.value = userNameViewModel.errorMessage
            return false
        }
        errorMessage.value = ""
        signUpParams.firstName = userNameViewModel.firstName.value
        signUpParams.lastName = userNameViewModel.lastName.value
        return true
    }
    
    func signUp() {
        Spinner.shared.show()
        service.signUp(params: signUpParams).cloudResponse { [weak self](collection: UserCollection) in
            let user = collection.objectList.first
            guard let userID = user?.userID else {
                return
            }
            SessionManager.shared.user?.value = user
            SessionManager.shared.userID = "\(userID)"
            self?.signupCompleted.value = true
            }.cloudError { [weak self](errorMsg: String, _: Int?) in
                self?.errorMessage.value = errorMsg
            }.finally {
                Spinner.shared.dismiss()
        }
    }
}
