//
//  InstagramResponse.swift
//  instacount
//
//  Created by Atom - Sachin on 9/23/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import Foundation

struct InstagramMeta: Decodable {
    let code: Int
}

struct InstagramUserResponse: Decodable {
    let data: InstagramUser
    let meta: InstagramMeta
}

struct InstagramRelationshipResponse: Decodable {
    let data: [InstagramSimpleUser]
    let meta: InstagramMeta
}

struct InstagramRecentMediaResponse: Decodable {
    let data: [InstagramMedia]
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
