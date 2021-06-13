//
//  BakingWorker.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

typealias OurTransferResult = Result<당행이체결과, OurTransferError>
typealias OtherTransferResult = Result<타행이체결과, OtherTransferError>

protocol BankingWorkerProtocol {
    func fetchBankState(bankCode: String) -> BankState
    func ourTransfer(amount: Int, completion: @escaping (OurTransferResult) -> Void)
    func otherTransfer(amount: Int, completion: @escaping (OtherTransferResult) -> Void)
}

class BankingWorker: BankingWorkerProtocol {
    var bankingAPI: BankingAPIProtocol
    
    init(bankingAPI: BankingAPIProtocol = BankingAPI()) {
        self.bankingAPI = bankingAPI
    }
    
    func fetchBankState(bankCode: String) -> BankState {
        return .당행
    }
    
    func ourTransfer(amount: Int, completion: @escaping (OurTransferResult) -> Void) {
        bankingAPI.ourTransfer(amount: amount) { result in
            switch result {
                case .success(let _당행이체결과):
                    completion(.success(_당행이체결과))
                case .failure(let error):
                    switch error {
                        case .잔액부족:
                            completion(.failure(.잔액부족))
                        case .계좌조회오류:
                            completion(.failure(.계좌조회오류))
                        case .networkError(let networkError):
                            completion(.failure(.networkError(networkError)))
                    }
            }
        }
    }
    
    func otherTransfer(amount: Int, completion: @escaping (OtherTransferResult) -> Void) {
        bankingAPI.otherTransfer(amount: amount) { result in
            switch result {
                case .success(let _타행이체결과):
                    completion(.success(_타행이체결과))
                case .failure(let error):
                    switch error {
                        case .잔액부족:
                            completion(.failure(.잔액부족))
                        case .계좌조회오류:
                            completion(.failure(.계좌조회오류))
                        case .타행점검시간:
                            completion(.failure(.타행점검시간))
                        case .networkError(let networkError):
                            completion(.failure(.networkError(networkError)))
                    }
            }
        }
    }
}
