//
//  User.swift
//  to-farma
//
//  Created by Melissa Villalobos on 23/5/21.
//

import Foundation

struct User: Codable {
    let id: Int
    let isActive: Bool?
    let name: String?
    let identification: String?
    let phone: String?
    let education: String?
    let notes: String?
    let address: String?
    let addressLink: String?
    let email: String
    let account: String?
    let birthDate: Date?
    let password: String?
    let avatar: String?
    let adherenceValue: String?
    let adherenceCategorisation: String?
    let diagnosticValue: String?
    let diagnosticCategorisation: String?
    let roles: [Role]?
}
