//
//  AccessToken.swift
//  to-farma
//
//  Created by Melissa Villalobos on 23/5/21.
//

import Foundation

struct AccessToken: Codable{
    let token_type: String
    let expires_in: Int
    let access_token: String
    let refresh_token: String
}
