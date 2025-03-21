//
//  Tag.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/21/25.
//

import Foundation

struct Tag: Codable {
    let name: String?
    let commit: Commit?
    
    enum CodingKeys: String, CodingKey {
        case name
        case commit
    }
}

struct Commit: Codable {
    let sha: String?
    let url: String?
}
