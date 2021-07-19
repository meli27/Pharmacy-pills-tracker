//
//  MenuTabView.swift
//  to-farma
//
//  Created by Melissa Villalobos on 24/6/21.
//

import Foundation
import UIKit

protocol RegularTabBarDelegate: AnyObject {
    func itemSelected(itemIndex: Int)
}

class RegularUserTabBar: UITabBar, PageControllerDelegate {
    private var itemList: [UITabBarItem]!
    private var blogItem: UITabBarItem!
    private var medicineItem: UITabBarItem!
    private var chatItem: UITabBarItem!
    private var productsItem: UITabBarItem!
    
    weak var itemSelectedDelegate: RegularTabBarDelegate?
    let viewModel: RegularUserNavigationViewModel = RegularUserNavigationViewModel.shared
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        delegate = self
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        medicineItem = UITabBarItem(title: R.string.localizable.medicamentos_titulo(), image: R.image.medicamentos(), tag: 0)
        blogItem = UITabBarItem(title: R.string.localizable.blog(), image: R.image.blog(), tag: 1)
        chatItem = UITabBarItem(title: R.string.localizable.chat_titulo(), image: R.image.buzon(), tag: 2)
        productsItem = UITabBarItem(title: R.string.localizable.pedidos_titulo(), image: R.image.pedidos(), tag: 3)

        itemList = [medicineItem, blogItem, chatItem, productsItem]
        self.items = itemList
    }
    
    func setupStyle() {
        self.backgroundColor = .black
        self.isTranslucent = false
        self.tintColor = .darkGray
        self.unselectedItemTintColor = .lightGray
        self.selectedItem = itemList[0]
       // self.selectionIndicatorImage = UIImage().setupTabBarItemUnderline(color: .black, size: CGSize(width: CGFloat(UIScreen.main.bounds.width)/3, height: 49), lineSize: CGSize(width: CGFloat(UIScreen.main.bounds.width)/3, height: 4))
    }
    
    func pageDidSwipe(toIndex: Int) {
        self.selectedItem = itemList[toIndex]
    }
}

extension RegularUserTabBar: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.selectedItem = tabBar.items?[item.tag]
        self.viewModel.setCurrentController.accept(item.tag)
        self.itemSelectedDelegate?.itemSelected(itemIndex: item.tag)
    }
}

