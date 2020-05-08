//
//  FlickrRequest.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 08/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
class FlickrRequest:BaseRequest{
    func fetch(pageNumber:UInt, completion: @escaping (FlickrResult)->()){
        self.updateQueryParams(params: ["page":pageNumber])
        if let request = self.urlRequest{
            self.client.performRequest(from: request){ httpClientResult in
                switch httpClientResult{
                    case let .success(data, response):
                        completion(FlickrResponseMapper.map(data, response: response))
                    case let .failure(error):
                        completion(.failure(error))
                }
            }
        }
    }
}
