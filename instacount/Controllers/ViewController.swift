//
//  ViewController.swift
//  instacount
//
//  Created by Atom - Sachin on 9/21/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    let instagramAPI: InstagramAPI = InstagramAPI()
    let fbManager: FBManager = FBManager()
    @IBOutlet weak var likesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController: viewDidLoad")
        self.getIG(userId: nil)
        self.getNetwork()
    }
    
    func getIG(userId: String?) {
        instagramAPI.getUser(userId: userId) { [weak self] result in
            guard case let Result.Success(user) = result else { return }
//            print("---------getUser \(userId ?? "self")---------")
//            dump(user)

            self?.instagramAPI.getRecentMedia(userId: userId) { [weak self] result in
                guard case let Result.Success(medias) = result else { return }
//                print("---------getRecentMedia \(userId ?? "self")---------")
//                print(`medias.count)
//                dump(medias)
                self?.fbManager.uploadData(user: user, medias: medias)
            }
        }
    }
    
    func getNetwork() {
        var follows: [InstagramSimpleUser] = []
        var followedBy: [InstagramSimpleUser] = []
        let group = DispatchGroup()
        
        group.enter()
        instagramAPI.getFollows() { result in
            guard case let Result.Success(users) = result else { return group.leave() }
            follows = users
            group.leave()
        }
        
        group.enter()
        instagramAPI.getFollowedBy() { result in
            guard case let Result.Success(users) = result else { return group.leave() }
            followedBy = users
            group.leave()
        }
        
        group.notify(queue: .main) {
            let network: [InstagramSimpleUser] = follows + followedBy
            let networkIds: [String] = network.map {user in user.id}
            let uniqueNetworkIds: [String] = Array(Set(networkIds))
//            dump(uniqueNetworkIds)
            uniqueNetworkIds.forEach { [weak self] id in
                self?.getIG(userId: id)
            }
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        instagramAPI.logout()
        if let destination = self.storyboard?.instantiateViewController(withIdentifier: "LoginSB") as? LoginController {
            navigationController?.setViewControllers([destination], animated: true)
        }
    }
    
    deinit {
        print("ViewController: deinit")
    }
}
