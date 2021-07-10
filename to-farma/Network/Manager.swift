//
//  Manager.swift
//  to-farma
//
//  Created by Melissa Villalobos on 23/5/21.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

protocol Networkable {
    var provider: MoyaProvider<ToFarmaAPI> { get }
    func fetchPosts() -> Observable<Post>
}

class NetworkManager: Networkable {
    var provider = MoyaProvider<ToFarmaAPI>()

    func fetchPosts() -> Observable<Post> {
        request(target: .blog)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: ToFarmaAPI) -> Observable<T> {
        return Observable<T>.create { observer in
            self.provider.request(.blog) { result in
                switch result {
                case .success(let response):
                    do {
                        let results = try JSONDecoder().decode(T.self, from: response.data)
                        observer.on(.next(results))
                    } catch let error {
                        observer.onError(error)
                    }
                case .failure(let error):
                    return observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
