//
//  InstagramSimpleUser.swift
//  instacount
//
//  Created by Atom - Sachin on 9/23/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import Foundation

struct InstagramSimpleUser: Decodable {
    let id: String
    let username: String
    let profilePicture: String
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case profilePicture = "profile_picture"
        case fullName = "full_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        profilePicture = try container.decode(String.self, forKey: .profilePicture)
        fullName = try container.decode(String.self, forKey: .fullName)
    }
}

