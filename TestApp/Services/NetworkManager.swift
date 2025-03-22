//
//  NetworkManager.swift
//  TestApp
//
//  Created by Ivona Ilic on 3/21/25.
//

import Foundation
import Alamofire

public class NetworkManager {
    
    private let session: Session
    
    public init(session: Session = .default) {
        self.session = session
    }
    
    public func request<T: Decodable & Sendable>(_ endpoint: ApiEndpoint, responseType: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            session.request(
                Bundle.baseURL + endpoint.path,
                method: endpoint.method,
                parameters: endpoint.parameters,
                encoding: JSONEncoding.default,
                headers: endpoint.headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    let statusCode = response.response?.statusCode ?? -1
                    let message = response.error?.localizedDescription ?? "Unknown error"
                    if let afError = error.asAFError {
                        switch afError {
                        case .sessionTaskFailed:
                            continuation.resume(throwing: NetworkError.noInternet)
                        case .responseSerializationFailed:
                            continuation.resume(throwing: NetworkError.decodingError(error))
                        default:
                            continuation.resume(throwing: NetworkError.requestFailed(statusCode: statusCode, message: message))
                        }
                    } else {
                        continuation.resume(throwing: NetworkError.unknown(error))
                    }
                }
            }
        }
    }
    
}
