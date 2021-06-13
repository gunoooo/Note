//
//  BankingError.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

protocol BankingError: SHBError {}

enum OurTransferError: BankingError, NetworkErrorable {
    case 잔액부족
    case 계좌조회오류
    case networkError (APINetworkError)
}

enum OtherTransferError: BankingError, NetworkErrorable {
    case 잔액부족
    case 계좌조회오류
    case 타행점검시간
    case networkError (APINetworkError)
}
