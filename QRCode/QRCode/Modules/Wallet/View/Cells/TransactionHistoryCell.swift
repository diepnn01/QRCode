//
//  TransactionHistoryCell.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/8/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class TransactionHistoryCell: UITableViewCell {

   static let identifier = "transaction history cell"
    
    //MARK:- Outlets
    @IBOutlet private weak var storeImage: UIImageView!
    @IBOutlet private weak var labelProductName: UILabel!
    @IBOutlet private weak var labelTransactionContent: UILabel!
    @IBOutlet private weak var labelPrice: UILabel!
    @IBOutlet  private weak var transactionNote: UILabel!
    
    var transaction: Transaction? {
        didSet {
            guard let model = transaction else {
                return
            }
            
            labelProductName.text = model.productName
            labelTransactionContent.text = model.transactionContent
            if let imageName = model.productImage {
                storeImage.image = UIImage(named: imageName)
            }
            
            transactionNote.isHidden = true
            if let currency = model.currency, let amount = model.amount {
                var priceText = "- \(currency) \(amount)"
                switch model.status {
                case .done:
                    labelPrice.textColor = UIColor.colorFromHex("3D4956")
                case .refund:
                    priceText = priceText.replacingOccurrences(of: "-", with: "")
                    labelPrice.textColor = UIColor.colorFromHex("1FBC40")
                case .review:
                    labelPrice.textColor = UIColor.colorFromHex("F25B59")
                    transactionNote.isHidden = false
                }
                
                labelPrice.text = priceText
            }
        }
    }

}
