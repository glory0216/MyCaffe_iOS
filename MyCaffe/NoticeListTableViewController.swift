//
//  NoticeListTableViewController.swift
//  MyCaffe
//
//  Created by YoungKwangLee on 2016. 9. 24..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit
import Alamofire

class NoticeListTableViewController: UITableViewController {

    var noticeListArr = [[String:AnyObject]]()
    var noticeDetailInfoArr = [String:AnyObject]()
    
    @IBOutlet var noticeTableView: UITableView!
    
    //let selectCafeNoticeListUrl = NSURL(string: "http://localhost:8080/mycaffe/app/select_cafe_notice_list.jsp")
    let selectCafeNoticeListUrl = NSURL(string: "http://52.78.42.3:8080/mycaffe/app/select_cafe_notice_list.jsp")
    
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
        return noticeListArr.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoticeListCell")! as! NoticeListTableViewCell
        
        var tmpArr = noticeListArr[indexPath.row]
        
        cell.indexLabel.text = String(tmpArr["noticeParentIDX"]!)
        cell.titleLabel.text = tmpArr["noticeTitle"] as? String
        cell.dateLabel.text = tmpArr["noticeCreDtm"] as? String
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        noticeDetailInfoArr = noticeListArr[indexPath.row]
        
        performSegueWithIdentifier("goNoticeDetail", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "goNoticeDetail") {
            let detailViewController = segue.destinationViewController as! NoticeDetailViewController
            detailViewController.noticeDetailInfoArr = noticeDetailInfoArr
        }
        
    }
    
    // MARK: Custom Func
    func parseJSONData(searchParams: [String:AnyObject]) {
        Alamofire.request(.POST, selectCafeNoticeListUrl!, parameters: searchParams)
            .responseJSON { response in
                switch response.result {
                case .Success(let JSON):
                    let response = JSON as! NSArray
                    for item in response {
                        let obj = item as! NSDictionary
                        let tmpArr = [
                            "noticeParentIDX":obj.objectForKey("noticeParentIDX")!,
                            "noticeTitle": obj.objectForKey("noticeTitle")!,
                            "noticeCreDtm": obj.objectForKey("noticeCreDtm")!,
                            "noticeContents": obj.objectForKey("noticeContents")!,
                            "noticeCnt": obj.objectForKey("noticeCnt")!
                        ]
                        print(tmpArr)
                        self.noticeListArr.append(tmpArr)
                    }
                    
                    self.noticeTableView.reloadData()
                    
                case .Failure(let error):
                    print("Request failed, \(error)")
                    
                }
        }
        
    }
    
    func clearTable() {
        
        self.noticeListArr.removeAll()
        self.noticeTableView.reloadData()
        
    }
    
}
