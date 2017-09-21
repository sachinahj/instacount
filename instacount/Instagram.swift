//
//  Instagram.swift
//  instacount
//
//  Created by Atom - Sachin on 9/21/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import Foundation

struct INSTAGRAM_CREDS {
    static let AUTHURL = "https://api.instagram.com/oauth/authorize/"
    static let CLIENT_ID  = "8088cd61f7c04b4ba550ea9597df64a9"
    static let REDIRECT_URI = "http://localhost:3000/"
    static let SCOPE = "basic+public_content+follower_list"
}

struct INSTAGRAM_API {
    static let BASEURL = "https://api.instagram.com/v1/"
}
