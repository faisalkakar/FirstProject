//
//  ViewController.swift
//  Friendbook
//
//  Created by Faisal Khan on 11/25/15.
//  Copyright © 2015 Umbrella. All rights reserved.
//

import UIKit
import Parse

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var customTableView: UITableView!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var menuButton: UIButton!
    
    var scholarships = Scholarship()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
         self.edgesForExtendedLayout = UIRectEdge.None
        
        let userName: String? = NSUserDefaults.standardUserDefaults().stringForKey("user_name")
        
        if (userName != nil) {
            loginButton.hidden = true
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scholarships.scholarshipArray.count
    }
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomCell
         let scholars = scholarships.scholarshipArray[indexPath.row]
        cell.iconImage.image = scholars.image
        cell.headingLabel.text = scholars.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("DetailSegue", sender: "Cell")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            let secondVC = segue.destinationViewController as! DetailVC
          let indexPath : NSIndexPath = self.customTableView.indexPathForSelectedRow!
            let scholars = scholarships.scholarshipArray[indexPath.row]
            secondVC.scholar = scholars
        }
    }
    
    @IBAction func menuButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC : MenuVC = storyboard.instantiateViewControllerWithIdentifier("MenuStoryboard") as!
        MenuVC
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC : LoginVC = storyboard.instantiateViewControllerWithIdentifier("LoginStoryboard") as!
        LoginVC
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
}

