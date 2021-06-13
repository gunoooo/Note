//
//  AuthError.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

protocol AuthError: SHBError {}

enum FetchTridError: AuthError, NetworkErrorable {
    case 백그라운드세션초과
    case networkError (APINetworkError)
}

enum RequestOnePassError: AuthError {
    case 데이터처리오류
    case 인증키오류
    case 사용자취소 (ErrorCode)
    case 정보변경 (ErrorCode)
    case 오류횟수초과 (ErrorCode)
    case 네트워크연결오류 (ErrorCode)
    case 휴대폰미설정 (ErrorCode)
    case 인증불일치 (ErrorCode)
    case 세션초과 (ErrorCode)
    case defaultError (ErrorValue)
}
