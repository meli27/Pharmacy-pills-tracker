//
//  HeaderView.swift
//  to-farma
//
//  Created by Melissa Villalobos on 28/7/21.
//

import Foundation
import UIKit
import MaterialComponents

class HeaderView: UIView {
    var profileIcon = UIImageView()
    let pedidosIcon = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.prepareLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareLayout() {
        let mainStack = UIStackView()
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .horizontal
        mainStack.spacing = 16
        mainStack.backgroundColor = .white
        self.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.leftAnchor.constraint(greaterThanOrEqualTo: self.leftAnchor),
            mainStack.rightAnchor.constraint(equalTo: self.rightAnchor),
            mainStack.topAnchor.constraint(equalTo: self.topAnchor),
            mainStack.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor)
        ])
        
        let cartImage = ScaledHeightImageView(image: R.image.cart())
        cartImage.contentMode = .scaleAspectFit
        cartImage.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(cartImage)
    }
}
