//
//  DropdownPickerView.swift
//  to-farma
//
//  Created by Melissa Villalobos on 17/7/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import MaterialComponents

class DropdownPickerView: UIView {
    private let pickerImage = UIImageView()
    private let pickerText = MDCTextField()
    private var textFieldControllerFloating = MDCTextInputControllerUnderline()
    private let disposeBag = DisposeBag()
    let viewModel = DropdownPickerViewModel()

    init() {
        super.init(frame: .zero)
        prepareLayout()
        setupBindings()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareLayout() {
        pickerText.translatesAutoresizingMaskIntoConstraints = false
        let pickerImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = R.image.iconDown16()
        pickerImage.image = image
        pickerText.rightView = pickerImage
        pickerText.rightViewMode = .always
        pickerText.setTypography(.subtitleSmall)
        pickerText.isUserInteractionEnabled = false
        self.addSubview(pickerText)
        
        NSLayoutConstraint.activate([
            pickerText.topAnchor.constraint(equalTo: self.topAnchor),
            pickerText.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pickerText.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pickerText.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: pickerText)
        textFieldControllerFloating.normalColor = .black
        textFieldControllerFloating.disabledColor = .black
        textFieldControllerFloating.setTypography(.placeholder, applyAttributes: true)
    }
    
    private func setupBindings() {
        viewModel.text
            .asDriver()
            .drive(pickerText.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.placeholder
            .asDriver()
            .drive(pickerText.rx.placeholder)
            .disposed(by: disposeBag)
    }
}

extension Reactive where Base: MDCTextField {
    public var placeholder: Binder<String> {
        return Binder(self.base) { textField, value in
            textField.placeholder = value
        }
    }
}

