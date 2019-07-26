//
//  ApiManager.swift
//  GitHubAPIPractice
//
//  Created by Hong James on 2019/7/26.
//  Copyright © 2019 Hong James. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager {
    static let sharedInstance = ApiManager()
    
    func getRequest(url: String ,parameters: Parameters ,completionHandler: @escaping (SearchResponseModel?, HTTPURLResponse?, NSError?) -> ()) -> DataRequest {
        return request(method: .get, url: url, parameters: parameters, completionHandler: completionHandler)
    }
    
    private func request(method: HTTPMethod, url: String ,parameters: Parameters ,completionHandler: @escaping (SearchResponseModel?, HTTPURLResponse?, NSError?) -> ()) -> DataRequest {
        return Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(_):
                let decoder = JSONDecoder()
                
                if let data = response.data, let searchResponse = try?
                    decoder.decode(SearchResponseModel.self, from: data)
                {
                    completionHandler(searchResponse, response.response, nil)
                } else {
                    print("error")
                }
                
            case .failure(let error):
                completionHandler(nil, nil, error as NSError)
            }
        }
    }
}
