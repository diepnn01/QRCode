//
//  ProfileItemCell.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/8/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class ProfileItemCell: UITableViewCell {

    static let identifier = "ProfileItemCell"
    
    @IBOutlet private weak var labelContent: UILabel!
    @IBOutlet private weak var imageViewLeft: UIImageView!
    
    var model: ProfileItem? {
        didSet {
            
            guard let model = model else {
                return
            }
            
            labelContent.text = model.title
            imageViewLeft.image = UIImage(named: model.iconName)
        }
    }
    
}
