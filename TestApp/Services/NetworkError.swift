//
//  NetworkError.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/21/25.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case noInternet
    case noData
    case decodingError(Error)
    case requestFailed(statusCode: Int, message: String?)
    case unknown(Error)
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .noInternet:
            return "No internet connection. Please check your network settings."
        case .noData:
            return "No data received from the server."
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .requestFailed(let statusCode, let message):
            return "Request failed with status code \(statusCode). \(message ?? "")"
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}
