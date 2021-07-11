//
//  ChatView.swift
//  to-farma
//
//  Created by Melissa Villalobos on 10/7/21.
//

import Foundation
import Foundation
import UIKit
import MaterialComponents

class ChatView: UIView {
    var userButton: UIButton!
    var carButton: UIButton!
    let title = UILabel()
    let registerButton = UIButton()
    var mainStack = UIStackView()
    let collectionStack = UIStackView()
    let message = UITextField()

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
        title.text = R.string.localizable.chat_titulo()
        title.font = UIFont.boldSystemFont(ofSize: 28)
        title.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(title)
      
        let rectangleYellow = RectangleView()
        rectangleYellow.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(rectangleYellow)
        
        collectionStack.axis = .vertical
        collectionStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(collectionStack)
        
        message.backgroundColor = .lightGray
        message.clipsToBounds = true
        message.layer.cornerRadius = 5
        message.placeholder = "Message ..."
        message.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(message)
        
        mainStack.constrainToSafeEdges(to: self, padding: UIEdgeInsets(top: 16, left: 32, bottom: 16, right: 16))
        
        NSLayoutConstraint.activate([
            title.leftAnchor.constraint(equalTo: self.mainStack.leftAnchor, constant: 8),
            message.heightAnchor.constraint(equalToConstant: 100),
            message.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
