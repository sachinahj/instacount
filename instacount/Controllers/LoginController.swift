//
//  ViewController.swift
//  instacount
//
//  Created by Atom - Sachin on 9/21/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var loginWebView: UIWebView!
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginController")
        loginWebView.delegate = self
//        logout()
        unSignedRequest()
    }
    
    func logout() {
        let cookieStorage = HTTPCookieStorage.shared
        if let cookies = cookieStorage.cookies {
            for cookie in cookies where cookie.domain.range(of: "instagram.com") != nil {
                print("\(cookie)")
                cookieStorage.deleteCookie(cookie)
            }
        }
    }
    
    func unSignedRequest () {
        let authURL = String(
            format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@",
            arguments: [INSTAGRAM.AUTHURL, INSTAGRAM.CLIENT_ID, INSTAGRAM.REDIRECT_URI, INSTAGRAM.SCOPE]
        )
        let urlRequest =  URLRequest.init(url: URL.init(string: authURL)!)
        loginWebView.loadRequest(urlRequest)
    }
    
    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.hasPrefix(INSTAGRAM.REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
//            handleAuth(accessToken: requestURLString.substring(from: range.upperBound))
            let token = String(requestURLString[range.upperBound...])
            handleAuth(accessToken: token)
            return false
        }
        return true
    }
    
    func handleAuth(accessToken: String)  {
        print("Instagram authentication token ==", accessToken)
        let instagramAPI = InstagramAPI()
        instagramAPI.setAccessToken(token: accessToken)
        self.performSegue(withIdentifier: "goToCount", sender: self)
    }
    
    // Web View Delegate
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return checkRequestForCallbackURL(request: request)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        loginIndicator.isHidden = false
        loginIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loginIndicator.isHidden = true
        loginIndicator.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        webViewDidFinishLoad(webView)
    }
    
}

