//
//  Environment.swift
//  to-farma
//
//  Created by Melissa Villalobos on 23/5/21.
//
import Foundation

enum EnvironmentKey {
    case loginURL
    case authCookie
    case client
    case secret
    case grantType
    case scope
    
    var value: String {
        switch self {
        case .loginURL:
            return "loginURL"
        case .authCookie:
            return "authCookie"
        case .client:
            return "client"
        case .secret:
            return "secret"
        case .grantType:
            return "grantType"
        case .scope:
            return "scope"
        }
    }
}

public struct Environment {
    static let shared = Environment()
    
    fileprivate var infoDict: [String: Any] {
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dictionary
    }
    
    func configuration(_ key: EnvironmentKey) -> String? {
        switch key {
        case .loginURL:
            return infoDict[EnvironmentKey.loginURL.value] as? String
        case .authCookie:
            return infoDict[EnvironmentKey.authCookie.value] as? String
        case .client:
            return infoDict[EnvironmentKey.client.value] as? String
        case .secret:
            return infoDict[EnvironmentKey.secret.value] as? String
        case .grantType:
            return infoDict[EnvironmentKey.grantType.value] as? String
        case .scope:
            return infoDict[EnvironmentKey.scope.value] as? String
        }
    }
}
