//
//  ProfileDetailTableViewCell.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class ProfileDetailTableViewCell: UITableViewCell {

    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var textFieldContent: UITextField!
    
    static let identitfier = "profile detail cell"
    
    var onValueChanged: ((_ content: String?) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textFieldContent.delegate = self
    }
    
    func fillData(model: ProfileDetailItem?, enableEdit: Bool = true) {
        guard let model = model else {
            return
        }
        
        labelTitle.text = "\(model.title):"
        textFieldContent.text = model.content
        textFieldContent.placeholder = model.placeHolder
        textFieldContent.isEnabled = enableEdit
    }
}

extension ProfileDetailTableViewCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        onValueChanged?(textField.text)
    }
}
