//
//  ChatCell.swift
//  to-farma
//
//  Created by Melissa Villalobos on 10/7/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class ChatCell: UICollectionViewCell {
    var postUserImage = UIImageView()
    var chatText = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setLayouts() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Color.lightGray
        layer.cornerRadius = 10
        
        let cardView = UIStackView()
        cardView.axis = .vertical
        cardView.spacing = 15
        cardView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cardView)
        
        cardView.constrainToSafeEdges(to: self, padding: UIEdgeInsets(top: 16, left: 16, bottom: 24, right: 16))
        
        let headerView = UIStackView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.axis = .horizontal
        headerView.spacing = 10
        cardView.addArrangedSubview(headerView)
        
        postUserImage.image = R.image.user()
        postUserImage.translatesAutoresizingMaskIntoConstraints = false
        headerView.addArrangedSubview(postUserImage)
        
        NSLayoutConstraint.activate([
            postUserImage.widthAnchor.constraint(equalToConstant: 40),
            postUserImage.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        let infoView = UIStackView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.axis = .vertical
        infoView.spacing = 8
        headerView.addArrangedSubview(infoView)
        
        chatText.translatesAutoresizingMaskIntoConstraints = false
        chatText.numberOfLines = 0
        cardView.addArrangedSubview(chatText)
        
        let viewMoreStackView = UIStackView()
        viewMoreStackView.translatesAutoresizingMaskIntoConstraints = false
        viewMoreStackView.axis = .horizontal
        viewMoreStackView.spacing = 8
        cardView.addArrangedSubview(viewMoreStackView)
    }
}
