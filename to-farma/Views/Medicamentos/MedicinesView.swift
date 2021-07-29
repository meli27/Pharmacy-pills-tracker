//
//  MedicinesView.swift
//  to-farma
//
//  Created by Melissa Villalobos on 19/6/21.
//

import Foundation
import UIKit
import MaterialComponents

class MedicineView: UIView {
    var userButton: UIButton!
    var carButton: UIButton!
    let title = UILabel()
    let registerButton = UIButton()
    var mainStack = UIStackView()
    let nextVisit = UILabel()

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
        title.text = R.string.localizable.medicamentos_titulo()
        title.font = UIFont.boldSystemFont(ofSize: 28)
        title.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(title)
      
        let rectangleYellow = RectangleView()
        rectangleYellow.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(rectangleYellow)
        
        let nextVisitLabel = UILabel()
        nextVisitLabel.text = "Próxima visita"
        nextVisitLabel.font = UIFont.boldSystemFont(ofSize: 26)
        nextVisitLabel.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(nextVisitLabel)
        
        nextVisit.font = UIFont.boldSystemFont(ofSize: 18)
        nextVisit.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(nextVisit)
      
        mainStack.constrainEdges(to: self, padding: UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0))
        
        NSLayoutConstraint.activate([
            title.leftAnchor.constraint(equalTo: self.mainStack.leftAnchor, constant: 16)
        ])
        
    }
}
