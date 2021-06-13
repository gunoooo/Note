//
//  APIResult.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

enum APIResult<T, E: APIError> {
    case success (T)
    case failure (E)
}
