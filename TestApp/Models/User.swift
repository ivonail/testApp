//
//  User.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/21/25.
//

import Foundation

struct User: Codable {
    let userId: Int?
    let avatarUrl: String?
    let name: String?
    
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case avatarUrl = "avatar_url"
        case name
    }
}
