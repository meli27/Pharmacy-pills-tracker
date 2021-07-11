//
//  BlogViewController.swift
//  to-farma
//
//  Created by Melissa Villalobos on 3/6/21.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class BlogViewController: UIViewController {
    let contentView = BlogView()
    var viewModel: BlogViewModel!
    var postCollection: UICollectionView!
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Post>>!
    var selectedCellIndexPath: [IndexPath : (isOn: Bool, cell: BlogCell)] = [:]
    let disposeBag = DisposeBag()
 
    init() {
        self.viewModel = BlogViewModel()
        super.init(nibName: nil, bundle: nil)
        
        dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfPosts>(configureCell: { _, collectionView, indexPath, post -> UICollectionViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                "BlogCell", for: indexPath) as? BlogCell
            else {
                return  BlogCell()
            }
           
            cell.title.text = post.title
            cell.date.text = post.date
            
            let url = "https://app.tofarma.com/storage/"+(post.banner ?? "")
            cell.blogImage.imageFromServerURL(url, placeHolder: cell.blogImage.image)
            
            let attr = try? NSAttributedString(htmlString: post.text, font: UIFont.systemFont(ofSize: 18, weight: .thin), useDocumentFontSize: false)
            cell.text.attributedText = attr
            
            cell.switchMore.rx.tapGesture()
                .when(.recognized)
                .flatMapLatest { _ in cell.switchMore.rx.isOn }
                .asDriver(onErrorDriveWith: Driver.empty())
                .drive(onNext: { [weak self] isOn in
                    self?.selectedCellIndexPath[indexPath] = (isOn: isOn, cell: cell)
                    collectionView.performBatchUpdates({}, completion: {_ in })
                })
                .disposed(by: cell.disposeBag)
            
            
            return cell
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = contentView
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical

        self.postCollection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        postCollection.backgroundColor = .white
        postCollection.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.mainStack.addArrangedSubview(postCollection)
        
        NSLayoutConstraint.activate([
            self.postCollection.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.postCollection.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        
        self.postCollection.register(BlogCell.self, forCellWithReuseIdentifier: "BlogCell")
    }
    
    override func viewDidLoad() {
        self.view = contentView
        super.viewDidLoad()
        
        postCollection.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.posts
            .drive(self.postCollection.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension BlogViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isOn = self.selectedCellIndexPath[indexPath]?.isOn
        let cell = self.selectedCellIndexPath[indexPath]?.cell
        
        if isOn ?? false {
            return cell?.cellIntrinsicContentSize ?? .zero
        } else {
            return CGSize(width: 400, height: 550)
        }
    }
}

extension UIViewController {
    func addChildViewController(_ childViewController: UIViewController) {
        self.addChild(childViewController)
        childViewController.view.frame = self.view.frame
        self.view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
    
    func removeChildViewController(_ childViewController: UIViewController) {
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }
}
