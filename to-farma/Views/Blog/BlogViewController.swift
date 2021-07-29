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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
                    self?.postCollection.performBatchUpdates({}, completion: {_ in })
                })
                .disposed(by: cell.disposeBag)
            
            Driver.just(self.selectedCellIndexPath)
                .drive(onNext: { info in
                    let cellIsOn = info[indexPath]?.isOn
                    cell.updateActive(isOn: cellIsOn ?? false)
                })
                .disposed(by: self.disposeBag)
            
            return cell
        })
        
        postCollection.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.posts
            .drive(self.postCollection.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        self.postCollection.collectionViewLayout.invalidateLayout()
    }
}

extension BlogViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let indexPaths = self.selectedCellIndexPath[indexPath] else { return
            CGSize(width: UIScreen.main.bounds.width-16, height: 550)
        }
        let isOn = indexPaths.isOn
        let cell = indexPaths.cell

        if isOn {
            return cell.cellIntrinsicContentSize ?? CGSize(width: 100, height: 100)
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
