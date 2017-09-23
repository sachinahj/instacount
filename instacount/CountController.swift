//
//  CountController.swift
//  instacount
//
//  Created by Atom - Sachin on 9/21/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import UIKit
import Alamofire

class CountController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CountController")
        
//        InstagramAPI.getUser(userId: nil) { response in
//            print("---------getUser---------")
//            dump(response.data)
//        }
        
//        InstagramAPI.getFollows() { response in
//            print("---------getFollows---------")
//            dump(response.data)
//        }
        
//        InstagramAPI.getFollowedBy() { response in
//            print("---------getFollowedBy---------")
//            dump(response.data)
//        }
        
//        InstagramAPI.getRequestedBy() { response in
//            print("---------getRequestedBy---------")
//            dump(response.data)
//        }
        
//        InstagramAPI.getRecentMedia(userId: nil) { response in
//            print("---------getRecentMedia---------")
//            dump(response.data)
//        }
        
        InstagramAPI.getMedia(mediaId: "1609111023317807290_48645434") { response in
            print("---------getMedia---------")
            dump(response.data)
        }
        
//        InstagramAPI.getLikes(mediaId: "1177552285539421285_48645434") { response in
//            print("---------getLikes---------")
//            dump(response.data)
//        }
        
//        InstagramAPI.getComments(mediaId: "1177552285539421285_48645434") { response in
//            print("---------getComments---------")
//            dump(response.data)
//        }
    }
}
