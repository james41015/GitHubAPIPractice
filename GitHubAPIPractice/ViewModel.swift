//
//  ViewModel.swift
//  GitHubAPIPractice
//
//  Created by Hong James on 2019/7/26.
//  Copyright © 2019 Hong James. All rights reserved.
//

import Foundation
import Alamofire

class ViewModel {
    let searchUrl = "https://api.github.com/search/users"
    
    @discardableResult
    func search(keyWord: String, page: String, completionHandler: @escaping (SearchResponseModel?, HTTPURLResponse?, NSError?) -> ()) -> DataRequest {
        
        let parameters: Parameters = [
            "q": keyWord,
            "page": page
        ]
        
        let request = ApiManager.sharedInstance.getRequest(url: searchUrl, parameters: parameters, completionHandler: completionHandler)
        
        return request
    }
    
    @discardableResult
    func loadNextPage(nextPageUrl: String, completionHandler: @escaping (SearchResponseModel?, HTTPURLResponse?, NSError?) -> ()) -> DataRequest {

        let request = ApiManager.sharedInstance.getRequest(url: nextPageUrl, parameters: Parameters(),  completionHandler: completionHandler)
        
        return request
    }
    
    func getNextPageFromHeaders(response: HTTPURLResponse?) -> String? {
        if let linkHeader = response?.allHeaderFields["Link"] as? String {
            let links = linkHeader.components(separatedBy: ",")
            
            var dictionary: [String: String] = [:]
            links.forEach({
                let components = $0.components(separatedBy:"; ")
                let cleanPath = components[0].trimmingCharacters(in: CharacterSet(charactersIn: " <>"))
                dictionary[components[1]] = cleanPath
            })
            
            if let nextPagePath = dictionary["rel=\"next\""] {
                print("nextPagePath: \(nextPagePath)")
               
                return nextPagePath
            }
            
            //Bonus
//            if let lastPagePath = dictionary["rel=\"last\""] {
//                print("lastPagePath: \(lastPagePath)")
//            }
//            if let firstPagePath = dictionary["rel=\"first\""] {
//                print("firstPagePath: \(firstPagePath)")
//            }
        }
        return nil
    }
}
