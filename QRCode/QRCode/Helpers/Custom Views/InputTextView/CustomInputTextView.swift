//
//  CustomInputTextView.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/7/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

@IBDesignable class CustomInputTextView: BaseCustomView {
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    
    var errorMessage: String? {
        didSet {
            guard let error = errorMessage, !error.isEmpty else {
                errorLabel.isHidden = true
                return
            }
            
            errorLabel.isHidden = false
            errorLabel.text = error
        }
    }
    
    var text: String? {
        return textField.text
    }
    
    @IBInspectable var placeHolder: String? {
        didSet {
            textField.placeholder = placeHolder
        }
    }
    
    @IBInspectable var entrySecure: Bool = false {
        didSet {
            textField.isSecureTextEntry = entrySecure
        }
    }
}
