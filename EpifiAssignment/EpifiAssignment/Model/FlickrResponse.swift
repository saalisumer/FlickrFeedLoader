//
//  FlickrResponse.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 08/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
struct FlickrResponse{
    let title:String
    let link:String
    let description:String
    let items:[FlickrItem]
    init(title:String, link:String, description:String, items:[FlickrItem]) {
        self.title = title
        self.link = link
        self.description = description
        self.items = items
    }
}
