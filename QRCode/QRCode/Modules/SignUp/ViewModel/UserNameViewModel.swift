//
//  UserNameViewModel.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

final class UserNameViewModel {
    
    var errorMessage: String = "message.firstName.LastName.required".localize()

    var firstName: DataBinding<String> = DataBinding(value: "")
    var lastName: DataBinding<String> = DataBinding(value: "")
    var errorValue: DataBinding<String> = DataBinding(value: "")
    
    func validateCredentials() -> Bool {
        guard let firstValue = firstName.value, !firstValue.isEmpty,
            let lastValue = lastName.value, !lastValue.isEmpty else {
                errorValue.value = errorMessage
                return false
        }
        errorValue.value = ""
        return true
    }
}
