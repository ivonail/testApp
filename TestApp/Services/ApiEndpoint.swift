//
//  ApiEndpoint.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/21/25.
//

import Foundation
import Alamofire

public protocol ApiEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var isMultipart: Bool { get }
}

public extension ApiEndpoint {
    var headers: HTTPHeaders {
        ["Content-Type": "application/json"]
    }

    var encoding: ParameterEncoding {
        JSONEncoding.default
    }

    var isMultipart: Bool {
        false
    }
}
