//
//  AuthAppInfo.swift
//  Project
//
//  Created by Park on 2021/06/13.
//

import Foundation

protocol AuthUserDefaultsProtocol {
    var preFidoData: FidoData? { get set }
    var isPinLock: Bool { get set }
    var isPatternLock: Bool { get set }
}

class AuthUserDefaults: AuthUserDefaultsProtocol {
    var preFidoData: FidoData? {
        get {
            return FidoData(trid: "")
        }
        set {
            
        }
    }
    
    var isPinLock: Bool {
        get {
            return false
        }
        set {
            
        }
    }
    
    var isPatternLock: Bool {
        get {
            return false
        }
        set {
            
        }
    }
}
