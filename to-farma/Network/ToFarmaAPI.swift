//
//  ToFarmaProvider.swift
//  to-forma
//
//  Created by Melissa Villalobos on 20/5/21.
//

import Foundation
import Moya

enum ToFarmaAPI {
    case blog
    case user
}

extension ToFarmaAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://admin.tofarma.com/api") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .blog:
            return "/post"
        case .user:
            return "/user"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .blog:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .user:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
