//
//  LogInViewController.swift
//  to-farma
//
//  Created by Melissa Villalobos on 23/5/21.
//

import Foundation
import UIKit
import RxSwift

class LoginViewController: UIViewController {
    let contentView = LogInView()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = contentView
        self.setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupBindings() {
//        viewModel.blogInfo
//            .drive(contentView.titleLabel.rx.text)
//            .disposed(by: disposeBag)
        
        //usar gesture envez de tap
        contentView.registerButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                let registerVC = RegisterViewController()
                self?.navigationController?.pushViewController(registerVC, animated: false)
            })
            .disposed(by: self.disposeBag)
        
        contentView.logInButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                let logInVC = LogViewController()
                self?.navigationController?.pushViewController(logInVC, animated: false)
            })
            .disposed(by: self.disposeBag)
    }
}
