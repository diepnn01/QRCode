//
//  UIView+Extension.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/6/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    func setGradient(startColor: UIColor, endColor: UIColor) -> CAGradientLayer {
        
        let colorTop = startColor.cgColor
        let colorBottom = endColor.cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = UIScreen.main.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
}
