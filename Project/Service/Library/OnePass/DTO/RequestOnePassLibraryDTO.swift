//
//  RequestOnePassManagerDTO.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

enum RequestOnePassLibraryError: LibraryError {
    case _사용자취소 (ErrorCode)
    case _정보변경 (ErrorCode)
    case _오류횟수초과 (ErrorCode)
    case _네트워크연결오류 (ErrorCode)
    case _휴대폰미설정 (ErrorCode)
    case _인증불일치 (ErrorCode)
    case _세션초과 (ErrorCode)
    case defaultError (ErrorValue)
}

typealias RequestOnePassManagerResult = LibraryResult<AuthData, RequestOnePassLibraryError>
