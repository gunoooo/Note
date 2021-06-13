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

typealias OurTransferNetworkResult = NetworkResult<OurTransferAPIResponse>

enum OurTransferAPIError: APIError {
    case 잔액부족
    case 계좌조회오류
    case networkError (APINetworkError)
}

typealias OurTransferAPIResult = APIResult<당행이체결과, OurTransferAPIError>
