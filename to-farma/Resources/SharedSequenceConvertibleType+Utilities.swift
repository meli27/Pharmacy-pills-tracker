//
//  SharedSequenceConvertibleType+Utilities.swift
//  to-farma
//
//  Created by Melissa Villalobos on 8/6/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

extension SharedSequenceConvertibleType where Self.SharingStrategy == RxCocoa.DriverSharingStrategy {
    public func drive(_ relay: RxCocoa.PublishRelay<Self.Element>) -> Disposable {
        return self.drive(onNext: {
            relay.accept($0)
        })
    }

    public func mapToVoid() -> Driver<Void> {
        return self.map { _ in }
    }
}
