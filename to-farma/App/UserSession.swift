//
//  UserSession.swift
//  to-farma
//
//  Created by Melissa Villalobos on 19/6/21.
//

import Foundation
import Security
import UIKit

class KeychainServicesManager {
    static func setNewAuthToken(authToken: String) {
        if let _ = self.fetchAuthToken() {
            let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                        kSecAttrService as String: "TF".data(using: .utf8)!]
            let attributes: [String: Any] = [kSecValueData as String: authToken.data(using: .utf8)!]
            let _ = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        } else {
            let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                        kSecAttrService as String: "TF".data(using: .utf8)!,
                                        kSecValueData as String: authToken.data(using: .utf8)!
            ]
            let _ = SecItemAdd(query as CFDictionary, nil)
        }
    }
    
    static func fetchAuthToken() -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrService as String: "TF".data(using: .utf8)!,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound,
              status == errSecSuccess,
              let existingItem = item as? [String: Any],
              let authTokenData = existingItem[kSecValueData as String] as? Data,
              let authToken = String(data: authTokenData, encoding: .utf8) else { return nil }
        return authToken
    }
    
    static func deleteAuthToken() {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrService as String: "TF".data(using: .utf8)!
        ]
        let _ = SecItemDelete(query as CFDictionary)
    }
}

