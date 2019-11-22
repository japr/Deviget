//
//  RedditList.swift
//  DevigetTest
//
//  Created by Jorge Palacio on 22/11/19.
//  Copyright © 2019 Jorge Palacio. All rights reserved.
//

import Foundation

struct RedditList {
    let after: String?
    let before: String?
    let posts: [RedditPost]
}

extension RedditList: Decodable {
    enum DataKey: String, CodingKey {
        case data
    }
    enum ValuesKey: String, CodingKey {
        case after
        case before
        case posts = "children"
    }
    
    init(from decoder: Decoder) throws {
        let mainContainer = try decoder.container(keyedBy: DataKey.self)
        let dataContainer = try mainContainer.nestedContainer(keyedBy: ValuesKey.self, forKey: .data)
        after = try dataContainer.decodeIfPresent(String.self, forKey: .after)
        before = try dataContainer.decodeIfPresent(String.self, forKey: .before)
        posts = try dataContainer.decode([RedditPost].self, forKey: .posts)
    }
}
