//
//  Firebase.swift
//  instacount
//
//  Created by Atom - Sachin on 9/23/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol FBManagerDelegate: class {
//    func FBManager(friendFound: Friend)
}

extension  FBManagerDelegate {
//    func FBManager(friendFound: Friend) {}
}

class FBManager {
    var ref: DatabaseReference!
    weak var delegate: FBManagerDelegate?
    
    func uploadData(user: InstagramUser, medias: [InstagramMedia]) {
        ref = Database.database().reference()
        
        var updates: [String: [String: Any]] = [:]
        medias.forEach { media in
            print("---media---")
            dump(media)
            
            let row: [String: Any] = [
                "userId": user.id,
                "username": user.username,
                "profilePicture": user.profilePicture,
                "fullName": user.fullName,
                "bio": user.bio,
                "website": user.website,
                "isBusiness": user.isBusiness,
                "mediaCount": user.counts.media,
                "followsCount": user.counts.follows,
                "followedByCount": user.counts.followedBy,
                "mediaId": media.id,
                "image": media.images.standardResolution.url,
                "created": media.created,
                "type": media.type,
                "filter": media.filter,
                "captionText": media.caption.text,
                "tags": media.tags.joined(separator: ","),
                "locationName": media.location?.name ?? "",
                "locationLatitude": media.location?.latitude ?? "",
                "locationLongitude": media.location?.longitude ?? "",
                "likesCount": media.likesCount,
                "commentsCount": media.commentsCount,
                "userHasLiked": media.userHasLiked
            ]
            
            updates["/medias/\(media.id)"] = row
        }
        
        ref.updateChildValues(updates)
    }
}
