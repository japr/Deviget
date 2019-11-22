//
//  RedditPost.swift
//  DevigetTest
//
//  Created by Jorge Palacio on 22/11/19.
//  Copyright © 2019 Jorge Palacio. All rights reserved.
//

import Foundation

struct RedditPost {
    let author: String
    let createdDate: Double
    let numberOfComments: Int
    let thumbnailURL: String
    let title: String
    var unread: Bool
}

extension RedditPost: Decodable {
    
    enum MainKey: String, CodingKey {
        case data
    }
    
    enum CodingKeys: String, CodingKey {
        case author
        case createdDate = "created"
        case numberOfComments = "num_comments"
        case thumbnailURL = "thumbnail"
        case title
    }
    
    init(from decoder: Decoder) throws {
        let mainContainer = try decoder.container(keyedBy: MainKey.self)
        let data = try mainContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        author = try data.decode(String.self, forKey: .author)
        createdDate = try data.decode(Double.self, forKey: .createdDate)
        numberOfComments = try data.decode(Int.self, forKey: .numberOfComments)
        thumbnailURL = try data.decode(String.self, forKey: .thumbnailURL)
        title = try data.decode(String.self, forKey: .title)
        unread = true
    }
}
