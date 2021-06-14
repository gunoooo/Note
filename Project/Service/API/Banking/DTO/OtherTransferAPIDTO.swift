//
//  OtherTransferDTO.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

struct OtherTransferAPIRequest: APIRequest {
    init(amount: Int) {
        
    }
}

struct OtherTransferAPIResponse {
    var header: Any
    var body: OtherTransferAPIResponse.Body
    
    struct Body {
        var successMessage: String
    }
}

enum OtherTransferAPIError: APIError {
    case _잔액부족
    case _계좌조회오류
    case _타행점검시간
    case networkError (APINetworkError)
}

typealias OtherTransferAPIResult = APIResult<타행이체결과, OtherTransferAPIError>
