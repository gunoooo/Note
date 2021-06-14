//
//  BankingError.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

protocol BankingError: SHBError {}

enum OurTransferError: BankingError, NetworkErrorable {
    case _잔액부족
    case _계좌조회오류
    case networkError (APINetworkError)
}

enum OtherTransferError: BankingError, NetworkErrorable {
    case _잔액부족
    case _계좌조회오류
    case _타행점검시간
    case networkError (APINetworkError)
}
