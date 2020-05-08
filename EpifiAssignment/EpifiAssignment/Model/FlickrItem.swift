//
//  FlickrItem.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 08/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
struct FlickrItem{
    let title:String
    let link:String
    let imageURL:String
    let dateTaken:String
    let description:String
    let author:String
    let authorId:String
    init(title:String, link:String, imageURL:String, dateTaken:String, description:String, author:String, authorId:String) {
        self.title = title
        self.link = link
        self.imageURL = imageURL
        self.dateTaken = dateTaken
        self.description = description
        self.author = author
        self.authorId = authorId
    }
}
