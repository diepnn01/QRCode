//
//  LoginViewModel.swift
//  
//
//  Created by Diep Nguyen on 4/6/19.
//

import UIKit

enum LoginInputText {
    case email
    case password
}

final class LoginViewModel {

    private let service = UserService()
    
    // Initialize ViewModel's
    let emailViewModel = EmailViewModel()
    let passwordViewModel = PasswordViewModel()
    
    var errorMessage: DataBinding<String> = DataBinding(value: "")
    var loginCompleted: DataBinding<Bool> = DataBinding(value: false)
    
    func validateCredentials() -> Bool {
       
        guard emailViewModel.validateCredentials() else {
            errorMessage.value = emailViewModel.errorMessage
            return false
        }
        
        guard passwordViewModel.validateCredentials() else {
            errorMessage.value = passwordViewModel.errorMessage
            return false
        }
        return true
    }
    
    func login(email: String?, password: String?) {
        
        emailViewModel.data.value = email
        passwordViewModel.data.value = password
        
        guard validateCredentials() else {
            return
        }
        
        Spinner.shared.show()
        let params = LoginParams(email: email!, password: password!)
        service.login(params: params).cloudResponse { [weak self](collection: UserCollection) in
            let user = collection.objectList.first
            guard let userID = user?.userID else {
                return
            }
            SessionManager.shared.user?.value = user
            SessionManager.shared.userID = "\(userID)"
            self?.loginCompleted.value = true
            }.cloudError { [weak self](msgErr: String, _: Int?) in
                self?.errorMessage.value = msgErr
            }.finally {
                Spinner.shared.dismiss()
        }
    }
    
}
