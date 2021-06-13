//
//  RequestOnePassManagerDTO.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

enum RequestOnePassManagerError: LibraryError {
    case 사용자취소 (ErrorCode)
    case 정보변경 (ErrorCode)
    case 오류횟수초과 (ErrorCode)
    case 네트워크연결오류 (ErrorCode)
    case 휴대폰미설정 (ErrorCode)
    case 인증불일치 (ErrorCode)
    case 세션초과 (ErrorCode)
    case defaultError (ErrorValue)
}

typealias RequestOnePassManagerResult = LibraryResult<AuthData, RequestOnePassManagerError>
