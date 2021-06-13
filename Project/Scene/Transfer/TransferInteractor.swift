//
//  TransferInteractor.swift
//  Project
//
//  Created by Park on 2021/06/12.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TransferBusinessLogic {
    func auth(request: TransferModels.Auth.Request)
    func transfer(request: TransferModels.Transfer.Request)
}

protocol TransferDataStore {
    
}

class TransferInteractor: TransferBusinessLogic, TransferDataStore {
    var presenter: TransferPresentationLogic?
    
    var authWorker: AuthWorkerProtocol
    var loginWorker: LoginWorkerProtocol
    var bankingWorker: BankingWorkerProtocol
    
    init(
        authWorker: AuthWorkerProtocol = AuthWorker(),
        loginWorker: LoginWorkerProtocol = LoginWorker(),
        bankingWorker: BankingWorkerProtocol = BankingWorker()
    ) {
        self.authWorker = authWorker
        self.loginWorker = loginWorker
        self.bankingWorker = bankingWorker
    }
    
    func auth(request: TransferModels.Auth.Request) {
        loginWorker.fetchLoginType() { [weak self] fetchLoginTypeResult in
            switch fetchLoginTypeResult {
                case .success(let loginType):
                    self?.authWorker.loginType = loginType
                case .failure(let error):
                    self?.presenter?.presentAuthResult(response: .init(error: .fetchLoginTypeError(error)))
            }
        }
        if authWorker.isLock {
            self.presenter?.presentAuthResult(response: .init(error: .인증수단잠김))
            return
        }
        authWorker.fetchTrid() { [weak self] fetchTridResult in
            switch fetchTridResult {
                case .success(let fidoData):
                    self?.authWorker.requestOnePass(trid: fidoData.trid) { [weak self] requestOnePassResult in
                        switch requestOnePassResult {
                            case .success(let authData):
                                self?.presenter?.presentAuthResult(
                                    response: .init(authData: authData)
                                )
                            case .failure(let error):
                                self?.presenter?.presentAuthResult(
                                    response: .init(error: .reqeustOnePassError(error))
                                )
                        }
                    }
                case .failure(let error):
                    self?.presenter?.presentAuthResult(response: .init(error: .fetchTridError(error)))
            }
        }
    }
    
    func transfer(request: TransferModels.Transfer.Request) {
        // 타행/당행 체크
        let bankState = bankingWorker.fetchBankState(bankCode: request.bankCode)
        switch bankState {
            case .당행:
                bankingWorker.ourTransfer(amount: request.amount) { [weak self] ourTransferResult in
                    switch ourTransferResult {
                        case .success(let _당행이체결과):
                            self?.presenter?.presentTransferResult(response: .init(successMessage: _당행이체결과.successMessage))
                        case .failure(let error):
                            self?.presenter?.presentTransferResult(response: .init(error: .ourTransferError(error)))
                    }
                }
            case .타행:
                bankingWorker.otherTransfer(amount: request.amount) { [weak self] ourTransferResult in
                    switch ourTransferResult {
                        case .success(let _타행이체결과):
                            self?.presenter?.presentTransferResult(response: .init(successMessage: _타행이체결과.successMessage))
                        case .failure(let error):
                            self?.presenter?.presentTransferResult(response: .init(error: .otherTransferError(error)))
                    }
                }
        }
    }
}
