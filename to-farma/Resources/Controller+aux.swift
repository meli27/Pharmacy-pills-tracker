//
//  Controller+aux.swift
//  to-farma
//
//  Created by Melissa Villalobos on 28/7/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func profileItem(_ image: UIImage) -> UIImage {
        let imageView = UIImageView()
        imageView.frame =  CGRect(x: 0, y: 0, width: 40, height: 40)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = image
        var layer: CALayer = CALayer()
        
        layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = 20
        layer.borderColor = Color.lightGray.cgColor
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        guard let roundedProfileItem = roundedImage else { return UIImage() }
        return roundedProfileItem
    }

    func setupRegularUserNavigationBar(_ profileImage: UIImage) {
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.isTranslucent = false
        let profile = UIBarButtonItem(image: profileItem(profileImage).withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        let cart = UIBarButtonItem(image: R.image.cart()?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItems = [profile, cart]
    }
}
