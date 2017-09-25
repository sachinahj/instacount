//
//  InstagramResponse.swift
//  instacount
//
//  Created by Atom - Sachin on 9/23/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import Foundation

struct InstagramUserResponse: Decodable {
    let data: InstagramUser?
    let meta: InstagramMeta
}

struct InstagramRelationshipResponse: Decodable {
    let data: [InstagramSimpleUser]
    let meta: InstagramMeta
}

struct InstagramRecentMediaResponse: Decodable {
    let data: [InstagramMedia]?
    let meta: InstagramMeta
}

struct InstagramMediaResponse: Decodable {
    let data: InstagramMedia
    let meta: InstagramMeta
}

struct InstagramLikesResponse: Decodable {
    let data: [InstagramSimpleUser]
    let meta: InstagramMeta
}

struct InstagramCommentsResponse: Decodable {
    let data: [InstagramComment]
    let meta: InstagramMeta
}

struct InstagramMeta: Decodable {
    let code: Int
    let errorType: String?
    let errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case errorType = "error_type"
        case errorMessage = "error_message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int.self, forKey: .code)
        errorType = try container.decodeIfPresent(String.self, forKey: .errorType)
        errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
    }
}
