//
//  UserRepoEndpoint.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/22/25.
//

import Foundation
import Alamofire

enum UserRepoEndpoint: ApiEndpoint {
    
    case repos(user: String)
    case repoDetails(repoName: String, user: String)
    case tags(repoName: String, user: String)
        
    var path: String {
        switch self {
        case .repos(let user):
            return "/users/\(user)/repos"
        case .repoDetails(let repoName, let user):
            return "/repos/\(user)/\(repoName)"
        case .tags(let repoName, let user):
            return "/repos/\(user)/\(repoName)/tags"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .repos, .repoDetails, .tags:
            return .get
        }
    }
    
    var isMultipart: Bool {
        return false
    }
    
    var parameters: Alamofire.Parameters? {
        return nil
    }
    
    public var headers: HTTPHeaders {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        return headers
    }
}
