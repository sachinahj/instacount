//
//  ViewController.swift
//  instacount
//
//  Created by Atom - Sachin on 9/21/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import UIKit

struct INSTAGRAM_IDS {
    static let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
    static let INSTAGRAM_APIURl  = "https://api.instagram.com/v1/users/"
    static let INSTAGRAM_CLIENT_ID  = "REPLACE_YOUR_CLIENT_ID_HERE"
    static let INSTAGRAM_CLIENTSERCRET = "REPLACE_YOUR_CLIENT_SECRET_HERE"
    static let INSTAGRAM_REDIRECT_URI = "REPLACE_YOUR_REDIRECT_URI_HERE"
    static let INSTAGRAM_ACCESS_TOKEN =  "access_token"
    static let INSTAGRAM_SCOPE = "likes+comments+relationships"
}

class ViewController: UIViewController, UIWebViewDelegate {
    
    weak var loginWebView: UIWebView? = UIWebView()
    weak var loginIndicator: UIActivityIndicatorView? = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginWebView?.delegate = self
        unSignedRequest()
    }
    
    func unSignedRequest () {
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [INSTAGRAM_IDS.INSTAGRAM_AUTHURL,INSTAGRAM_IDS.INSTAGRAM_CLIENT_ID,INSTAGRAM_IDS.INSTAGRAM_REDIRECT_URI, INSTAGRAM_IDS.INSTAGRAM_SCOPE ])
        let urlRequest =  URLRequest.init(url: URL.init(string: authURL)!)
        loginWebView?.loadRequest(urlRequest)
    }
    
    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        
        if requestURLString.hasPrefix(INSTAGRAM_IDS.INSTAGRAM_REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            handleAuth(authToken: requestURLString.substring(from: range.upperBound))
            return false;
        }
        return true
    }
    
    func handleAuth(authToken: String)  {
        print("Instagram authentication token ==", authToken)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return checkRequestForCallbackURL(request: request)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loginIndicator?.isHidden = false
        loginIndicator?.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loginIndicator?.isHidden = true
        loginIndicator?.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        webViewDidFinishLoad(webView)
    }
    
}

