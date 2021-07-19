//
//  RegularUserNavigationViewController.swift
//  to-farma
//
//  Created by Melissa Villalobos on 24/6/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class RegularUserNavigationViewController: UIViewController {
    private let tabBar = RegularUserTabBar()
    private let pageViewController = RegularUserPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func loadView() {
        super.loadView()
        self.setupLayout()
        self.setupDelegates()
    }

    private func setupDelegates() {
        pageViewController.swipeDelegate = tabBar
        tabBar.itemSelectedDelegate = pageViewController
    }
    
    private func setupLayout() {
        self.view.backgroundColor = .white
        
        let headerStackView = UIStackView()
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.axis = .vertical
        self.view.addSubview(headerStackView)
        
        NSLayoutConstraint.activate([
            headerStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBar.setupStyle()
        headerStackView.addArrangedSubview(tabBar)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(pageViewController)
        
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: headerStackView.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
