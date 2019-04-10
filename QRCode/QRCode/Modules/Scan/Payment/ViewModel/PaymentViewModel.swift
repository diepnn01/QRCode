//
//  PaymentViewModel.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/10/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

final class PaymentViewModel {
    
    //MARK:- Public properties
    var product: Product?
    var errorMessage: DataBinding<String>
    var addTransactionCompleted: DataBinding<Bool>
    //MAKR:- Private properties
    private let service = WalletSevice()
    
    init() {
        errorMessage = DataBinding(value: "")
        addTransactionCompleted = DataBinding(value: false)
    }
    
    //MARK:- Public methods
    func addTransaction() {        
        guard let product = product else {
            return
        }
        Spinner.shared.show()
        service.addNewTransaction(transaction: product).cloudResponse { [weak self](collection) in
            self?.addTransactionCompleted.value = true
            }.cloudError { [weak self](error: String, _: Int?) in
                self?.errorMessage.value = error
            }.finally {
                Spinner.shared.dismiss()
        }
    }
}
