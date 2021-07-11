//
//  Blog.swift
//  to-farma
//
//  Created by Melissa Villalobos on 23/5/21.
//

import Foundation

struct Post: Codable {
    let id: Int
    let title: String
    let banner: String?
    let date: String
    let text: String
    let created_at: String
    let updated_at: String
}
