//
//  TransferModels.swift
//  Project
//
//  Created by Park on 2021/06/12.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum TransferModels {
    enum Auth {
        struct Request {
        }
        struct Response {
            var authData: AuthData?
            var error: Error?
        }
        struct ViewModel {
            var authData: AuthData?
            var errorMessage: String?
        }
        enum Error {
            case _인증수단잠김
            case fetchLoginTypeError (FetchLoginTypeError)
            case fetchTridError (FetchTridError)
            case reqeustOnePassError (RequestOnePassError)
        }
    }
    enum Transfer {
        struct Request {
            var amount: Int
            var bankCode: String
        }
        struct Response {
            var successMessage: String?
            var error: Error?
        }
        struct ViewModel {
            var successMessage: String?
            var errorMessage: String?
        }
        enum Error {
            case ourTransferError (OurTransferError)
            case otherTransferError (OtherTransferError)
        }
    }
}
