//
//  UserDefaultManager.swift
//  to-farma
//
//  Created by Melissa Villalobos on 23/5/21.
//

import RxSwift

class UserDefaultManagement {
    private let preferences = UserDefaults.standard
    static let shared = UserDefaultManagement()
    
    func savePreference(value: Any, key: String) {
        preferences.set(value, forKey: key)
        preferences.synchronize()
    }
    
    func getPreference(key: String) -> String? {
        return preferences.string(forKey: key)
    }
}
