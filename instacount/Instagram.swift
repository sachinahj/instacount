//
//  Instagram.swift
//  instacount
//
//  Created by Atom - Sachin on 9/21/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import Foundation

struct INSTAGRAM {
    static let AUTHURL = "https://api.instagram.com/oauth/authorize/"
    static let BASEURL = "https://api.instagram.com/v1/"
    static let CLIENT_ID  = "8088cd61f7c04b4ba550ea9597df64a9"
    static let REDIRECT_URI = "http://localhost:3000/"
    static let SCOPE = "basic+public_content+follower_list"
}

struct InstaMediaList : Decodable {
    let instaMedias: [InstaMedia]
    
    enum CodingKeys: String, CodingKey {
        case instaMedias = "data"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        instaMedias = try container.decode([InstaMedia].self, forKey: .instaMedias)
    }
}

struct InstaMedia: Decodable {
    
    let id: String
    let created: String
    let filter: String
    let type: String
    let likesCount: Int
    let commentsCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case created = "created_time"
        case filter
        case type
        case likes
        case comments
    }
    
    enum LikesCodingKeys: String, CodingKey {
        case likesCount = "count"
    }
    
    enum CommentsCodingKeys: String, CodingKey {
        case commentsCount = "count"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        created = try container.decode(String.self, forKey: .created)
        filter = try container.decode(String.self, forKey: .filter)
        type = try container.decode(String.self, forKey: .type)
        
        let likes = try container.nestedContainer(keyedBy: LikesCodingKeys.self, forKey: .likes)
        likesCount = try likes.decode(Int.self, forKey: .likesCount)
        
        let comments = try container.nestedContainer(keyedBy: CommentsCodingKeys.self, forKey: .comments)
        commentsCount = try comments.decode(Int.self, forKey: .commentsCount)
    }
}
