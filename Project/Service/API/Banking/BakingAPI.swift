//
//  BakingAPI.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

protocol BankingAPIProtocol {
    func ourTransfer(amount: Int, completion: @escaping (OurTransferAPIResult) -> Void)
    func otherTransfer(amount: Int, completion: @escaping (OtherTransferAPIResult) -> Void)
}

class BankingAPI: BankingAPIProtocol {
    private var networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func ourTransfer(amount: Int, completion: @escaping (OurTransferAPIResult) -> Void) {
        networkManager.request(OurTransferAPIRequest(amount: amount)) { (result: OurTransferNetworkResult) in
            switch result {
                case .success(let response):
                    completion(.success(당행이체결과(successMessage: response.body.successMessage)))
                case .failure(let error):
                    switch error.errorValue.errorCode {
                        case "100":
                            completion(.failure(.계좌조회오류))
                        case "300":
                            completion(.failure(.잔액부족))
                        default:
                            completion(.failure(.networkError(APINetworkError(error))))
                    }
            }
        }
    }
    
    func otherTransfer(amount: Int, completion: @escaping (OtherTransferAPIResult) -> Void) {
        networkManager.request(OtherTransferAPIRequest(amount: amount)) { (result: OtherTransferNetworkResult) in
            switch result {
                case .success(let response):
                    completion(.success(타행이체결과(successMessage: response.body.successMessage)))
                case .failure(let error):
                    switch error.errorValue.errorCode {
                        case "100":
                            completion(.failure(.계좌조회오류))
                        case "300":
                            completion(.failure(.잔액부족))
                        case "400":
                            completion(.failure(.타행점검시간))
                        default:
                            completion(.failure(.networkError(APINetworkError(error))))
                    }
            }
        }
    }
}
