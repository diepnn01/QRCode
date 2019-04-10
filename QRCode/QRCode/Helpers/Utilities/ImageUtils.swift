//
//  ImageUtils.swift
//  QRCode
//
//  Created by Diep Nguyen on 4/6/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import UIKit

final class ImageUtils {
	
    static let shared = ImageUtils()
    
    let maxResolution = 1600
    
    func cropImageWith(_ image: UIImage, maxResolution: Int) -> UIImage?
    {
        let origWidth = Int(image.size.width)
        let origHeight = Int(image.size.height)
        
        var resizeWidth: Int = 0
        var resizeHeight: Int = 0
        
        if (origWidth > origHeight) {
            resizeWidth = maxResolution
            resizeHeight = origHeight * maxResolution / origWidth
        } else {
            resizeHeight = maxResolution
            resizeWidth = origWidth * maxResolution / origHeight
        }
        
        let resizeSize = CGSize(width: CGFloat(resizeWidth), height: CGFloat(resizeHeight))
        UIGraphicsBeginImageContext(resizeSize)
        
        image.draw(in: CGRect(x: 0, y: 0, width: CGFloat(resizeWidth), height: CGFloat(resizeHeight)))
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizeImage
    }
    
    func prepareAvatarImage(rawImage: UIImage, maxSizeInBytes: Int) -> String {
		
        var imageRaw: UIImage? = rawImage
        
        if Int(rawImage.size.height) > maxResolution || Int(rawImage.size.width) > maxResolution {
            imageRaw = self.cropImageWith(rawImage, maxResolution: maxResolution)
        }
        
        guard let image = imageRaw else {
            return ""
        }
        
        var imageData = image.jpegData(compressionQuality: 0.95)

        var index = 100
        while let temp = imageData, temp.count > maxSizeInBytes {
            imageRaw = self.cropImageWith(imageRaw ?? UIImage(), maxResolution: maxResolution - index)
            index += 100
            
            if let image = imageRaw {
                imageData = image.jpegData(compressionQuality: 0.95)
            }
        }
        
        if let base64String = imageData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0)) {
            return base64String
        } else {
            return ""
        }
    }
    
}
