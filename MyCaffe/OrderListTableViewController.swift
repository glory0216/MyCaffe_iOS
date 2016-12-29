//
//  OrderListTableViewController.swift
//  MyCaffe
//
//  Created by YoungKwangLee on 2016. 8. 26..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit
import Alamofire

class OrderListTableViewController: UITableViewController {

    var orderListArr = [[String:AnyObject]]()
    
    @IBOutlet var orderTableView: UITableView!
    
    //let selectMyOrderListUrl = NSURL(string: "http://localhost:8080/mycaffe/app/select_my_order_list.jsp")
    let selectMyOrderListUrl = NSURL(string: "http://52.78.42.3:8080/mycaffe/app/select_my_order_list.jsp")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        clearTable()
        let searchParams = ["userIDX": NSUserDefaults.standardUserDefaults().integerForKey("userIDX")]
        
        // Data Connect
        parseJSONData(searchParams)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderListArr.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OrderListCell")! as! OrderListTableViewCell
        var tmpArr = orderListArr[indexPath.row]
        
        cell.cafeNameLabel.text = tmpArr["cafeName"] as? String
        cell.menuNameLabel.text = tmpArr["menuName"] as? String
        cell.orderTimeLabel.text = tmpArr["orderReceivedTime"] as? String
        

        return cell
    }

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
    @IBAction func touchBackBtn(sender: AnyObject) {
        let revealViewController = storyboard?.instantiateViewControllerWithIdentifier("RevealViewController") as! SWRevealViewController
        self.presentViewController(revealViewController, animated: true, completion: nil)
    }

    // MARK: Custom Func
    func parseJSONData(searchParams: [String:AnyObject]) {
        Alamofire.request(.POST, selectMyOrderListUrl!, parameters: searchParams)
            .responseJSON { response in
                switch response.result {
                case .Success(let JSON):
                    let response = JSON as! NSArray
                    for item in response {
                        let obj = item as! NSDictionary
                        let tmpArr = [
                            "orderPayType":obj.objectForKey("orderPayType")!,
                            "cafeName": obj.objectForKey("cafeName")!,
                            "orderReceivedTime": obj.objectForKey("orderReceivedTime")!,
                            "orderTotalPrice": obj.objectForKey("orderTotalPrice")!,
                            "orderFlag": obj.objectForKey("orderFlag")!,
                            "menuName": obj.objectForKey("menuName")!
                        ]
                        print(tmpArr)
                        self.orderListArr.append(tmpArr)
                    }
                    
                    self.orderTableView.reloadData()
                    
                case .Failure(let error):
                    print("Request failed, \(error)")
                    
                }
        }
        
    }
    
    func clearTable() {
        
        self.orderListArr.removeAll()
        self.orderTableView.reloadData()
        
    }
    
}
