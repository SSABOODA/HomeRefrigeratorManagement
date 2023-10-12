//
//  Router.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/12.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    private static let key = APIKey.youtubeAPIKey
    
    //filed: String, maxResults: String
    case search(query: String)
    
    private var baseURL: URL {
        return URL(string: "https://youtube.googleapis.com/youtube/v3/")!
    }
    
    private var path: String {
        switch self {
        case .search:
            return "search"
        }
    }
    
    // X
    var header: HTTPHeaders {
        return ["key": "\(Router.key)"]
    }
    
    private var key: String {
        return Router.key
    }
    
    private var method: HTTPMethod {
        return .get
    }
    
    private var parameters: Parameters? {
        switch self {
        case .search(let query):
            return [
                "key": key,
                "q": query,
                "part": "snippet",
                "maxResults": 3,
                "filed": "items(id,snippet(channelId,title,categoryId),statistics)",
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.headers = header
        urlRequest.method = method
        if let parameters {
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
