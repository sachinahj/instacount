//
//  InstagramUser.swift
//  instacount
//
//  Created by Atom - Sachin on 9/23/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import Foundation

struct InstagramUser: Decodable {
    let id: String
    let username: String
    let profilePicture: String
    let fullName: String
    let bio: String
    let website: String
    let isBusiness: Bool
    let counts: Counts

    enum CodingKeys: String, CodingKey {
        case id
        case username
        case profilePicture = "profile_picture"
        case fullName = "full_name"
        case bio
        case website
        case isBusiness = "is_business"
        case counts
    }
    
    struct Counts: Decodable {
        let media: Int
        let follows: Int
        let followedBy: Int
        
        enum CodingKeys: String, CodingKey {
            case media
            case follows
            case followedBy = "followed_by"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        profilePicture = try container.decode(String.self, forKey: .profilePicture)
        fullName = try container.decode(String.self, forKey: .fullName)
        bio = try container.decode(String.self, forKey: .bio)
        website = try container.decode(String.self, forKey: .website)
        isBusiness = try container.decode(Bool.self, forKey: .isBusiness)
        counts = try container.decode(Counts.self, forKey: .counts)
    }
}
