//
//  ChatViewModel.swift
//  to-farma
//
//  Created by Melissa Villalobos on 10/7/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

typealias SectionOfMessages = SectionModel<String, Message>

class ChatViewModel{
    //Input
    let isOnTapped = PublishRelay<Bool>()
    
    //Output
    let messages: Driver<[SectionOfMessages]>
    let isOnTappedDriver: Driver<Bool>
    
    static let postsSectionModel = "PostSectionModel"

    init(networkManager: ToFarmaManager = ToFarmaManager()) {
        
        let mockMessages = Message(id: 1, text: "Hola")
        let mockMessages1 = Message(id: 1, text: "Todo Bien")

        self.messages = //networkManager.fetchMessages()
            Driver.just([mockMessages, mockMessages1])
            .asDriver(onErrorDriveWith: .empty())
            .map { [SectionModel(model: BlogViewModel.postsSectionModel, items: $0)] }
        
        self.isOnTappedDriver = isOnTapped.asDriver(onErrorDriveWith: .empty())
    }
}
