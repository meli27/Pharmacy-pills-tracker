//
//  HeaderViewController.swift
//  to-farma
//
//  Created by Melissa Villalobos on 28/7/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxGesture

class HeaderViewController: UIViewController {
    let contentView = HeaderView()
    let disposeBag = DisposeBag()
 
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = contentView
    }
}
