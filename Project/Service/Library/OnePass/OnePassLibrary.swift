//
//  OnePassLibrary.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

protocol OnePassLibraryProtocol {
    func requestOnePass(trid: String, completion: @escaping (RequestOnePassManagerResult) -> Void)
}

class OnePassLibrary: OnePassLibraryProtocol {
    private var onePassManager: OnePassManagerProtocol
    
    init(onePassManager: OnePassManagerProtocol = OnePassManager()) {
        self.onePassManager = onePassManager
    }
    
    func requestOnePass(trid: String, completion: @escaping (RequestOnePassManagerResult) -> Void) {
        onePassManager.request(trid)
        
        completion(.failure(._네트워크연결오류("")))
    }
}
