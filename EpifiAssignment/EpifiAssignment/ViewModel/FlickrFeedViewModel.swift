//
//  FlickrFeedViewModel.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 08/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
typealias FeedLoadingResult = Swift.Result<Void, Error>
typealias FeedLoadingCompletion = (FeedLoadingResult) -> ()

class FlickrFeedViewModel{
    private var latestFlickrResponse:FlickrResponse?
    private var flickrItems:[FlickrItem] = []
    private let flickrRequest:FlickrRequest
    private var nextPageNumber:UInt = 0
    private var isLoading:Bool = false
    var flickrItemsViewModel:[FlickrItemViewModel]{
        self.flickrItems.map{ FlickrItemViewModel(item:$0) }
    }
    
    init(flickrRequest:FlickrRequest){
        self.flickrRequest = flickrRequest
    }
    
    var onLoadFinished:FeedLoadingCompletion?
    
    func load(clear:Bool = false){
        guard isLoading == false else { return }
        isLoading = true
        
        if clear{
            self.resetViewModel()
        }
        
        self.flickrRequest.fetch(pageNumber: nextPageNumber){[weak self] result in
            guard let self = self else { return }
            switch result{
            case let .success(response):
                self.latestFlickrResponse = response
                self.flickrItems.append(contentsOf: response.items)
                self.nextPageNumber += 1
                if let onLoadFinished = self.onLoadFinished{
                    onLoadFinished(.success(Void()))
                }
            case let .failure(error):
                if let onLoadFinished = self.onLoadFinished{
                    onLoadFinished(.failure(error))
                }
            }
            self.isLoading = false
        }
    }
    
    private func resetViewModel(){
        self.latestFlickrResponse = nil
        self.flickrItems.removeAll()
        self.nextPageNumber = 0
        if let onLoadFinished = self.onLoadFinished{
            onLoadFinished(.success(Void()))
        }
    }
}
