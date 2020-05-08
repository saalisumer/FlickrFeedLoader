//
//  HTTPClient.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 08/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
import Foundation
public enum HTTPClientResult{
    case success(Data,HTTPURLResponse)
    case failure(HTTPClientError)
}

public enum HTTPClientError:Swift.Error,Equatable{
    case invalidData
    case unauthorized
    case forbiddenNeedToRegisterAgain
    case loggedOut
    case badRequest
    case unprocessableEntity
    case internalServerError
    case connectivity
}

public class ResponseAndErrorToHTTPClientErrorMapper{
    public static func map(error:NSError?, response:HTTPURLResponse) -> HTTPClientError
    {
        switch response.statusCode {
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 403:
            return .forbiddenNeedToRegisterAgain
        case 422:
            return .unprocessableEntity
        case 452:
            return .loggedOut
        case 500:
            return .internalServerError
        default:
            return .connectivity
        }
    }
}

public protocol HTTPClient {
    func performRequest(from urlRequest:URLRequest, completion: @escaping (HTTPClientResult)->Void)
}
