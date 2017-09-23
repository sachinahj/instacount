//
//  InstagramMedia.swift
//  instacount
//
//  Created by Atom - Sachin on 9/22/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import Foundation

struct InstagramMedia: Decodable {
    let id: String
    let user: InstagramSimpleUser
    let images: Images
    let created: String
    let type: String
    let filter: String
    let caption: InstagramComment
    let tags: [String]
    let location: Location
    let likesCount: Int
    let commentsCount: Int
    let userHasLiked: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case user
        case images
        case created = "created_time"
        case type
        case filter
        case caption
        case tags
        case location
        case likes
        case comments
        case userHasLiked = "user_has_liked"
    }
    
    enum LikesCodingKeys: String, CodingKey {
        case likesCount = "count"
    }
    
    enum CommentsCodingKeys: String, CodingKey {
        case commentsCount = "count"
    }
    
    struct Images: Decodable {
        let thumbnail: Image
        let lowResolution: Image
        let standardResolution: Image
        
        enum CodingKeys: String, CodingKey {
            case thumbnail
            case lowResolution = "low_resolution"
            case standardResolution = "standard_resolution"
        }
        
        struct Image: Decodable {
            let width: Int
            let height: Int
            let url: String
            
            enum CodingKeys: String, CodingKey {
                case width
                case height
                case url
            }
        }
    }
    
    struct Location: Decodable {
        let id: Int
        let name: String
        let latitude: Float
        let longitude: Float
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        user = try container.decode(InstagramSimpleUser.self, forKey: .user)
        images = try container.decode(Images.self, forKey: .images)
        created = try container.decode(String.self, forKey: .created)
        type = try container.decode(String.self, forKey: .type)
        filter = try container.decode(String.self, forKey: .filter)
        caption = try container.decode(InstagramComment.self, forKey: .caption)
        tags = try container.decode([String].self, forKey: .tags)
        location = try container.decode(Location.self, forKey: .location)
        
        let likes = try container.nestedContainer(keyedBy: LikesCodingKeys.self, forKey: .likes)
        likesCount = try likes.decode(Int.self, forKey: .likesCount)
        
        let comments = try container.nestedContainer(keyedBy: CommentsCodingKeys.self, forKey: .comments)
        commentsCount = try comments.decode(Int.self, forKey: .commentsCount)
        
        userHasLiked = try container.decode(Bool.self, forKey: .userHasLiked)  
    }
}
