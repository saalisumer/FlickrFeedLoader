//
//  FlickrResponseMapper.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 08/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
typealias FlickrResult = Swift.Result<FlickrResponse, HTTPClientError>

final class FlickrResponseMapper{
    internal static func map(_ data:Data, response:HTTPURLResponse) -> FlickrResult
    {
        do {
            let decodedResponse = try JSONDecoder().decode(FlickrResponseDTO.self, from: data)
            if response.statusCode != OK_200
            {
              return .failure(ResponseAndErrorToHTTPClientErrorMapper.map(error: nil, response: response))
            }

            return .success(decodedResponse.response)
        } catch {
            return .failure(.invalidData)
        }
    }
    private static var OK_200: Int { return 200 }
}

private struct FlickrResponseDTO:Decodable{
    private let title:String
    private let link:String
    private let description:String
    private let items:[FlickrItemDTO]
    
    var response:FlickrResponse{
        FlickrResponse(title: title, link: link, description: description, items: items.map{ $0.item })
    }
    
    private struct FlickrItemDTO:Decodable{
        private let title:String
        private let link:String
        private let media:[String:String]
        private let date_taken:String
        private let description:String
        private let author:String
        private let author_id:String
        private var imageURL:String{
            return media["m"] ?? ""
        }
        
        var item:FlickrItem{
            return FlickrItem(title: title, link: link, imageURL: imageURL, dateTaken: date_taken, description: description, author: author, authorId: author_id)
        }
    }
}
