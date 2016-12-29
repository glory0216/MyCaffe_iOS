//
//  MarketingListTableViewController.swift
//  MyCaffe
//
//  Created by YoungKwangLee on 2016. 9. 24..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit
import Alamofire

class MarketingListTableViewController: UITableViewController {

    var marketingListArr = [[String:AnyObject]]()
    
    @IBOutlet var marketingTableView: UITableView!
    
    //let selectCafeMarketingListUrl = NSURL(string: "http://localhost:8080/mycaffe/app/select_cafe_marketing_list.jsp")
    let selectCafeMarketingListUrl = NSURL(string: "http://52.78.42.3:8080/mycaffe/app/select_cafe_marketing_list.jsp")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        clearTable()
        let searchParams = ["cafeIDX": NSUserDefaults.standardUserDefaults().integerForKey("cafeIDX")]
        
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
        return marketingListArr.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MarketingListCell")! as! MarketingListTableViewCell
        
        var tmpArr = marketingListArr[indexPath.row]
        
        cell.indexLabel.text = String(tmpArr["marketingIDX"]!)
        cell.menuNameLabel.text = tmpArr["menuName"] as? String
        cell.menuPriceLabel.text = tmpArr["menuPrice"] as? String
        cell.timeZoneLabel.text = String(tmpArr["marketingTimeZone"]!)
        
        return cell
    }
    
    
    // MARK: Custom Func
    func parseJSONData(searchParams: [String:AnyObject]) {
        Alamofire.request(.POST, selectCafeMarketingListUrl!, parameters: searchParams)
            .responseJSON { response in
                switch response.result {
                case .Success(let JSON):
                    let response = JSON as! NSArray
                    for item in response {
                        let obj = item as! NSDictionary
                        let tmpArr = [
                            "marketingIDX":obj.objectForKey("marketingIDX")!,
                            "menuName": obj.objectForKey("menuName")!,
                            "menuPrice": obj.objectForKey("menuPrice")!,
                            "marketingTimeZone": obj.objectForKey("marketingTimeZone")!
                        ]
                        print(tmpArr)
                        self.marketingListArr.append(tmpArr)
                    }
                    
                    self.marketingTableView.reloadData()
                    
                case .Failure(let error):
                    print("Request failed, \(error)")
                    
                }
        }
        
    }
    
    func clearTable() {
        
        self.marketingListArr.removeAll()
        self.marketingTableView.reloadData()
        
    }
    


    
}
