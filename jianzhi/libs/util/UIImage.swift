//
//  UIImage.swift
//  jianzhi
//
//  Created by daniel on 16/1/28.
//  Copyright © 2016年 jianzhi. All rights reserved.
//

import UIKit

extension UIImage {

//    convenience init(_ image:UIImage, _ rect:CGRect) {
//        let cgImage = CGImageCreateWithImageInRect(image.CGImage, rect)
//        if cgImage != nil {
//            self.init(CGImage: cgImage!)
//        }
//        else {
//            self.init()
//        }
//    }

    func compress(size:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 1)
        self.drawInRect(CGRect(origin: CGPointZero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
