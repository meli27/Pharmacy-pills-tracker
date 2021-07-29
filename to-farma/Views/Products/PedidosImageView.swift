//
//  PedidosImageView.swift
//  to-farma
//
//  Created by Melissa Villalobos on 21/7/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class UIImageComponent: UIView {
    private let imageSize: CGFloat = 90
    var imageView = UIImageView()
    var deleteIcon = UIButton()
    let productNumberLabel = UILabel()
    let disposeBag = DisposeBag()
    
    var productNumber = PublishRelay<String?>()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayouts() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        self.addSubview(stackView)
    
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(container)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        container.addSubview(imageView)

        imageView.constrainEdges(to: container, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 8))

        deleteIcon.translatesAutoresizingMaskIntoConstraints = false
        deleteIcon.isHidden = true
        deleteIcon.setImage(R.image.productOrder(), for: .normal)
        container.addSubview(deleteIcon)
        
        productNumberLabel.numberOfLines = 0
        productNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(productNumberLabel)
        
        
        NSLayoutConstraint.activate([
            deleteIcon.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: imageSize - 8),
            deleteIcon.topAnchor.constraint(equalTo: container.topAnchor),
            productNumberLabel.centerXAnchor.constraint(equalTo: deleteIcon.centerXAnchor),
            productNumberLabel.centerYAnchor.constraint(equalTo: deleteIcon.centerYAnchor)
        ])
        
        
        productNumber
            .asDriver(onErrorDriveWith: .empty())
            .compactMap { $0 }
            .filter { $0 != "0" }
            .drive(productNumberLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
