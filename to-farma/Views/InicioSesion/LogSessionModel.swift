//
//  LogInViewModel.swift
//  to-farma
//
//  Created by Melissa Villalobos on 23/5/21.
//

import Foundation
import RxSwift
import RxCocoa

class LogInViewModel{
    let disposeBag = DisposeBag()
    //Output
    let tapped: Driver<Void>
    //Input
    let email = PublishRelay<String>()
    let password = PublishRelay<String>()
    let logInTapped = PublishRelay<Void>()
    
    init(networkManager: ToFarmaManager = ToFarmaManager()) {

        let email = email.asDriver(onErrorDriveWith: .empty())
        let password = password.asDriver(onErrorDriveWith: .empty())
        
        let userInfo = Driver.combineLatest(email, password)
        
        tapped = logInTapped
            .withLatestFrom(userInfo)
            .flatMapLatest{ email, password in
                networkManager
                    .fetchToken(username: email, password: password)
                    .map{ token in
                        let accessToken = token.access_token
                        KeychainServicesManager.setNewAuthToken(authToken: accessToken)
                    }
                    .asDriver(onErrorDriveWith: .empty())
            }
            .asDriver(onErrorDriveWith: .empty())
            .map{ _ in () }
        
        //melissamadri@gmail.com Me.2021
    }
}
