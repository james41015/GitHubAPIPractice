//
//  SearchResponseModel.swift
//  GitHubAPIPractice
//
//  Created by Hong James on 2019/7/26.
//  Copyright © 2019 Hong James. All rights reserved.
//

import Foundation

class SearchResponseModel: Codable {
    
    var items: [User]
    
 
}

class User: Codable {
    
    var login: String
    var avatarUrl: String
}
