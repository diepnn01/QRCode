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
    @IBOutlet private weak var labelContent: UILabel!
    
    static let identitfier = "profile detail cell"
    
    var item: ProfileDetailItem? {
        didSet {
            guard let model = item else {
                return
            }
            
            labelTitle.text = "\(model.title):"
            labelContent.text = model.content
        }
    }
}
