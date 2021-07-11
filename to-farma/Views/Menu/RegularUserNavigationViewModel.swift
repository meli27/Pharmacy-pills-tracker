//
//  RegularUserNavigationViewModel.swift
//  to-farma
//
//  Created by Melissa Villalobos on 24/6/21.
//

import Foundation
import RxSwift
import RxCocoa

class RegularUserNavigationViewModel {
    private let disposeBag = DisposeBag()
    static let shared = RegularUserNavigationViewModel()
    
    ///inputs
    let setSelectedValue = BehaviorRelay<String>(value: "")
    let setCurrentController = BehaviorRelay<Int>(value: 0)
    
    ///outputs
    let selectedValue: Driver<String>
    let currentController: Driver<Int>
    
    init() {
        selectedValue = setSelectedValue.asDriver(onErrorDriveWith: Driver.empty())
        
        currentController = setCurrentController.asDriver(onErrorDriveWith: Driver.empty())
    }
}
