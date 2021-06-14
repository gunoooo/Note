//
//  BakingDTO.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

struct OurTransferAPIRequest: APIRequest {
    init(amount: Int) {
        
    }
}

struct OurTransferAPIResponse {
    var header: Any
    var body: OurTransferAPIResponse.Body
    
    struct Body {
        var successMessage: String
    }
}

enum OurTransferAPIError: APIError {
    case _잔액부족
    case _계좌조회오류
    case networkError (APINetworkError)
}

typealias OurTransferAPIResult = APIResult<당행이체결과, OurTransferAPIError>
