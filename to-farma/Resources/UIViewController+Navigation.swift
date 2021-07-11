//
//  UIViewController+Navigation.swift
//  to-farma
//
//  Created by Melissa Villalobos on 8/6/21.
//

import Foundation
import UIKit

extension UIViewController {
    func setUpNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "Back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
    }
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
}
