//
//  Visit.swift
//  to-farma
//
//  Created by Melissa Villalobos on 21/7/21.
//

import Foundation

struct Visit: Decodable {
    let date: String
    let address: String
    let address_link: String
    let pharmacist_id: Int
    let patient_id: Int
    let created_at: String
    let updated_at: String
    let day: Int
    let month: String
}
