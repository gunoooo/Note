//
//  NetworkManager.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T>(
        _ request: APIRequest,
        completion: @escaping (NetworkResult<T>) -> Void
    )
}

class NetworkManager: NetworkManagerProtocol {
    func request<T>(_ request: APIRequest, completion: @escaping (NetworkResult<T>) -> Void) {
        
    }
}
