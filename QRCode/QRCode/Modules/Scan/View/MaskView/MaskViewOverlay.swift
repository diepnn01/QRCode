//
//  MaskViewOverlay.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/8/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//


import UIKit

@IBDesignable class MaskViewOverlay: BaseCustomView {
    
    @IBOutlet private weak var croppedView: UIView!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if self.croppedView != nil {
            
            backgroundColor?.setFill()
            UIRectFill(rect)
            
            let shapeLayer = CAShapeLayer()
            let path = CGMutablePath()
            
            path.addRect(croppedView.frame)
            path.addRect(bounds)
            
            shapeLayer.path = path
            shapeLayer.fillRule = .evenOdd
            layer.mask = shapeLayer
        }
    }
    
    override func layoutSubviews () {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
