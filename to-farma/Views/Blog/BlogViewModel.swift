//
//  BlogViewModel.swift
//  to-farma
//
//  Created by Melissa Villalobos on 23/5/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

typealias SectionOfPosts = SectionModel<String, Post>

class BlogViewModel{
    //Input
    let isOnTapped = PublishRelay<Bool>()
    
    //Output
    let posts: Driver<[SectionOfPosts]>
    let isOnTappedDriver: Driver<Bool>
    
    static let postsSectionModel = "PostSectionModel"

    init(networkManager: ToFarmaManager = ToFarmaManager()) {
        self.posts = networkManager.fetchPosts()
            .asDriver(onErrorDriveWith: .empty())
            .map { [SectionModel(model: BlogViewModel.postsSectionModel, items: $0)] }
        
        self.isOnTappedDriver = isOnTapped.asDriver(onErrorDriveWith: .empty())
    }
}
