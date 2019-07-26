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
    
    func search(keyWord: String, completionHandler: @escaping (SearchResponseModel?, NSError?) -> ()) -> DataRequest {
        
        let parameters: Parameters = [
            "q": keyWord
        ]
        
        let request = ApiManager.sharedInstance.getRequest(url: searchUrl, parameters: parameters, completionHandler: completionHandler)
        
        return request
    }
}
