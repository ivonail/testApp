//
//  Repo.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/21/25.
//

import Foundation

struct Repo: Codable, Identifiable {
    let id: Int?
    let name: String?
    let forksCount: Int?
    let watchersCount: Int?
    let openIssuesCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case forksCount = "forks_count"
        case watchersCount = "watchers_count"
        case openIssuesCount = "open_issues_count"
    }
}
