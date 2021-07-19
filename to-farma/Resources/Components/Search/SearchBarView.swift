//
//  SearchBarView.swift
//  to-farma
//
//  Created by Melissa Villalobos on 17/7/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import MaterialComponents

class SearchBarView: UIView {
    private let searchBarText = MDCTextField()
    private var textFieldControllerFloating = MDCTextInputControllerUnderline()
    private let disposeBag = DisposeBag()
    let viewModel = SearchBarViewModel()

    init() {
        super.init(frame: .zero)
        prepareLayout()
        setupBindings()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareLayout() {
        searchBarText.translatesAutoresizingMaskIntoConstraints = false
        let searchImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = R.image.iconSearchBar()
        searchImage.image = image
        searchBarText.rightView = searchImage
        searchBarText.rightViewMode = .always
        searchBarText.setTypography(.subtitleSmall)
        self.addSubview(searchBarText)
        
        NSLayoutConstraint.activate([
            searchBarText.topAnchor.constraint(equalTo: self.topAnchor),
            searchBarText.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            searchBarText.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchBarText.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: searchBarText)
        textFieldControllerFloating.normalColor = .black
        textFieldControllerFloating.setTypography(.placeholder, applyAttributes: true)
    }
    
    private func setupBindings() {
        searchBarText.rx.controlEvent(.editingChanged)
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive(viewModel.inputs.textDidChanged)
            .disposed(by: disposeBag)
        
        searchBarText.rx.text.orEmpty
            .asDriver()
            .drive(viewModel.inputs.setText)
            .disposed(by: disposeBag)
        
        viewModel.outputs.placeholder
            .asDriver()
            .drive(searchBarText.rx.placeholder)
            .disposed(by: disposeBag)
    }
}
