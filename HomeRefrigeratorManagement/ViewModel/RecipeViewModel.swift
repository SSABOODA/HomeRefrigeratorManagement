//
//  RecipeViewModel.swift
//  HomeRefrigeratorManagement
//
//  Created by 한성봉 on 2023/10/12.
//

import Foundation

final class RecipeViewModel {
    
    var youtubeModel = Observable(YoutubeModel(pageInfo: PageInfo(totalResults: 0, resultsPerPage: 0)))
    
    func request(query: String) {
        print(#function)
        Network.shared.requestConvertible(type: YoutubeModel.self, api: Router.search(query: query)) { response in
            switch response {
            case .success(let success):
//                dump("success: \(success)")
                self.youtubeModel.value = success
                print(self.youtubeModel.value)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
    }
}
