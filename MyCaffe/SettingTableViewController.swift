//
//  SettingTableViewController.swift
//  MyCaffe
//
//  Created by YoungKwangLee on 2016. 8. 25..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var userNicknameLabel: UILabel!
    @IBOutlet weak var userPhoneLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        userIDLabel.text = NSUserDefaults.standardUserDefaults().stringForKey("userID")
        userNicknameLabel.text = NSUserDefaults.standardUserDefaults().stringForKey("userNickname")
        userPhoneLabel.text = NSUserDefaults.standardUserDefaults().stringForKey("userPhone")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    */
 
    /*
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    */
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: Actions
    @IBAction func touchBackBtn(sender: AnyObject) {
        let revealViewController = storyboard?.instantiateViewControllerWithIdentifier("RevealViewController") as! SWRevealViewController
        self.presentViewController(revealViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func touchLogoutBtn(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userID")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userIDX")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userNickname")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userPhone")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("userFavCafe")
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("selectedCafeInfo")
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserSelectCafe")
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let revealViewController = storyboard?.instantiateViewControllerWithIdentifier("RevealViewController") as! SWRevealViewController
        self.presentViewController(revealViewController, animated: true, completion: nil)
        
    }
    
}
