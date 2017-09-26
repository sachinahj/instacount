//
//  Firebase.swift
//  instacount
//
//  Created by Atom - Sachin on 9/23/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FBManager {
    var ref: DatabaseReference!
    
    func uploadData(user: InstagramUser, medias: [InstagramMedia]) {
        ref = Database.database().reference()
        var updates: [String: [String: Any]] = [:]
        medias.forEach { media in
            let row: [String: Any] = [
                "userId": user.id,
                "userUsername": user.username,
                "userProfilePicture": user.profilePicture,
                "userFullName": user.fullName,
                "userBio": user.bio,
                "userWebsite": user.website,
                "userIsBusiness": user.isBusiness,
                "userMediaCount": user.counts.media,
                "userFollowsCount": user.counts.follows,
                "userFollowedByCount": user.counts.followedBy,
                "mediaId": media.id,
                "mediaImage": media.images.standardResolution.url,
                "mediaCreated": media.created,
                "mediaType": media.type,
                "mediaFilter": media.filter,
                "mediaCaptionText": media.caption.text,
                "mediaTags": media.tags.joined(separator: ","),
                "mediaLocationName": media.location?.name ?? "",
                "mediaLocationLatitude": media.location?.latitude ?? "",
                "mediaLocationLongitude": media.location?.longitude ?? "",
                "mediaLikesCount": media.likesCount,
                "mediaCommentsCount": media.commentsCount
            ]
            updates["/medias/\(media.id)"] = row
        }
        ref.updateChildValues(updates)
    }
}
