//
//  MedicineModalView.swift
//  to-farma
//
//  Created by Melissa Villalobos on 2/7/21.
//

import Foundation
import UIKit
import MaterialComponents

class MedicineModalView: UIView {
    var title = UILabel()
    let dataSheet = UIStackView()

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
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.backgroundColor = Color.primaryColor
        self.addSubview(mainStack)
        
        let padding = UIScreen.main.bounds.size.height * 0.15
        mainStack.constrainEdges(to: self, padding: UIEdgeInsets(top: padding, left: 8, bottom: padding, right: 8))

        title.font = UIFont.boldSystemFont(ofSize: 28)
        title.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(title)
      
        dataSheet.translatesAutoresizingMaskIntoConstraints = false
        dataSheet.axis = .vertical
        dataSheet.spacing = 16
        dataSheet.backgroundColor = .white
        mainStack.addArrangedSubview(dataSheet)
    }
}
