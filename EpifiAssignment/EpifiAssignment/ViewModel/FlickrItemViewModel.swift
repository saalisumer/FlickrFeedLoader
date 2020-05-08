//
//  FlickrItemViewModel.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 08/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
class FlickrItemViewModel{
    private let flickrItem:FlickrItem
    init(item:FlickrItem){
        self.flickrItem = item
    }
    
    func getImageURL() -> URL? {
        return URL(string:flickrItem.imageURL)
    }
    
    func getTitleLabel() -> String{
        self.flickrItem.title
    }
    
    func getAuthorName() -> String{
        self.flickrItem.author
    }
    
    func getDateTaken() -> String{
        Date.getFormattedDate(string: self.flickrItem.dateTaken, fromFormatter: "yyyy-MM-dd'T'HH:mm:ssZ", toFormatter: "MMM dd, yyyy")
    }
    
    func getDescription() -> String{
        self.flickrItem.description
    }
    
    func getLink() -> String{
        self.flickrItem.link
    }
}
