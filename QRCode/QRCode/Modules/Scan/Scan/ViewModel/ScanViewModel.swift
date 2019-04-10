//
//  ScanViewModel.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/10/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

final class ScanViewModel {
    
    var fakeData = [Product]()
    
    //MARK:- Private properties
    private let service = WalletSevice()
    private let fakeAmounts = ["100.4", "34.09", "55.67", "3435.56", "343.89", "890.65"]
    private let fakeProductIDs = ["2", "3", "4", "5", "6", "7", "8", "9", "10"]
    private let fakeProductImage = ["product_corel", "product_duelist", "product_googleplay", "product_warcraft"]
    private let fakeTransactionContent = ["Paid to Steam", "Refund from Google Play", "Paid to CorelDraw", "Paid to Duelyst"]
    private let fakeProductName = ["Warcraft game", "Compass PRO", "Brush plugin", "100 Diamonds"]
    private let fakeStores = ["Steam", "Google Play", "CorelDraw", "Duelyst"]
    
    init() {
        prepareData()
    }
    
    private func prepareData() {
        for i in 0...20 {
            
            var product = Product()
            product.currency = "$"
            product.review = (i % 2) == 0
            product.refund = (i % 5) == 0
            product.amount = fakeAmounts.randomElement()
            product.productID = fakeProductIDs.randomElement()
            product.userID = SessionManager.shared.userID
            product.transactionContent = fakeTransactionContent.randomElement()
            product.productImage = fakeProductImage.randomElement()
            product.productName = fakeProductName.randomElement()
            product.store = fakeStores.randomElement()
            
            fakeData.append(product)
            
        }
    }
}
