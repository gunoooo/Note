//
//  NetworkError.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

typealias ErrorCode = String
typealias ErrorMessage = String

struct ErrorValue {
    var errorCode: ErrorCode
    var errorMessage: ErrorMessage
}

typealias ErrorEvent = ((ErrorValue) -> Void)

protocol NetworkError {
    var errorValue: ErrorValue { get }
    var errorEvent: ErrorEvent? { get }
    var xxmTid: String { get }
}

protocol ConnectionError: NetworkError {
    init(error: NSError)
}

protocol ServerError: NetworkError {
    init(response: APIResponse)
}

protocol DisplayError: NetworkError {
    init(response: APIResponse)
}
