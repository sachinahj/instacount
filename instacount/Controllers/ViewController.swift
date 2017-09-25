//
//  CountController.swift
//  instacount
//
//  Created by Atom - Sachin on 9/21/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    let instagramAPI = InstagramAPI()
    let fbManager = FBManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CountController")
//        getDataForFB()
        
//        instagramAPI.getUser(userId: nil) { result in
//            guard case let Result.Success(user) = result else { return }
//            print("---------getUser---------")
//            dump(user)
//        }
        
        instagramAPI.getFollows() { result in
            guard case let Result.Success(users) = result else { return }
            print("---------getFollows---------")
            dump(users)
        }
        
        instagramAPI.getFollowedBy() { result in
            guard case let Result.Success(users) = result else { return }
            print("---------getFollowedBy---------")
            dump(users)
        }
        
        instagramAPI.getRequestedBy() { result in
            guard case let Result.Success(users) = result else { return }
            print("---------getRequestedBy---------")
            dump(users)
        }
        
//        instagramAPI.getRecentMedia(userId: nil) { medias in
//            print("---------getRecentMedia---------")
//            dump(medias)
//        }
        
//        instagramAPI.getMedia(mediaId: "1177552285539421285_48645434") { response in
//            print("---------getMedia---------")
//            dump(response.data)
//        }
        
//        instagramAPI.getLikes(mediaId: "1177552285539421285_48645434") { response in
//            print("---------getLikes---------")
//            dump(response.data)
//        }
        
//        instagramAPI.getComments(mediaId: "1177552285539421285_48645434") { response in
//            print("---------getComments---------")
//            dump(response.data)
//        }
    }
    
//    func getDataForFB() {
//
//        self.instagramAPI.getUser(userId: nil) { user in
//            print("---------getUser---------")
//            dump(user)
//
//            self.instagramAPI.getRecentMedia(userId: nil) { medias in
//                print("---------getRecentMedia---------")
//                dump(medias)
//
//                self.fbManager.uploadData(user: user, medias: medias)
//            }
//        }
//    }
    
}
