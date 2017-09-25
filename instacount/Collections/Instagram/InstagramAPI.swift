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
   
    func getUser(userId: String?, completion: @escaping (Result<InstagramUser>) -> Void) {
        do {
            guard let accessToken = accessToken else { throw InstagramAPIError.NoAccessToken }
            let userId = userId ?? "self"
            let urlString = String(
                format: "%@users/%@?access_token=%@",
                arguments: [INSTAGRAM.BASEURL, userId, accessToken]
            )
            guard let url = URL(string: urlString) else { throw InstagramAPIError.InvalidURL }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    guard let json = data else { throw InstagramAPIError.NetworkError }
                    let instagramUserResponse = try self.decoder.decode(InstagramUserResponse.self, from:
                        json)
                    if let user = instagramUserResponse.data, instagramUserResponse.meta.code == 200 {
                        completion(Result.Success(user))
                    } else {
                        throw InstagramAPIError.Non200(meta: instagramUserResponse.meta)
                    }
                } catch {
                    print("getUser: Error |", error.localizedDescription)
                    completion(Result.Failure(error.localizedDescription))
                }
            }.resume()
        } catch {
            print("getUser: Error |", error.localizedDescription)
            completion(Result.Failure(error.localizedDescription))
        }
    }
    
    func getRecentMedia(userId: String?, completion: @escaping (Result<[InstagramMedia]>) -> Void) {
        do {
            guard let accessToken = accessToken else { throw InstagramAPIError.NoAccessToken }
            let userId = userId ?? "self"
            let urlString = String(
                format: "%@users/%@/media/recent?access_token=%@",
                arguments: [INSTAGRAM.BASEURL, userId, accessToken]
            )
            guard let url = URL(string: urlString) else { throw InstagramAPIError.InvalidURL }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    guard let json = data else { throw InstagramAPIError.NetworkError }
                    let instagramRecentMediaResponse = try self.decoder.decode(InstagramRecentMediaResponse.self, from: json)
                    if let recentMedias = instagramRecentMediaResponse.data, instagramRecentMediaResponse.meta.code == 200 {
                        completion(Result.Success(recentMedias))
                    } else {
                        throw InstagramAPIError.Non200(meta: instagramRecentMediaResponse.meta)
                    }
                } catch {
                    print("getRecentMedia: Error |", error.localizedDescription)
                    completion(Result.Failure(error.localizedDescription))
                }
            }.resume()
        } catch {
            print("getRecentMedia: Error |", error.localizedDescription)
            completion(Result.Failure(error.localizedDescription))
        }
    }
    
    func getFollows(completion: @escaping (Result<[InstagramSimpleUser]>) -> Void) {
        do {
            guard let accessToken = accessToken else { throw InstagramAPIError.NoAccessToken }
            let urlString = String(
                format: "%@users/self/follows?access_token=%@",
                arguments: [INSTAGRAM.BASEURL, accessToken]
            )
            guard let url = URL(string: urlString) else { throw InstagramAPIError.InvalidURL }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    guard let json = data else { throw InstagramAPIError.NetworkError }
                    let instagramRelationshipResponse = try self.decoder.decode(InstagramRelationshipResponse.self, from: json)
                    if let users = instagramRelationshipResponse.data, instagramRelationshipResponse.meta.code == 200 {
                        completion(Result.Success(users))
                    } else {
                        throw InstagramAPIError.Non200(meta: instagramRelationshipResponse.meta)
                    }
                } catch {
                    print("getFollows: Error |", error.localizedDescription)
                    completion(Result.Failure(error.localizedDescription))
                }
            }.resume()
        } catch {
            print("getFollows: Error |", error.localizedDescription)
            completion(Result.Failure(error.localizedDescription))
        }
    }
    
    func getFollowedBy(completion: @escaping (Result<[InstagramSimpleUser]>) -> Void) {
        do {
            guard let accessToken = accessToken else { throw InstagramAPIError.NoAccessToken }
            let urlString = String(
                format: "%@users/self/followed-by?access_token=%@",
                arguments: [INSTAGRAM.BASEURL, accessToken]
            )
            guard let url = URL(string: urlString) else { throw InstagramAPIError.InvalidURL }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    guard let json = data else { throw InstagramAPIError.NetworkError }
                    let instagramRelationshipResponse = try self.decoder.decode(InstagramRelationshipResponse.self, from: json)
                    if let users = instagramRelationshipResponse.data, instagramRelationshipResponse.meta.code == 200 {
                        completion(Result.Success(users))
                    } else {
                        throw InstagramAPIError.Non200(meta: instagramRelationshipResponse.meta)
                    }
                } catch {
                    print("getFollows: Error |", error.localizedDescription)
                    completion(Result.Failure(error.localizedDescription))
                }
            }.resume()
        } catch {
            print("getFollows: Error |", error.localizedDescription)
            completion(Result.Failure(error.localizedDescription))
        }
    }
    
    func getRequestedBy(completion: @escaping (Result<[InstagramSimpleUser]>) -> Void) {
        do {
            guard let accessToken = accessToken else { throw InstagramAPIError.NoAccessToken }
            let urlString = String(
                format: "%@users/self/requested-by?access_token=%@",
                arguments: [INSTAGRAM.BASEURL, accessToken]
            )
            guard let url = URL(string: urlString) else { throw InstagramAPIError.InvalidURL }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                do {
                    guard let json = data else { throw InstagramAPIError.NetworkError }
                    let instagramRelationshipResponse = try self.decoder.decode(InstagramRelationshipResponse.self, from: json)
                    if let users = instagramRelationshipResponse.data, instagramRelationshipResponse.meta.code == 200 {
                        completion(Result.Success(users))
                    } else {
                        throw InstagramAPIError.Non200(meta: instagramRelationshipResponse.meta)
                    }
                } catch {
                    print("getFollows: Error |", error.localizedDescription)
                    completion(Result.Failure(error.localizedDescription))
                }
            }.resume()
        } catch {
            print("getFollows: Error |", error.localizedDescription)
            completion(Result.Failure(error.localizedDescription))
        }
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

enum InstagramAPIError: LocalizedError {
    case NoAccessToken
    case InvalidURL
    case NetworkError
    case Non200(meta: InstagramMeta)
    
    var errorDescription: String? {
        switch self {
        case .NoAccessToken:
            return "InstagramAPIError NoAccessToken"
        case .InvalidURL:
            return "InstagramAPIError InvalidURL"
        case let .Non200(meta):
            return "InstagramAPIError Non200: \(meta.errorType ?? ""): \(meta.errorMessage ?? "")"
        case .NetworkError:
            return "InstagramAPIError NetworkError"
        }
    }
}
