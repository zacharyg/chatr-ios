//
//  LoginViewController.swift
//  chatr
//
//  Created by Zachary West Guo on 9/22/16.
//  Copyright © 2016 zechariah. All rights reserved.
//
import Parse
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passField: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signUp(sender: AnyObject) {
        let email = emailField.text
        let pass = passField.text
        
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = email
        newUser.password = pass
        
        // call sign up function on the object
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
    }
    
    @IBAction func logIn(sender: AnyObject) {
        
        let username = emailField.text ?? ""
        let pass = passField.text ?? ""
        
        PFUser.logInWithUsernameInBackground(username, password: pass) { (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                print("User login failed.")
                print(error.localizedDescription)
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                //modal push to chat view
                let cvc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ChatVC")
                self.showViewController(cvc as! ChatViewController, sender: cvc)
                
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
