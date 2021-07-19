//
//  DropdownPickerViewModel.swift
//  to-farma
//
//  Created by Melissa Villalobos on 17/7/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol DropdownPickerViewModelInputs {
    var setText: PublishRelay<String> { get }
    var setPlaceholder: PublishRelay<String> { get }
}

protocol DropdownPickerViewModelOutputs {
    var text: Driver<String> { get }
    var placeholder: Driver<String> { get }
}

protocol DropdownPickerViewModelType {
    var outputs: DropdownPickerViewModelOutputs { get }
    var inputs: DropdownPickerViewModelInputs { get }
}

class DropdownPickerViewModel: DropdownPickerViewModelOutputs, DropdownPickerViewModelInputs, DropdownPickerViewModelType {
    var inputs: DropdownPickerViewModelInputs { return self }
    var outputs: DropdownPickerViewModelOutputs { return self }
    
    private let disposeBag = DisposeBag()
    
    ///inputs
    let setText = PublishRelay<String>()
    let setPlaceholder = PublishRelay<String>()
    
    ///outputs
    let text: Driver<String>
    let placeholder: Driver<String>
    
    init() {
        text = setText.asDriver(onErrorDriveWith: Driver.empty())
        
        placeholder = setPlaceholder.asDriver(onErrorDriveWith: Driver.empty())
    }
}
