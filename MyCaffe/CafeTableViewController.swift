//
//  CafeTableViewController.swift
//  MyCaffe
//
//  Created by YoungKwangLee on 2016. 8. 23..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit
import Alamofire

class CafeTableViewController: InitController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cafeTableView: UITableView!
    
    var cafeInfoArr = [[String:AnyObject]]()
    let dataSingleton = DataSingleton.sharedInstance
    
    //let logoImagePathUrl = "http://localhost:8080/mycaffe/fileDir/"
    let logoImagePathUrl = "http://52.78.42.3:8080/mycaffe/fileDir/"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // MARK: TableView
        cafeTableView.delegate = self
        cafeTableView.dataSource = self
        
        let searchParams = ["tempLocation": ""]
        
        // Data Connect
        parseJSONData(searchParams)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cafeInfoArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell")! as! CafeTableViewCell
        var tmpArr = cafeInfoArr[indexPath.row]
        let imageFileName = tmpArr["cafeLogo"] as? String
        
        if (imageFileName == "1") {
            
            cell.cafeLogoImageView.image = nil
            cell.cafeNameLabel.text = tmpArr["cafeName"] as? String
            cell.cafeLocationLabel.text = tmpArr["cafeLocation"] as? String
            
        }
        
        else {
            
            let fullUrl = NSURL(string: logoImagePathUrl + imageFileName!)
            if let data = NSData(contentsOfURL: fullUrl!) {
                cell.cafeLogoImageView.image = UIImage(data: data)
            }
            
            cell.cafeNameLabel.text = tmpArr["cafeName"] as? String
            cell.cafeLocationLabel.text = tmpArr["cafeLocation"] as? String
        }
        
        
        
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //performSegueWithIdentifier("WebSegue", sender: indexPath)
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let tmpArr = cafeInfoArr[indexPath.row]
        
        NSUserDefaults.standardUserDefaults().setObject(tmpArr["cafeIDX"], forKey: "cafeIDX")
        NSUserDefaults.standardUserDefaults().setObject(tmpArr, forKey: "selectedCafeInfo")
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserSelectCafe")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        //performSegueWithIdentifier("unwindToHome", sender: nil)
        
        let revealViewController = storyboard?.instantiateViewControllerWithIdentifier("RevealViewController") as! SWRevealViewController
        self.presentViewController(revealViewController, animated: true, completion: nil)
        
    }

    // MARK: Actions
    @IBAction func touchTotalSelectBtn(sender: AnyObject) {
        clearTable()
        let searchParams = ["tempLocation": ""]
        parseJSONData(searchParams)
    }
    
    @IBAction func touchSeoulSelectBtn(sender: AnyObject) {
        clearTable()
        let searchParams = ["tempLocation": "서울"]
        parseJSONData(searchParams)
    }
    
    @IBAction func touchGyunggiSelectBtn(sender: AnyObject) {
        clearTable()
        let searchParams = ["tempLocation": "경기"]
        parseJSONData(searchParams)
    }
    
    // MARK: Custom Func
    func parseJSONData(searchParams: [String:AnyObject]) {
        Alamofire.request(.POST, selectCafeUrl!, parameters: searchParams)
            .responseJSON { response in
                switch response.result {
                case .Success(let JSON):
                    let response = JSON as! NSArray
                    for item in response {
                        let obj = item as! NSDictionary
                        let tmpArr = [
                            "cafeIDX":obj.objectForKey("cafeIDX")!,
                            "cafeName": obj.objectForKey("cafeName")!,
                            "cafeTel": obj.objectForKey("cafeTel")!,
                            "cafeLocation": obj.objectForKey("cafeLocation")!,
                            "cafeComment": obj.objectForKey("cafeComment")!,
                            "cafeLogo": obj.objectForKey("cafeLogo")!
                        ]
                        print(tmpArr)
                        self.cafeInfoArr.append(tmpArr)
                    }
                    
                    self.cafeTableView.reloadData()
                    
                case .Failure(let error):
                    print("Request failed, \(error)")
                    
                    let alertMessage = String(error)
                    self.displayAlertMessage(alertMessage)
                }
        }
        
    }
    
    func clearTable() {
        
        self.cafeInfoArr.removeAll()
        self.cafeTableView.reloadData()
        
    }
    
}
