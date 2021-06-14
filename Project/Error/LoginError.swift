//
//  LoginError.swift
//  Project
//
//  Created by Park on 2021/06/13.
//

protocol LoginError: SHBError {}

enum FetchLoginTypeError: LoginError {
    case _로그인수단확인불가
}
