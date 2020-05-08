//
//  BaseRequest.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 08/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
class BaseRequest{
    private var urlString: String
    private var bodyParam: [String:Any]?
    private var queryParam: [String:Any]?
    private var headers: [String:String]?
    private var methodStored: HTTPMethod
    let client: HTTPClient
    init(url: String, bodyParam: [String:Any]?, queryParam:[String:Any]? = [String:Any](), headers:[String:String]?, method: HTTPMethod, client: HTTPClient) {
        self.urlString = url
        self.bodyParam = bodyParam
        self.queryParam = queryParam
        self.headers = headers
        self.client = client
        self.methodStored = method
    }
    
    var urlRequest:URLRequest?{
        return URLRequestHelper.getURLRequestFromURLString(urlString: urlString, queryParams: queryParam, bodyParams: bodyParam, headers: headers, method: methodStored)
    }
    
    func clearParams(){
        self.bodyParam = nil
        self.queryParam = nil
    }
    
    func updateBodyParams(params:[String:Any]){
        if self.bodyParam == nil
        {
            bodyParam = [String:Any]()
        }
        
        for (key,value) in params{
            bodyParam![key] = value
        }
    }
    
    func updateQueryParams(params:[String:Any]){
           if self.queryParam == nil
           {
               queryParam = [String:Any]()
           }
           
           for (key,value) in params{
               queryParam![key] = value
           }
       }

    func updateHeaders(headers:[String:String]){
        if self.headers == nil
        {
            self.headers = [String:String]()
        }
        
        for (key,value) in headers{
            self.headers![key] = value
        }
    }
    
    func appendInURL(string:String){
        self.urlString.append(contentsOf: string)
    }
    
    func updateURL(string:String){
        self.urlString = string
    }
    
    func updateMethod(method:HTTPMethod){
        self.methodStored = method
    }
}
