//
//  SignUpVC.swift
//  ScholarsDen
//
//  Created by Faisal Khan on 12/23/15.
//  Copyright © 2015 Umbrella. All rights reserved.
//

import UIKit
import Parse

class SignUpVC: UIViewController {
    
    @IBOutlet var fullNameTextField: DesignableTextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func signUpButton(sender: AnyObject) {
        let username = emailTextField.text
        let password = passwordTextField.text
        let fullName = fullNameTextField.text
        
        //Mark: Empty Field - Alert Message
            if (username!.isEmpty || password!.isEmpty || fullName!.isEmpty) {
                let myAlert = UIAlertController(title: "Alert", message: "All fields must be filled in", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                myAlert.addAction(okAction)
                self.presentViewController(myAlert, animated: true, completion: nil)
                return
            }
    
            let myUser : PFUser = PFUser()
            myUser.username = username
            myUser.password = password
            myUser.email = username
        
            myUser.setObject(fullName!, forKey: "full_name")
            myUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                var userMessage = "Registration is successful, Thank you!"
        
                if (!success) {
                    userMessage = error!.localizedDescription
                }
        
                let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) {action in
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let nextVC : LoginVC = storyboard.instantiateViewControllerWithIdentifier("LoginStoryboard") as!
                        LoginVC
                    self.presentViewController(nextVC, animated: true, completion: nil)
                }
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert, animated: true, completion: nil)
            }
    }

}
