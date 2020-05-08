//
//  URLRequestHelper.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 08/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
public enum HTTPMethod:String{
    case HTTPMethodGet = "GET"
    case HTTPMethodPost = "POST"
}

@objc public final class URLRequestHelper:NSObject {
    public static func getURLRequestFromURLString(urlString:String, queryParams:[String:Any]?, bodyParams:[String:Any]?, headers:[String:String]?, method:HTTPMethod) -> URLRequest? {
        guard urlString.count > 0 else
        {
            return nil
        }
        
        var request = URLRequest(url: self.getURL(urlString: urlString, params: queryParams), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 100)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        switch method {
            case .HTTPMethodGet:
                request.httpBody = nil
            case .HTTPMethodPost:
                request.httpBody = self.getDataFor(params: bodyParams)
        }
        return request
    }
    
    private static func getURL(urlString:String, params:[String:Any]?) -> URL {
        guard params != nil else {
            return URL(string:urlString)!
        }
        
        var url = urlString
        var firstVal = true
        
        for (key,val) in params!
        {
            if firstVal{
                url.append("?\(key)=\(val)")
            }
            else{
                url.append("&\(key)=\(val)")
            }
            firstVal = false
        }
        return URL(string:url)!
    }
    
    private static func getDataFor(params:[String:Any]?) -> Data? {
        guard params != nil else {
            return try? JSONSerialization.data(withJSONObject: [String:Any](), options: [])
        }
        
        return try? JSONSerialization.data(withJSONObject: params!, options: [])
    }
}
