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
    
    var loginType: LoginType = ._패턴
    
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
                case ._간편비밀번호:
                    authUserDefaults.isPinLock = newValue
                case ._패턴:
                    authUserDefaults.isPatternLock = newValue
                default:
                    break
            }
        }
        get {
            switch loginType {
                case ._간편비밀번호:
                    return authUserDefaults.isPinLock
                case ._패턴:
                    return authUserDefaults.isPatternLock
                default:
                    return false
            }
        }
    }
    
    private var fetchTridCompletion: ((FetchTridResult) -> Void)?
    
    /// 유효시간 체크 후 만료된 경우 세션초과 에러 리턴
    @objc private func checkEffectiveTime(_ notification: Notification) {
        fetchTridCompletion?(.failure(._백그라운드세션초과))
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
        onePassLibrary.requestOnePass(trid: trid) { result in
            switch result {
                case .success(let authData):
                    completion(.success(authData))
                case .failure(let error):
                    switch error {
                        case ._인증키오류:
                            completion(.failure(._인증키오류))
                        case ._데이터처리오류:
                            completion(.failure(._데이터처리오류))
                        case ._사용자취소(let errorCode):
                            completion(.failure(._사용자취소(errorCode)))
                        case ._정보변경(let errorCode):
                            completion(.failure(._정보변경(errorCode)))
                        case ._오류횟수초과(let errorCode):
                            completion(.failure(._오류횟수초과(errorCode)))
                        case ._네트워크연결오류(let errorCode):
                            completion(.failure(._네트워크연결오류(errorCode)))
                        case ._휴대폰미설정(let errorCode):
                            completion(.failure(._휴대폰미설정(errorCode)))
                        case ._인증불일치(let errorCode):
                            completion(.failure(._인증불일치(errorCode)))
                        case ._세션초과(let errorCode):
                            completion(.failure(._세션초과(errorCode)))
                        case .defaultError(let errorValue):
                            completion(.failure(.defaultError(errorValue)))
                    }
            }
        }
    }
}
