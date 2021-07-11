//
//  Buttons.swift
//  to-farma
//
//  Created by Melissa Villalobos on 31/5/21.
//

import Foundation
import UIKit

enum ButtonStyle {
    case primaryButton
    case secondaryButton
}
extension ButtonStyle {
    var backgroundColor: UIColor {
        switch self {
        case .primaryButton:
            return Color.primaryColor
        case .secondaryButton:
            return Color.secondaryColor
        }
    }
    var titleColor: UIColor {
        switch self {
        case .primaryButton, .secondaryButton:
            return .black
        }
    }
    var cornerRadius: CGFloat {
        switch self {
        case .primaryButton, .secondaryButton:
            return 5.0
        }
    }
    var shadowColor: CGColor {
        switch self {
        case .primaryButton, .secondaryButton:
            return UIColor.black.cgColor
        }
    }
    var shadowOpacity: Float {
        switch self {
        case .primaryButton, .secondaryButton:
            return 0.6
        }
    }
    var shadowRadius: CGFloat {
        switch self {
        case .primaryButton, .secondaryButton:
            return 3
        }
    }
    var shadowOffsetHeight: Double {
        switch self {
        case .primaryButton, .secondaryButton:
            return 5.0
        }
    }
    var heightConstraint: CGFloat {
        switch self {
        case .primaryButton, .secondaryButton:
            return 52        }
    }
    
    var borderColor: CGColor {
        switch self {
        case .primaryButton:
            return Color.primaryColor.cgColor
        case .secondaryButton:
            return Color.secondaryColor.cgColor
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .primaryButton, .secondaryButton:
            return 2.0
        }
    }
}
extension UIButton {
    func setStyle(_ buttonStyle: ButtonStyle) {
        self.backgroundColor = buttonStyle.backgroundColor
        self.setTitleColor(buttonStyle.titleColor, for: .normal)
        self.layer.cornerRadius = buttonStyle.cornerRadius
        self.layer.shadowColor = buttonStyle.shadowColor
        self.layer.shadowOpacity = buttonStyle.shadowOpacity
        self.layer.shadowRadius = buttonStyle.shadowRadius
        self.layer.borderWidth = buttonStyle.borderWidth
        self.layer.borderColor = buttonStyle.borderColor
        self.layer.shadowOffset = CGSize(width: 0, height: buttonStyle.shadowOffsetHeight)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: buttonStyle.heightConstraint)
        ])
    }
}
extension UIContextualAction {
    func setStyle(_ buttonStyle: ButtonStyle) {
        self.backgroundColor = buttonStyle.backgroundColor
    }
}
