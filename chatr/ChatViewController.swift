//
//  ChatViewController.swift
//  chatr
//
//  Created by Zachary West Guo on 9/23/16.
//  Copyright © 2016 zechariah. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {
    
    @IBOutlet weak var messageField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendMessage(sender: AnyObject) {
        if(validMessage()){
            let message = PFObject(className:"Message_fbuJuly2016")
            message["text"] = messageField.text!
            let temp = message["text"]
            message.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("saved message: \(temp)")
                    // The object has been saved.
                } else {
                    // There was a problem, check error.description
                    print("Message save failed.")
                    print(error!.localizedDescription)
                }
            }
            
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Invalid entry for username or password.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func validMessage()->Bool{
        if let text = messageField.text where text.isEmpty
        {
            return false;
        }

        return true;
    }
    
    
    @IBAction func onTappedOutside(sender: AnyObject) {
        self.view.endEditing(true)
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
