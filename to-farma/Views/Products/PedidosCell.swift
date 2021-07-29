//
//  PedidosCell.swift
//  to-farma
//
//  Created by Melissa Villalobos on 17/7/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class PedidosCell: UITableViewCell {
    var pedidosImage = UIImageComponent()
    var titleLabel = UILabel()
    var priceLabel = UILabel()
    var plus = UIButton()
    var minus = UIButton()
    var disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayouts()
        //prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    public func updateActive(isHidden: Bool, number: String?) {
        pedidosImage.productNumberLabel.text = number
        pedidosImage.deleteIcon.isHidden = isHidden
    }
    
    private func setLayouts() {
        contentView.isUserInteractionEnabled = true

        let pedidosStack = UIStackView()
        pedidosStack.axis = .horizontal
        pedidosStack.spacing = 10
        pedidosStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pedidosStack)

        pedidosStack.constrainToSafeEdges(to: self, padding: UIEdgeInsets(top: 16, left: 16, bottom: 24, right: 16))
        
        pedidosImage = UIImageComponent()
        pedidosImage.translatesAutoresizingMaskIntoConstraints = false
        pedidosImage.contentMode = .scaleAspectFit
        pedidosStack.addArrangedSubview(pedidosImage)
        
        NSLayoutConstraint.activate([
            pedidosImage.widthAnchor.constraint(equalToConstant: 100),
            pedidosImage.heightAnchor.constraint(equalToConstant: 100)
        ])

        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.spacing = 5
        infoStack.alignment = .center
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        pedidosStack.addArrangedSubview(infoStack)

        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoStack.addArrangedSubview(titleLabel)

        priceLabel = UILabel()
        priceLabel.numberOfLines = 0
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        infoStack.addArrangedSubview(priceLabel)

        let actionStack = UIStackView()
        actionStack.translatesAutoresizingMaskIntoConstraints = false
        actionStack.axis = .vertical
        actionStack.spacing = 3
        pedidosStack.addArrangedSubview(actionStack)

        plus = UIButton()
        plus.setImage(R.image.plus(), for: .normal)
        plus.translatesAutoresizingMaskIntoConstraints = false
        actionStack.addArrangedSubview(plus)

        minus = UIButton()
        minus.setImage(R.image.minus(), for: .normal)
        minus.translatesAutoresizingMaskIntoConstraints = false
        actionStack.addArrangedSubview(minus)
    }
}
