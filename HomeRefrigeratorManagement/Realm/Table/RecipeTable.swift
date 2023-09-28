//
//  RecipeTable.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/09/28.
//

import Foundation
import RealmSwift

// Recipe Table
class Recipe: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var videoId: String
    @Persisted var title: String
    @Persisted var desc: String
    @Persisted var thumnail: String
    @Persisted var channelTitle: String
    
    convenience init(
        videoId: String,
        title: String,
        desc: String,
        thumnail: String,
        channelTitle: String
    ) {
        self.init()
        self.videoId = videoId
        self.title = title
        self.desc = desc
        self.thumnail = thumnail
        self.channelTitle = channelTitle
    }
}

