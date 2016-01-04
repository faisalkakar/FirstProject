//
//  DetailViewController.swift
//  Friendbook
//
//  Created by Faisal Khan on 12/6/15.
//  Copyright © 2015 Umbrella. All rights reserved.
//

import UIKit
import Parse
import Social

class DetailVC: UIViewController {

    @IBOutlet var signOutButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var segmentOutlet: UISegmentedControl!
    @IBOutlet var detailText: UITextView!
    
    var scholar : Scholarship.ScholarsDetails?
    var selectedSegmentIndex: Int?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let userName: String? = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
        if (userName == nil) {
            signOutButton.hidden = true
        } else {
            signOutButton.hidden = false
        }
        
        imageView.image = scholar?.image
        self.segmentOutlet.selectedSegmentIndex = 0
        selectedSegment()
        initText()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        imageView.layer.cornerRadius = 15.0
        imageView.clipsToBounds = true
        
        
       
    }
    
    func initText() {
        
        let style = NSMutableParagraphStyle()
        style.hyphenationFactor = 2.0
        style.lineHeightMultiple = 1.75
        style.paragraphSpacing = 16.0
        let textString = detailText.text
        detailText.font = UIFont(name: "Avenir Next", size: 16)
        detailText.attributedText = NSAttributedString(string: textString, attributes: [NSParagraphStyleAttributeName: style, NSLigatureAttributeName: 1])
        
        detailText.scrollEnabled = false
        detailText.scrollEnabled = true
        detailText.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: false)
    }

    
    @IBAction func backButn(sender: UIButton) {
       dismissViewControllerAnimated(true, completion: nil)
       
    }
    
    func selectedSegment() {
        
        if segmentOutlet.selectedSegmentIndex == 0 {
            detailText.text = scholar?.overview
        } else if segmentOutlet.selectedSegmentIndex == 1 {
            performSegueWithIdentifier("WebSegue", sender: self)
        } else {
            segmentOutlet.selectedSegmentIndex == 0
        }
    }
    
    @IBAction func segmentControl(sender: AnyObject) {
        selectedSegment()
    }
    
    func openUrl(url: String) {
        let targetUrl = NSURL(string: url)
        UIApplication.sharedApplication().openURL((targetUrl)!)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
        if segue.identifier == "WebSegue" {
            let webVC = segue.destinationViewController as! WebsiteVC
            let url = scholar!.url
            webVC.websiteURL = url
            prefersStatusBarHidden()
        }
    }
    
    @IBAction func signoutButton(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("user_name")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        PFUser.logOutInBackground()
        
        //Mark: Navigate to Login Page
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC : LoginVC = storyboard.instantiateViewControllerWithIdentifier("LoginStoryboard") as!
            LoginVC
            self.presentViewController(nextVC, animated: true, completion: nil)
        
    }
    
}
