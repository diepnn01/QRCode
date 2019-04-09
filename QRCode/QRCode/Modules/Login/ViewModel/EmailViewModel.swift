//
//  EmailViewModel.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

final class EmailViewModel: ValidationViewModel {
    
    var errorMessage: String = "message.invalid.email".localize()
    
    var errorValue: DataBinding<String> = DataBinding()
    var data:  DataBinding<String> = DataBinding()
    

    func validateCredentials() -> Bool {
        guard let email = data.value, validatePattern(emailString: email) else {
            errorValue.value = errorMessage
            return false
        }
        errorValue.value = ""
        return true
    }
    
    //MARK:- Private methods
    func validatePattern(emailString: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: emailString)
    }
}
