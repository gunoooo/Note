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

typealias OtherTransferNetworkResult = NetworkResult<OtherTransferAPIResponse>

enum OtherTransferAPIError: APIError {
    case 잔액부족
    case 계좌조회오류
    case 타행점검시간
    case networkError (APINetworkError)
}

typealias OtherTransferAPIResult = APIResult<타행이체결과, OtherTransferAPIError>
