//
//  RequestUtil.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 08/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
struct APIEndPoints{
    static let FLICKR_END_POINT = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&lang=en-us"
}

final class RequestUtil{
    static func getFlickrRequest() -> FlickrRequest{
        let flickrRequest = FlickrRequest(url: APIEndPoints.FLICKR_END_POINT, bodyParam: nil, headers: nil, method: .HTTPMethodGet, client: URLSessionHTTPClient())
        return flickrRequest
    }
}
