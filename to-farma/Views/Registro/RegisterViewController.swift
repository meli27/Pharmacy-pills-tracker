//
//  RegisterViewController.swift
//  to-farma
//
//  Created by Melissa Villalobos on 3/6/21.
//

import Foundation
import UIKit
import RxSwift

class RegisterViewController: UIViewController {
    let contentView = RegisterView()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.setUpNavigationBar()
        self.view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupBindings()
    }
    
    private func setupBindings() {
        navigationItem.leftBarButtonItem?.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.backAction()
            })
            .disposed(by: disposeBag)
        
//        contentView.registerButton.rx.tap
//            .asDriver()
//            .drive(onNext: { [weak self] _ in
//                self?.navigationController?.pushViewController(self!, animated: false)
//            })
//            .disposed(by: self.disposeBag)
    }
}
