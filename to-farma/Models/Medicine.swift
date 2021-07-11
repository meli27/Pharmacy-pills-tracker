//
//  Medicine.swift
//  to-farma
//
//  Created by Melissa Villalobos on 27/6/21.
//

import Foundation

struct Medicine: Codable{
    let id: Int?
    let logo: String?
    let name: String?
    let measurementUnits: String?
    let presentation: String?
    let quantity: Int?
    let dataSheet: String?
}
