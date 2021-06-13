//
//  NetworkResult.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

enum NetworkResult<T> {
    case success (T)
    case failure (NetworkError)
}
