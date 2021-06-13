//
//  AuthAPI.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

protocol AuthAPIProtocol {
    func requestTrid(completion: @escaping (RequestTridAPIResult) -> Void)
}

class AuthAPI: AuthAPIProtocol {
    private var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func requestTrid(completion: @escaping (RequestTridAPIResult) -> Void) {
        networkManager.request(RequestTridAPIRequest()) { (result: RequestTridNetworkResult) in
            switch result {
                case .success(let response):
                    completion(.success(FidoData(trid: response.body.trid)))
                case .failure(let error):
                    switch error.errorValue.errorCode {
                        default:
                            completion(.failure(.networkError(APINetworkError(error))))
                    }
            }
        }
    }
}
