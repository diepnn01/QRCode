//
//  ValidationViewModel.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import Foundation

protocol ValidationViewModel {
    
    var errorMessage: String { get }
    
    // Observbles
    var data: DataBinding<String> {get set}
    var errorValue: DataBinding<String> { get set }
    
    // Validation
    func validateCredentials() -> Bool
}
