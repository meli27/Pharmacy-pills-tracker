//
//  ProductsViewModel.swift
//  to-farma
//
//  Created by Melissa Villalobos on 17/7/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

typealias SectionOfProducts = SectionModel<String, Productos>

enum ProductsOrder {
    case increase
    case decrease
}

struct ProductInfo {
    let action: ProductsOrder
    let number: Int
}

class ProductsViewModel{
    //Input
    let selectedCategory = PublishRelay<Int>()
    let productBuyed = PublishRelay<(index: IndexPath, actions: ProductsOrder)>()

    //Output
    let products: Driver<[SectionOfProducts]>
    let categories: Driver<[Category]>
    let productsBuyed: Driver<[IndexPath:Int]>

    static let postsSectionModel = "PostSectionModel"

    init(networkManager: ToFarmaManager = ToFarmaManager()) {
        
        categories = networkManager.fetchCategories()
            .asDriver(onErrorDriveWith: .empty())
            
        products = selectedCategory
            .flatMapLatest {
                networkManager.fetchProduct(category: String($0))
                    .map { [SectionModel(model: BlogViewModel.postsSectionModel, items: $0)] }
            }
            .asDriver(onErrorDriveWith: .empty())
        
        self.productsBuyed = productBuyed
            .scan([:]) { list, product in
                var item = list

                switch product.actions {
                case .increase:
                    if var increaseProduct = list[product.index] {
                        increaseProduct += 1
                        item[product.index] = increaseProduct
                        return item
                    } else {
                        item[product.index] = 1
                        return item
                    }
                case .decrease:
                    if var decreaseProduct = list[product.index] {
                        if decreaseProduct > 0 {
                            decreaseProduct -= 1
                        } else {
                            decreaseProduct = 0
                        }
                        item[product.index] = decreaseProduct
                        return item
                    } else {
                        item[product.index] = 0
                        return item
                    }
                }
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
