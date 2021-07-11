//
//  LogViewController.swift
//  to-farma
//
//  Created by Melissa Villalobos on 3/6/21.
//

import Foundation
import UIKit
import RxSwift

class LogViewController: UIViewController {
    let contentView = LogView()
    let viewModel = LogInViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = contentView
        self.setUpNavigationBar()
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
        
        contentView.emailTextField.rx.text.orEmpty
            .asDriver()
            .drive(viewModel.email)
            .disposed(by: disposeBag)
        
        contentView.passwordTextField.rx.text.orEmpty
            .asDriver()
            .drive(viewModel.password)
            .disposed(by: disposeBag)
        
        contentView.registerButton.rx.tap
            .asDriver()
            .drive(viewModel.logInTapped)
            .disposed(by: disposeBag)
        
        viewModel.tapped
            .drive(onNext: { [weak self] _ in
                let blogVC = RegularUserNavigationViewController()
                self?.navigationController?.pushViewController(blogVC, animated: false)
            })
            .disposed(by: disposeBag)
    }
}
