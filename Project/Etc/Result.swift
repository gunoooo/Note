//
//  Result.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

enum Result<Success, Failure: SHBError> {
    case success (Success)
    case failure (Failure)
}
