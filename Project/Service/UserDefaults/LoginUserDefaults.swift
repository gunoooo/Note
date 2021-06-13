//
//  LoginUserDefaults.swift
//  Project
//
//  Created by Park on 2021/06/13.
//

import Foundation

protocol LoginUserDefaultsProtocol {
    var preLoginType: LoginType? { get set }
}

class LoginUserDefaults: LoginUserDefaultsProtocol {
    var preLoginType: LoginType? {
        get {
            return .간편비밀번호
        }
        set {
            
        }
    }
}
