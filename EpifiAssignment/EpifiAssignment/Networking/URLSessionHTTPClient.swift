//
//  URLSessionHTTPClient.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 08/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
import Foundation
public class URLSessionHTTPClient:HTTPClient{
    
    private let session:URLSession
    public init(session:URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.session = session
    }
        
    public func performRequest(from urlRequest:URLRequest, completion: @escaping (HTTPClientResult)->Void){
    session.dataTask(with: urlRequest) {(data, response, error) in
            if let err = error as NSError?, let response = response as? HTTPURLResponse
            {
                let err = ResponseAndErrorToHTTPClientErrorMapper.map(error: err, response: response)
                completion(.failure(err))
            }
            else if let data = data, let response = response as? HTTPURLResponse
            {
                if response.statusCode >= 200 && response.statusCode <= 299{
                    completion(.success(data, response))
                }
                else{
                    let err = ResponseAndErrorToHTTPClientErrorMapper.map(error: nil, response: response)
                    completion(.failure(err))
                }
            }
            else
            {
                completion(.failure(.connectivity))
            }
        }.resume()
    }
}
