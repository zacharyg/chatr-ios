//
//  ChatViewController.swift
//  chatr
//
//  Created by Zachary West Guo on 9/23/16.
//  Copyright © 2016 zechariah. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messageField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var timer: NSTimer!
    var q: [PFObject] = [PFObject]();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
    }
    
    func loadMessages(){
        let query = PFQuery(className:"Message_fbuJuly2016")
        //query.whereKeyExists("user")
        query.includeKey("user")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                //query.orderByDescending("createdAt")
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) messages.")
                // Do something with the found objects
                if let objects = objects {
                    self.q = objects;
//                    for object in objects {
//                        let msg = object["text"] as! String
//                        print(msg)
//                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        if(validMessage()){
            let message = PFObject(className:"Message_fbuJuly2016")
            message["text"] = messageField.text!
            message["user"] = PFUser.currentUser()
            //print(PFUser.currentUser()?.username)
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return q.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell", forIndexPath: indexPath) as! ChatTableViewCell
        let singleObj = q[indexPath.row] 
        let msg = singleObj["text"] as! String
        if let usr = singleObj["user"] as? PFUser{
            cell.userLabel.text = usr.username
            //print(usr.username!)
        }
        else{
            cell.userLabel.text! = "anonymous"
        }
//        if usr != nil {
//            cell.userLabel.text = usr.username
//        }
//        else{
//            cell.userLabel.text = "anonymous"
//        }
        
        cell.messageLabel.text = msg
        
        
        return cell
        
    }
    
    func onTimer(){
        //print("refresh")
        loadMessages()
        self.tableView.reloadData()
        
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
