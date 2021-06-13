//
//  LibraryResult.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

enum LibraryResult<T, E: LibraryError> {
    case success (T)
    case failure (E)
}
