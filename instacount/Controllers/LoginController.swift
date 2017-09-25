//
//  LoginController.swift
//  instacount
//
//  Created by Atom - Sachin on 9/21/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import UIKit
import WebKit

class LoginController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var loginWebView: WKWebView!
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginController: viewDidLoad")
        loginWebView.navigationDelegate = self
        loginIndicator.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
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
        loginWebView.load(urlRequest)
    }
    
    func handleAuth(accessToken: String)  {
        print("Instagram authentication token ==", accessToken)
        let instagramAPI = InstagramAPI()
        instagramAPI.setAccessToken(token: accessToken)
        performSegue(withIdentifier: "goToCount", sender: self)
    }
    
    // WebKit View Delegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let requestURLString = (webView.url?.absoluteString)! as String
        if requestURLString.hasPrefix(INSTAGRAM.REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            let token = String(requestURLString[range.upperBound...])
            handleAuth(accessToken: token)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loginIndicator.isHidden = false
        loginIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loginIndicator.isHidden = true
        loginIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loginIndicator.isHidden = true
        loginIndicator.stopAnimating()
    }
    
    deinit {
        print("LoginController: deinit")
    }
    
}

