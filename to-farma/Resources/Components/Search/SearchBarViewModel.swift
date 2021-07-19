//
//  SearchBarViewModel.swift
//  to-farma
//
//  Created by Melissa Villalobos on 17/7/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchBarViewModelInputs {
    var setText: BehaviorRelay<String> { get }
    var textDidChanged: PublishRelay<Void> { get }
    var setPlaceholder: PublishRelay<String> { get }
}

protocol SearchBarViewModelOutputs {
    var text: Driver<String> { get }
    var placeholder: Driver<String> { get }
}

protocol SearchBarViewModelType {
    var outputs: SearchBarViewModelOutputs { get }
    var inputs: SearchBarViewModelInputs { get }
}

class SearchBarViewModel: SearchBarViewModelOutputs, SearchBarViewModelInputs, SearchBarViewModelType {
    var inputs: SearchBarViewModelInputs { return self }
    var outputs: SearchBarViewModelOutputs { return self }
    
    private let disposeBag = DisposeBag()
    
    ///inputs
    let setText = BehaviorRelay<String>(value: "")
    let textDidChanged = PublishRelay<Void>()
    let setPlaceholder = PublishRelay<String>()
    
    ///outputs
    let text: Driver<String>
    let placeholder: Driver<String>
    
    init() {
        text = textDidChanged.asDriver(onErrorDriveWith: Driver.empty())
            .debounce(.milliseconds(500))
            .withLatestFrom(setText.asDriver(onErrorDriveWith: Driver.empty()))
        
        placeholder = setPlaceholder.asDriver(onErrorDriveWith: Driver.empty())
    }
}
