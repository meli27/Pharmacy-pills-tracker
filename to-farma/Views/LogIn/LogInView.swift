//
//  LogInVIew.swift
//  to-farma
//
//  Created by Melissa Villalobos on 23/5/21.
//

import Foundation
import UIKit

class LogInView: UIView {
    let logInButton = UIButton()
    let registerButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.prepareLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareLayout() {
        self.backgroundColor = .white
        
        let mainStack = UIStackView()
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.backgroundColor = .white
        self.addSubview(mainStack)
      
        let decorationStack = UIStackView()
        decorationStack.translatesAutoresizingMaskIntoConstraints = false
        decorationStack.axis = .vertical
        decorationStack.spacing = 100
        decorationStack.backgroundColor = Color.primaryColor
        mainStack.addArrangedSubview(decorationStack)
        
        let toFarmaLogo = ScaledHeightImageView(image: R.image.toFarmaLogo())
        toFarmaLogo.contentMode = .scaleAspectFit
        toFarmaLogo.translatesAutoresizingMaskIntoConstraints = false
        toFarmaLogo.backgroundColor = .black
        decorationStack.addArrangedSubview(toFarmaLogo)
        
        let rectangleYellow = RectangleView()
        rectangleYellow.translatesAutoresizingMaskIntoConstraints = false
        rectangleYellow.setContentCompressionResistancePriority(.required, for: .horizontal)
        decorationStack.addArrangedSubview(rectangleYellow)
      
        let buttonViewStack = UIStackView()
        buttonViewStack.translatesAutoresizingMaskIntoConstraints = false
        buttonViewStack.axis = .horizontal
        buttonViewStack.spacing = 8
        buttonViewStack.backgroundColor = .white
        buttonViewStack.distribution = .fillEqually
        mainStack.addArrangedSubview(buttonViewStack)
        
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.setStyle(.primaryButton)
        
        logInButton.setTitle(R.string.localizable.logIn_Iniciar(), for: .normal)
        buttonViewStack.addArrangedSubview(logInButton)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setStyle(.secondaryButton)
        registerButton.setTitle(R.string.localizable.logIn_Registrarse(), for: .normal)
        buttonViewStack.addArrangedSubview(registerButton)
        
        mainStack.constrainToSafeEdges(to: self, padding: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0))
        NSLayoutConstraint.activate([
            toFarmaLogo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonViewStack.leftAnchor.constraint(equalTo: mainStack.leftAnchor, constant: 16),
            buttonViewStack.rightAnchor.constraint(equalTo: mainStack.rightAnchor, constant: -16),
            rectangleYellow.rightAnchor.constraint(equalTo: mainStack.rightAnchor)
        ])
    }
}
