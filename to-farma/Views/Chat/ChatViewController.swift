//
//  ChatViewController.swift
//  to-farma
//
//  Created by Melissa Villalobos on 10/7/21.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class ChatViewController: UIViewController {
    let contentView = ChatView()
    var viewModel: ChatViewModel!
    var messagesCollection: UICollectionView!
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, Message>>!
    let disposeBag = DisposeBag()
 
    init() {
        self.viewModel = ChatViewModel()
        super.init(nibName: nil, bundle: nil)
        
        dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfMessages>(configureCell: { _, collectionView, indexPath, message -> UICollectionViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                "ChatCell", for: indexPath) as? ChatCell
            else {
                return  ChatCell()
            }
           
            cell.chatText.text = message.text
      
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
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.scrollDirection = .vertical

        self.messagesCollection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        messagesCollection.backgroundColor = .white
        messagesCollection.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.collectionStack.addArrangedSubview(messagesCollection)
        
        NSLayoutConstraint.activate([
            self.messagesCollection.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.messagesCollection.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        
        self.messagesCollection.register(ChatCell.self, forCellWithReuseIdentifier: "ChatCell")
    }
    
    override func viewDidLoad() {
        self.view = contentView
        super.viewDidLoad()
        
        messagesCollection.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.messages
            .drive(self.messagesCollection.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
extension ChatViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
