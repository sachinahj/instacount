//
//  InstagramAPI.swift
//  instacount
//
//  Created by Atom - Sachin on 9/23/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import Foundation

fileprivate var accessToken: String?

class InstagramAPI {
    
    let decoder: JSONDecoder = JSONDecoder()
    
    func setAccessToken(token: String) { accessToken = token }
   
    func getUser(userId: String?, completion: @escaping (InstagramUser) -> Void) {
        guard let accessToken = accessToken else { return }
        let userId = userId ?? "self"
        let urlString = String(
            format: "%@users/%@?access_token=%@",
            arguments: [INSTAGRAM.BASEURL, userId, accessToken]
        )
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let json = data else { return }
            do {
                let instagramUserResponse = try self.decoder.decode(InstagramUserResponse.self, from: json)
                if let user = instagramUserResponse.data, instagramUserResponse.meta.code == 200 {
                    completion(user)
                } else {
                    print("getUser: non-200 return:", instagramUserResponse.meta.errorType ?? "", ":", instagramUserResponse.meta.errorMessage ?? "")
                }
            } catch {
                print("getUser: JSON decode error", error)
            }
        }.resume()
    }
    
    func getRecentMedia(userId: String?, completion: @escaping ([InstagramMedia]) -> Void) {
        guard let accessToken = accessToken else { return }
        let userId = userId ?? "self"
        let urlString = String(
            format: "%@users/%@/media/recent?access_token=%@",
            arguments: [INSTAGRAM.BASEURL, userId, accessToken]
        )
        guard let url = URL(string: urlString) else {
            print("getRecentMedia")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let json = data else { return }
            do {
                let instagramRecentMediaResponse = try self.decoder.decode(InstagramRecentMediaResponse.self, from: json)
                if let instagramRecentMedias = instagramRecentMediaResponse.data, instagramRecentMediaResponse.meta.code == 200 {
                    completion(instagramRecentMedias)
                } else {
                    print("getRecentMedia: non-200 return:", instagramRecentMediaResponse.meta.errorType ?? "", ":", instagramRecentMediaResponse.meta.errorMessage ?? "")
                }
            } catch {
                print("getRecentMedia: JSON decode error", error)
            }
        }.resume()
    }
    
    func getFollows(completion: @escaping (InstagramRelationshipResponse) -> Void) {
        guard let accessToken = accessToken else { return }
        let urlString = String(
            format: "%@users/self/follows?access_token=%@",
            arguments: [INSTAGRAM.BASEURL, accessToken]
        )
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let json = data else { return }
            // let decoder = JSONDecoder()
            let instagramRelationshipResponse = try! self.decoder.decode(InstagramRelationshipResponse.self, from: json)
            completion(instagramRelationshipResponse)
            }.resume()
    }
    
    func getFollowedBy(completion: @escaping (InstagramRelationshipResponse) -> Void) {
        guard let accessToken = accessToken else { return }
        let urlString = String(
            format: "%@users/self/followed-by?access_token=%@",
            arguments: [INSTAGRAM.BASEURL, accessToken]
        )
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let json = data else { return }
            // let decoder = JSONDecoder()
            let instagramRelationshipResponse = try! self.decoder.decode(InstagramRelationshipResponse.self, from: json)
            completion(instagramRelationshipResponse)
            }.resume()
    }
    
    func getRequestedBy(completion: @escaping (InstagramRelationshipResponse) -> Void) {
        guard let accessToken = accessToken else { return }
        let urlString = String(
            format: "%@users/self/requested-by?access_token=%@",
            arguments: [INSTAGRAM.BASEURL, accessToken]
        )
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let json = data else { return }
            // let decoder = JSONDecoder()
            let instagramRelationshipResponse = try! self.decoder.decode(InstagramRelationshipResponse.self, from: json)
            completion(instagramRelationshipResponse)
            }.resume()
    }
    
    //    func getMedia(mediaId: String, completion: @escaping (InstagramMediaResponse) -> Void) {
    //        guard let accessToken = accessToken else { return }
    //        let urlString = String(
    //            format: "%@media/%@?access_token=%@",
    //            arguments: [INSTAGRAM.BASEURL, mediaId, accessToken]
    //        )
    //        guard let url = URL(string: urlString) else { return }
    //        URLSession.shared.dataTask(with: url) { (data, response, error) in
    //            guard let json = data else { return }
    //            // let decoder = JSONDecoder()
    //            let instagramMediaResponse = try! self.decoder.decode(InstagramMediaResponse.self, from: json)
    //            completion(instagramMediaResponse)
    //            }.resume()
    //    }

    //    func getLikes(mediaId: String, completion: @escaping (InstagramLikesResponse) -> Void) {
    //        guard let accessToken = accessToken else { return }
    //        let urlString = String(
    //            format: "%@media/%@/likes?access_token=%@",
    //            arguments: [INSTAGRAM.BASEURL, mediaId, accessToken]
    //        )
    //        guard let url = URL(string: urlString) else { return }
    //        URLSession.shared.dataTask(with: url) { (data, response, error) in
    //            guard let json = data else { return }
    //            // let decoder = JSONDecoder()
    //            let instagramLikesResponse = try! self.decoder.decode(InstagramLikesResponse.self, from: json)
    //            completion(instagramLikesResponse)
    //            }.resume()
    //    }

    //    func getComments(mediaId: String, completion: @escaping (InstagramCommentsResponse) -> Void) {
    //        guard let accessToken = accessToken else { return }
    //        let urlString = String(
    //            format: "%@media/%@/comments?access_token=%@",
    //            arguments: [INSTAGRAM.BASEURL, mediaId, accessToken]
    //        )
    //        guard let url = URL(string: urlString) else { return }
    //        URLSession.shared.dataTask(with: url) { (data, response, error) in
    //            guard let json = data else { return }
    //            // let decoder = JSONDecoder()
    //            let instagramCommentsResponse = try! self.decoder.decode(InstagramCommentsResponse.self, from: json)
    //            completion(instagramCommentsResponse)
    //        }.resume()
    //    }
    
}
