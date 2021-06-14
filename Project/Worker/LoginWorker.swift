//
//  LoginWorker.swift
//  Project
//
//  Created by Park on 2021/06/13.
//

import Foundation

typealias FetchLoginTypeResult = Result<LoginType, FetchLoginTypeError>

protocol LoginWorkerProtocol {
    func fetchLoginType(completion: @escaping (FetchLoginTypeResult) -> Void)
}

class LoginWorker: LoginWorkerProtocol {
    var loginUserDefaults: LoginUserDefaultsProtocol
    
    init(
        loginUserDefaults: LoginUserDefaultsProtocol = LoginUserDefaults()
    ) {
        self.loginUserDefaults = loginUserDefaults
    }
    
    func fetchLoginType(completion: @escaping (FetchLoginTypeResult) -> Void) {
        if let loginType = loginUserDefaults.preLoginType {
            completion(.success(loginType))
        } else {
            completion(.failure(._로그인수단확인불가))
        }
    }
}
