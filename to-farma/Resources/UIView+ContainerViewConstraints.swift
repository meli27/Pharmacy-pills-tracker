//
//  UIView+ContainerViewConstraints.swift
//  to-farma
//
//  Created by Melissa Villalobos on 31/5/21.
//

import Foundation
import UIKit

extension UIView {
    func constrainToSafeEdges(to view: UIView, padding: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding.top),
            self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding.left),
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding.bottom),
            self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding.right)
        ])
    }
    
    func constrainEdges(to view: UIView, padding: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: padding.top),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.left),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding.bottom),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding.right)
        ])
        
    }
}
