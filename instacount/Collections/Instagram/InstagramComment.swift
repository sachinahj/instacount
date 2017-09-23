//
//  InstagramComment.swift
//  instacount
//
//  Created by Atom - Sachin on 9/23/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import Foundation

struct InstagramComment: Decodable {
    let id: String
    let from: InstagramSimpleUser
    let text: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case from
        case text
        case created = "created_time"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        from = try container.decode(InstagramSimpleUser.self, forKey: .from)
        text = try container.decode(String.self, forKey: .text)
        created = try container.decode(String.self, forKey: .created)
    }
}
