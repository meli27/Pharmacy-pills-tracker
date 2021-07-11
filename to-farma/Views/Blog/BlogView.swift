//
//  BlogView.swift
//  to-farma
//
//  Created by Melissa Villalobos on 3/6/21.
//

import Foundation
import Foundation
import UIKit
import MaterialComponents

class BlogView: UIView {
    var userButton: UIButton!
    var carButton: UIButton!
    let title = UILabel()
    let registerButton = UIButton()
    var mainStack = UIStackView()
 
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.prepareLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareLayout() {
        self.backgroundColor = .white
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.backgroundColor = .white
        self.addSubview(mainStack)
        
        let title = UILabel()
        title.text = R.string.localizable.blog()
        title.font = UIFont.boldSystemFont(ofSize: 28)
        title.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(title)
      
        let rectangleYellow = RectangleView()
        rectangleYellow.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(rectangleYellow)
        
        mainStack.constrainToSafeEdges(to: self, padding: UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 16))
        
        NSLayoutConstraint.activate([
            title.leftAnchor.constraint(equalTo: self.mainStack.leftAnchor, constant: 8)
        ])
        
    }
}
