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

class ProductsViewModel{
    //Input
    let selectedCategory = PublishRelay<Int>()
    let minusTapped = PublishRelay<Productos>()
    let plusTapped = PublishRelay<Productos>()

    //Output
    let products: Driver<[SectionOfProducts]>
    let categories: Driver<[Category]>
    let minusProduct: Driver<Productos>
    let plusProduct: Driver<Productos>

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
        
        minusProduct = minusTapped.asDriver(onErrorDriveWith: .empty())
        plusProduct = plusTapped.asDriver(onErrorDriveWith: .empty())
    }
}
