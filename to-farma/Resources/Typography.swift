//
//  Typography.swift
//  to-farma
//
//  Created by Melissa Villalobos on 12/6/21.
//

import Foundation
import UIKit
import MaterialComponents

enum Typograpy {
    case splashFont
    case header
    case titleMedium
    case titleSmall
    case titleSmallBold
    case subtitleMedium
    case subtitleSmall
    case subtitleXSmall
    case subtitleSmallBold
    case bodyMedium
    case bodySmall
    case button
    case caption
    case overline
    case placeholder
}

extension Typograpy {
    var font: UIFont? {
        switch self {
        case .splashFont:
            return R.font.helveticaNeueBold(size: 50)
        case .header:
            return R.font.helveticaNeue(size: 20)
        case .titleMedium:
            return R.font.helveticaNeue(size: 28)
        case .titleSmall:
            return R.font.helveticaNeue(size: 18)
        case .titleSmallBold:
            return R.font.helveticaNeueBold(size: 18)
        case .subtitleMedium, .bodyMedium, .button:
            return R.font.helveticaNeue(size: 17)
        case .subtitleSmall, .bodySmall, .placeholder:
            return R.font.helveticaNeue(size: 16)
        case .subtitleSmallBold:
            return R.font.helveticaNeueBold(size: 16)
        case .subtitleXSmall:
            return R.font.helveticaNeue(size: 14)
        case .caption:
            return R.font.helveticaNeue(size: 12)
        case .overline:
            return R.font.helveticaNeue(size: 10)
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .splashFont:
            return .white
        case .header:
            return .white
        case .titleMedium:
            return .black
        case .titleSmall:
            return .white
        case .titleSmallBold:
            return .white
        case .subtitleMedium, .bodyMedium, .button:
            return .white
        case .subtitleSmall, .bodySmall, .subtitleXSmall:
            return .lightGray
        case .subtitleSmallBold:
            return .white
        case .caption:
            return .white
        case .overline:
            return .white
        case .placeholder:
            return .gray
        }
    }
}

extension UILabel {
    func setTypography(_ typography: Typograpy, applyAttributes: Bool = true) {
        self.font = typography.font
        guard !applyAttributes else { return }
        self.textColor = typography.textColor
    }
}

extension MDCMultilineTextField {
    func setTypography(_ typography: Typograpy, applyAttributes: Bool = true) {
        self.font = typography.font
        guard !applyAttributes else { return }
        self.textColor = typography.textColor
    }
}

extension MDCMultilineTextField {
    func setTypography(_ typography: Typograpy) {
      self.font = typography.font
    }
}

extension UITextField {
    func setTypography(_ typography: Typograpy) {
      self.font = typography.font
    }
}

extension UITextView {
    func setTypography(_ typography: Typograpy) {
      self.font = typography.font
    }
}

extension MDCTextInputControllerUnderline {
    func setTypography(_ typography: Typograpy, applyAttributes: Bool = true) {
        self.inlinePlaceholderFont = typography.font
        guard !applyAttributes else { return }
        self.inlinePlaceholderColor = typography.textColor
    }
}
