//
//  LoginVC.swift
//  Friendbook
//
//  Created by Faisal Khan on 12/10/15.
//  Copyright © 2015 Umbrella. All rights reserved.
//

import UIKit
import Parse
import ParseFacebookUtilsV4


class LoginVC: UIViewController {

    @IBOutlet var emailTextField: DesignableTextField!
    @IBOutlet var passwordTextField: DesignableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func signUpButton(sender: AnyObject) {
        performSegueWithIdentifier("SignupSegue", sender: self)
    }

    
    @IBAction func loginButton(sender: AnyObject) {
            
            let userEmail = emailTextField.text
            let userPassword = passwordTextField.text
            
            if(userEmail!.isEmpty || userPassword!.isEmpty)
            {
                return
            }
            
            PFUser.logInWithUsernameInBackground(userEmail!, password: userPassword!) { (user:PFUser?, error:NSError?) -> Void in
                
                
                var userMessage = "Welcome!"
                
                if(user != nil) {
                    
                    // Remember the sign in state
                    let userName:String? = user?.username
                    
                    NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    // Navigate to Protected page
                    
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let nextVC : MainVC = storyboard.instantiateViewControllerWithIdentifier("mainStoryboard") as! MainVC
                        self.presentViewController(nextVC, animated: true, completion: nil)

                
                } else {
                    
                    userMessage = error!.localizedDescription
                    let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                    
                    myAlert.addAction(okAction)
                    
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                
            }
            
        }
    
    @IBAction func facebookButton(sender: AnyObject) {
        // Create Permissions array
        let permissions = ["public_profile","email","user_friends"]
        
        // Login to Facebook with Permissions
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions, block: { (user:PFUser?, error:NSError?) -> Void in
        
            // If error, display message
            if(error != nil)
            {
                dispatch_async(dispatch_get_main_queue()) {
                    
                    
                    let userMessage = error!.localizedDescription
                    let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                    
                    myAlert.addAction(okAction)
                    
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    return
                } // end of async
            }
            
            
            // Load facebook user details like user First name, Last name and email address
            
            self.loadFacebookUserDetails()
            
            })
        
        }
    
    func loadFacebookUserDetails(){
        // Show activity indicator
//        let spiningActivity = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//        spiningActivity.labelText = "Loading"
//        spiningActivity.detailsLabelText = "Please wait"
        
        
        // Define fields we would like to read from Facebook User object
        let requestParameters = ["fields": "id, email, first_name, last_name, name"]
        
        // Send Facebook Graph API Request for /me
        let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
        userDetails.startWithCompletionHandler({
            (connection, result, error: NSError!) -> Void in
            
            
            
            if error != nil {
                
                // Display error message
//                spiningActivity.hide(true)
                
                let userMessage = error!.localizedDescription
                let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                
                myAlert.addAction(okAction)
                
                self.presentViewController(myAlert, animated: true, completion: nil)
                
                
                PFUser.logOut()
                
                return
            }
            
            
            // Extract user fields
            let userId:String = result["id"] as! String
            let userEmail:String? = result["email"] as? String
            let userFirstName:String?  = result["first_name"] as? String
            let userLastName:String? = result["last_name"] as? String
            
            
            
            // Get Facebook profile picture
            let userProfile = "https://graph.facebook.com/" + userId + "/picture?type=large"
            
            let profilePictureUrl = NSURL(string: userProfile)
            
            let profilePictureData = NSData(contentsOfURL: profilePictureUrl!)
            
            
            // Prepare PFUser object
            if(profilePictureData != nil)
            {
                let profileFileObject = PFFile(data:profilePictureData!)
                PFUser.currentUser()?.setObject(profileFileObject!, forKey: "profile_picture")
            }
            
            PFUser.currentUser()?.setObject(userFirstName!, forKey: "first_name")
            PFUser.currentUser()?.setObject(userLastName!, forKey: "last_name")
            
            
            
            if let userEmail = userEmail
            {
                PFUser.currentUser()?.email = userEmail
                PFUser.currentUser()?.username = userEmail
            }
            
            
            
            PFUser.currentUser()?.saveInBackgroundWithBlock({ (success, error) -> Void in
                
//                spiningActivity.hide(true)
                
                if(error != nil)
                {
                    let userMessage = error!.localizedDescription
                    let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                    
                    myAlert.addAction(okAction)
                    
                    self.presentViewController(myAlert, animated: true, completion: nil)
                    
                    
                    PFUser.logOut()
                    return
                    
                    
                }
                
                
                if(success)
                {
                    if !userId.isEmpty
                    {
                        NSUserDefaults.standardUserDefaults().setObject(userId, forKey: "user_name")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let nexVC :MainVC = storyboard.instantiateViewControllerWithIdentifier("mainStoryboard") as! MainVC
                        self.presentViewController(nexVC, animated: true, completion: nil)
                        
                    }
                    
                }
                
            })
            
            
        })

    }
    
}
