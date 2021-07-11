//
//  ImageUnderline.swift
//  to-farma
//
//  Created by Melissa Villalobos on 21/6/21.
//

import Foundation
import UIKit

extension UIImage {
    func setupTabBarItemUnderline(color: UIColor, size: CGSize, lineSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)

        UIColor.clear.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))

        color.setFill()
        UIRectFill(CGRect(x: 0, y: size.height-lineSize.height, width: lineSize.width, height: lineSize.height))

        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return UIImage()
        }
        UIGraphicsEndImageContext()
        return image
    }
}
