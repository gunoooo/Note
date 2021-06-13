//
//  APIError.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

protocol APIError: NetworkErrorable, Error {}

protocol NetworkErrorable {
    static func networkError(_ networkError: APINetworkError) -> Self
}

struct APINetworkError: Error {
    private var networkError: NetworkError
    
    init(_ networkError: NetworkError) {
        self.networkError = networkError
    }
    
    func perform(_ errorEvent: @escaping ErrorEvent) {
        networkError.errorEvent?(
            networkError.errorValue
        ) ?? errorEvent(
            networkError.errorValue
        )
    }
}
