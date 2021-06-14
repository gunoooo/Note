//
//  RequestTridDTO.swift
//  Project
//
//  Created by Park on 2021/06/12.
//

import Foundation

struct RequestTridAPIRequest: APIRequest {
    
}

struct RequestTridAPIResponse {
    var header: Any
    var body: RequestTridAPIResponse.Body
    
    struct Body {
        var trid: String
    }
}

enum RequestTridAPIError: APIError {
    case networkError (APINetworkError)
}

typealias RequestTridAPIResult = APIResult<FidoData, RequestTridAPIError>
