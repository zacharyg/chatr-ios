//
//  ChatViewController.swift
//  chatr
//
//  Created by Zachary West Guo on 9/22/16.
//  Copyright © 2016 zechariah. All rights reserved.
//
import Parse
import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var messageBox: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        //tableView.estimatedRowHeight = 100
        //tableView.rowHeight = UITableViewAutomaticDimension
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createMsg(sender: AnyObject) {
        let text = messageBox.text
        
        let message = PFObject(className:"Message_fbuJuly2016")
        message["text"] = text
        message.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                print("successfully stored text")
                
            } else {
                // There was a problem, check error.description
            }
        }
        
        self.tableView.reloadData()


    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 20;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("chatCell", forIndexPath: indexPath) as! chatCell
        cell.textLabel?.text = messageBox.text!;
        
        return cell
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
