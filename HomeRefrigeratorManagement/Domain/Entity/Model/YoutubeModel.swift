//
//  YoutubeModel.swift

import Foundation

// @deprecated
struct YoutubeModel: Codable {
    let pageInfo: PageInfo
    var items: [Item]?
}

struct PageInfo: Codable {
    let totalResults: Int
    let resultsPerPage: Int
}

struct Item: Codable {
    let id: ID
    var snippet: Snippet?
}

struct ID: Codable {
    let videoId: String
}

struct Snippet: Codable {
    let publishedAt: String
    let title: String
    let description: String
    let thumbnails: Thumbnails
    let channelTitle: String
}

struct Thumbnails: Codable {
    let medium: Medium
}

struct Medium: Codable {
    let url: String
    let width: Int
    let height: Int
}

/*
 {
     "pageInfo": {
         "totalResults": 1000000,
         "resultsPerPage": 1
     },
     "items": [
         {
             "id": {
                 "videoId": "XSjtP5Vw9A8"
             },
             "snippet": {
                 "publishedAt": "2023-06-11T13:04:29Z",
                 "title": "10가지 맛있는 감자 요리!! 집에 감자가 있습니까? 감자요리 몰아보기",
                 "description": "2탄으로 다시 돌아온 놀라운 감자요리 몰아보기입니다. 그 동안 올렸던 감자요리 함께 즐겨주세요. 자매품 스팸요리 몰아보기, 식빵 ...",
                 "thumbnails": {
                     "medium": {
                         "url": "https://i.ytimg.com/vi/XSjtP5Vw9A8/mqdefault.jpg",
                         "width": 320,
                         "height": 180
                     }
                 },
                 "channelTitle": "쿠킹하루 Cooking Haru :)"
             }
         }
     ]
 }
 */
