//
//  BlogCell.swift
//  to-farma
//
//  Created by Melissa Villalobos on 11/6/21.
//


import UIKit
import RxCocoa
import RxSwift

class BlogCell: UICollectionViewCell {    
    var postUserImage = UIImageView()
    var title = UILabel()
    var date = UILabel()
    var blogImage = UIImageView()
    var text = UILabel()
    var viewMore = UILabel()
    var switchMore = UISwitch()
    let cardView = UIStackView()
    var cellIntrinsicContentSize: CGSize!
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    private func setLayouts() {
       // translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Color.lightGray
        layer.cornerRadius = 10
        
//        if switchMore.isOn {
            NSLayoutConstraint.activate([
            //    self.heightAnchor.constraint(equalToConstant: 550),
                self.widthAnchor.constraint(equalToConstant: 400)
            ])
//        } else {
//            NSLayoutConstraint.activate([
//                self.heightAnchor.constraint(equalToConstant: 550),
//                self.widthAnchor.constraint(equalToConstant: 400)
//            ])
//            cellIntrinsicContentSize
//        }
        
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
        
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        infoView.addArrangedSubview(title)
        
        date.font = UIFont.systemFont(ofSize: 14)
        date.translatesAutoresizingMaskIntoConstraints = false
        date.numberOfLines = 0
        infoView.addArrangedSubview(date)
        
        blogImage.translatesAutoresizingMaskIntoConstraints = false
        cardView.addArrangedSubview(blogImage)
        
        NSLayoutConstraint.activate([
            blogImage.widthAnchor.constraint(equalToConstant: 300),
            blogImage.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.numberOfLines = 0
        cardView.addArrangedSubview(text)
        
        let viewMoreStackView = UIStackView()
        viewMoreStackView.translatesAutoresizingMaskIntoConstraints = false
        viewMoreStackView.axis = .horizontal
        viewMoreStackView.spacing = 8
        cardView.addArrangedSubview(viewMoreStackView)
        
//        switchMore.translatesAutoresizingMaskIntoConstraints = false
//        switchMore.onTintColor = Color.primaryColor
//        viewMoreStackView.addArrangedSubview(switchMore)
//        
//        viewMore.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        viewMore.translatesAutoresizingMaskIntoConstraints = false
//        viewMore.text = R.string.localizable.ver_mas()
//        viewMoreStackView.addArrangedSubview(viewMore)
    }
    
//    override func layoutSubviews() {
//        let textHeight = text.text?.height(withConstrainedWidth: 400, font: UIFont.systemFont(ofSize: 18))
//        let totalHeight = 485 + (textHeight ?? 0.0) + switchMore.frame.size.height
//        cellIntrinsicContentSize =  CGSize(width: 400, height:  totalHeight)
//        invalidateIntrinsicContentSize()
//    }
}

//extension String {
//    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
//
//        return ceil(boundingBox.height)
//    }

