//
//  UICollectionView+Utilities.swift
//  to-farma
//
//  Created by Melissa Villalobos on 18/7/21.
//

import Foundation
import UIKit

extension UITableView {
    func setNoDataPlaceholder(_ message: String) {
        self.separatorStyle = .none
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        emptyView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: emptyView.topAnchor),
            stack.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: emptyView.bottomAnchor)
        ])
        
        let imageView = UIImageView(image: R.image.iconEmptyState())
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        stack.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50)
        ])

        let placeHolder = UILabel()
        placeHolder.translatesAutoresizingMaskIntoConstraints = false
        placeHolder.text = message
        placeHolder.setTypography(.subtitleMedium)
        placeHolder.textColor = .gray
        placeHolder.numberOfLines = 0
        placeHolder.textAlignment = .center
        stack.addArrangedSubview(placeHolder)

        self.backgroundView = emptyView
    }
    
    func removeNoDataPlaceholder() {
        self.separatorStyle = .singleLine

        self.isScrollEnabled = true
        self.backgroundView = nil
    }
}
