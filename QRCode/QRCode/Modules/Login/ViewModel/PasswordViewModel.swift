//
//  PasswordViewModel.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

final class PasswordViewModel: ValidationViewModel {
    
    var errorMessage = "message.invalid.password".localize()
    
    var errorValue: DataBinding<String> = DataBinding()
    var data:  DataBinding<String> = DataBinding()
    
    func validateCredentials() -> Bool {
        guard let password = data.value, isValidPassword(passwordString: password) else {
            errorValue.value = errorMessage
            return false
        }
        errorValue.value = ""
        return true
    }
    
    /* Password has to contain at least 1 Uppercase, 1 Lowercase, 1 Number, and Total greater than 8 Characters.
     */
    private func isValidPassword(passwordString: String) -> Bool {
        
        let lengthRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d$@$!%*?&]{8,}"
        let regexLength = NSPredicate(format:"SELF MATCHES %@", lengthRegEx)
        guard regexLength.evaluate(with: passwordString) else {
            return false
        }
        
        return true
    }
}
