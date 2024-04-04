//
//  Reddit.swift
//  The Grint Test
//
//  Created by Pedro Toro on 4/3/24.
//

import Foundation

struct Reddit: Decodable {
    let title: String
    let author: String
    let createdAt: Double
    let thumbnail: String
    let totalComments: Int
    let subreddit: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case subreddit
        case thumbnail
        case createdAt = "created_utc"
        case totalComments = "num_comments"
    }
    
}
