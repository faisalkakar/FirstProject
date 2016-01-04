//
//  WebsiteVC.swift
//  Friendbook
//
//  Created by Faisal Khan on 11/26/15.
//  Copyright © 2015 Umbrella. All rights reserved.
//

import UIKit
import Social

class WebsiteVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var shareImage: UIButton!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var webView: UIWebView!
    @IBAction func closeButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    var hasFinishedLoading = false
    var websiteURL: String!
    

    
    //MARK: Hide Status Bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        prefersStatusBarHidden()
        let targetURL = NSURL(string: websiteURL)
        let request = NSURLRequest(URL: targetURL!)
        webView.loadRequest(request)
        
        webView.delegate = self
        shareImage.layer.cornerRadius = shareImage.frame.size.height / 2
        shareImage.clipsToBounds = true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        hasFinishedLoading = false
        updateProgress()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        delay(1) { [weak self] in
            if let _self = self {
                _self.hasFinishedLoading = true
            }
        }
    }
    
    deinit {
        webView.stopLoading()
        webView.delegate = nil
    }
    
    func updateProgress() {
        if progressView.progress >= 1 {
            progressView.hidden = true
        } else {
            
            if hasFinishedLoading {
                progressView.progress += 0.002
            } else {
                if progressView.progress <= 0.3 {
                    progressView.progress += 0.004
                } else if progressView.progress <= 0.6 {
                    progressView.progress += 0.002
                } else if progressView.progress <= 0.9 {
                    progressView.progress += 0.001
                } else if progressView.progress <= 0.94 {
                    progressView.progress += 0.0001
                } else {
                    progressView.progress = 0.9401
                }
            }
            
            delay(0.008) { [weak self] in
                if let _self = self {
                    _self.updateProgress()
                }
            }
        }
    }

    @IBAction func shareButton(sender: AnyObject) {
        
        if (websiteURL != nil) {
            
            let targetURL = NSURL(string: websiteURL)
            let facebook = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
          
            facebook.addURL(targetURL)
            presentViewController(facebook, animated: true, completion: nil)
            
        }
        
    }

}

