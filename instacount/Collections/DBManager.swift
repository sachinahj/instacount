//
//  Firebase.swift
//  instacount
//
//  Created by Atom - Sachin on 9/23/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol DBManagerDelegate: class {
//    func dbManager(friendFound: Friend)
}

extension  DBManagerDelegate {
//    func dbManager(friendFound: Friend) {}
}

class DBManager {
    var ref: DatabaseReference!
    weak var delegate: DBManagerDelegate?
}
