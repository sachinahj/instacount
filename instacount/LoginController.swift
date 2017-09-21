//
//  ViewController.swift
//  instacount
//
//  Created by Atom - Sachin on 9/21/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UIWebViewDelegate {
    
    var accessToken: String?
    @IBOutlet weak var loginWebView: UIWebView!
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LoginController")
        loginWebView.delegate = self
        unSignedRequest()
    }
    
    func unSignedRequest () {
        let authURL = String(
            format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@",
            arguments: [INSTAGRAM_CREDS.AUTHURL, INSTAGRAM_CREDS.CLIENT_ID, INSTAGRAM_CREDS.REDIRECT_URI, INSTAGRAM_CREDS.SCOPE]
        )
        let urlRequest =  URLRequest.init(url: URL.init(string: authURL)!)
        loginWebView.loadRequest(urlRequest)
    }
    
    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        
        if requestURLString.hasPrefix(INSTAGRAM_CREDS.REDIRECT_URI) {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            handleAuth(accessToken: requestURLString.substring(from: range.upperBound))
            return false;
        }
        return true
    }
    
    func handleAuth(accessToken token: String)  {
        print("Instagram authentication token ==", token)
        accessToken = token
        let alertController = UIAlertController(title: "Got the token!", message: token, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            UIAlertAction in self.performSegue(withIdentifier: "goToCount", sender: self)
        }))
        self.present(alertController, animated: true, completion: nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goToCount" {
            let destinationVC = segue.destination as! CountController
            destinationVC.accessToken = accessToken
        }
    }
    
}

