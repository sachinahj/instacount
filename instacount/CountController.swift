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
    
    var accessToken: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CountController")
        print("CountController: accessToken", accessToken)
        getRecentMedia()
    }
    
    func getRecentMedia() {
        let url = String(
            format: "%@users/self/media/recent?access_token=%@",
            arguments: [INSTAGRAM.BASEURL, accessToken]
        )
        
        Alamofire.request(url).responseJSON {
            response in
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            } else {
                print("CountController: getRecentMedia | error")
            }
        }
    }

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
