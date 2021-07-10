//
//  MenuView.swift
//  to-farma
//
//  Created by Melissa Villalobos on 24/6/21.
//

import Foundation
import UIKit
 
class MenuView: UIView {
    let emailTextField = MDCTextField()
    let passwordTextField = MDCTextField()
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
        mainStack.spacing = 24
        mainStack.backgroundColor = .white
        self.addSubview(mainStack)
        
        let title = UILabel()
        title.text = R.string.localizable.inicio_sesion()
        title.font = UIFont.systemFont(ofSize: 36)
        title.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(title)
        
        let toFarmaLogo = ScaledHeightImageView(image: R.image.toFarmaLogo2())
        toFarmaLogo.contentMode = .scaleAspectFit
        toFarmaLogo.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(toFarmaLogo)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.autocapitalizationType = .none
        emailTextField.attributedPlaceholder = NSAttributedString(string: R.string.localizable.registro_Correo(),
                                                                  attributes: [.foregroundColor: UIColor.black])
        mainStack.addArrangedSubview(emailTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.attributedPlaceholder = NSAttributedString(string: R.string.localizable.registro_Clave(),
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        mainStack.addArrangedSubview(passwordTextField)
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setStyle(.primaryButton)
        registerButton.setTitle(R.string.localizable.iniciar_sesion(), for: .normal)
        mainStack.addArrangedSubview(registerButton)
        
        NSLayoutConstraint.activate([
            toFarmaLogo.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainStack.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            mainStack.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
