//
//  AuthWorker.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

typealias FetchTridResult = Result<FidoData, FetchTridError>
typealias RequestOnePassResult = Result<AuthData, RequestOnePassError>

protocol AuthWorkerProtocol {
    var loginType: LoginType { get set }
    var isLock: Bool { get set }
    func fetchTrid(completion: @escaping (FetchTridResult) -> Void)
    func requestOnePass(trid: String, completion: @escaping (RequestOnePassResult) -> Void)
}

class AuthWorker: AuthWorkerProtocol {
    var authApi: AuthAPIProtocol
    var onePassLibrary: OnePassLibraryProtocol
    var authUserDefaults: AuthUserDefaultsProtocol
    
    var loginType: LoginType = .패턴
    
    init(
        authApi: AuthAPIProtocol = AuthAPI(),
        onePassLibrary: OnePassLibraryProtocol = OnePassLibrary(),
        authUserDefaults: AuthUserDefaultsProtocol = AuthUserDefaults()
    ) {
        self.authApi = authApi
        self.onePassLibrary = onePassLibrary
        self.authUserDefaults = authUserDefaults
    }
    
    var isLock: Bool {
        set {
            switch loginType {
                case .간편비밀번호:
                    authUserDefaults.isPinLock = newValue
                case .패턴:
                    authUserDefaults.isPatternLock = newValue
                default:
                    break
            }
        }
        get {
            switch loginType {
                case .간편비밀번호:
                    return authUserDefaults.isPinLock
                case .패턴:
                    return authUserDefaults.isPatternLock
                default:
                    return false
            }
        }
    }
    
    private var fetchTridCompletion: ((FetchTridResult) -> Void)?
    
    /// 유효시간 체크 후 만료된 경우 세션초과 에러 리턴
    @objc private func checkEffectiveTime(_ notification: Notification) {
        fetchTridCompletion?(.failure(.백그라운드세션초과))
    }
    
    func fetchTrid(completion: @escaping (FetchTridResult) -> Void) {
        fetchTridCompletion = completion
        
        if let preFidodata = authUserDefaults.preFidoData {
            fetchTridCompletion?(.success(preFidodata))
        } else {
            authApi.requestTrid() { [weak self] result in
                switch result {
                    case .success(let fidoData):
                        self?.fetchTridCompletion?(.success(fidoData))
                    case .failure(let error):
                        switch error {
                            case .networkError(let networkError):
                                self?.fetchTridCompletion?(.failure(.networkError(networkError)))
                        }
                }
            }
        }
    }
    
    func requestOnePass(trid: String, completion: @escaping (RequestOnePassResult) -> Void) {
        onePassLibrary.requestOnePassManager(trid: trid) { result in
            switch result {
                case .success(let authData):
                    completion(.success(authData))
                case .failure(let error):
                    switch error {
                        case .사용자취소(let errorCode):
                            completion(.failure(.사용자취소(errorCode)))
                        case .정보변경(let errorCode):
                            completion(.failure(.정보변경(errorCode)))
                        case .오류횟수초과(let errorCode):
                            completion(.failure(.오류횟수초과(errorCode)))
                        case .네트워크연결오류(let errorCode):
                            completion(.failure(.네트워크연결오류(errorCode)))
                        case .휴대폰미설정(let errorCode):
                            completion(.failure(.휴대폰미설정(errorCode)))
                        case .인증불일치(let errorCode):
                            completion(.failure(.인증불일치(errorCode)))
                        case .세션초과(let errorCode):
                            completion(.failure(.세션초과(errorCode)))
                        case .defaultError(let errorValue):
                            completion(.failure(.defaultError(errorValue)))
                    }
            }
        }
    }
}
