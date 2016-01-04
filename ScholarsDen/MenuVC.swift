//
//  MenuVC.swift
//  Friendbook
//
//  Created by Faisal Khan on 12/9/15.
//  Copyright © 2015 Umbrella. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    @IBOutlet var menuButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        let userName: String? = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
        
        if (userName != nil) {
           menuButton.enabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func popularButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    @IBAction func closeButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        performSegueWithIdentifier("LoginSegue", sender: self)
    }
    
}
