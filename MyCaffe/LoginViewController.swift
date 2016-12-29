//
//  ViewController.swift
//  MyCaffe
//
//  Created by YoungKwangLee on 2016. 8. 19..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: InitController {

    // MARK: properties
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    var userInfoArr = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        userIDLabel.textColor = UIColor.whiteColor()
        passwordLabel.textColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: actions
    @IBAction func touchLoginBtn(sender: AnyObject) {
        let userID = userIDTextField.text
        let userPassword = passwordTextField.text
        let loginParams = ["userID": userID! as String, "userPassword": userPassword! as String]
        
        // Check for empty fileds
        if(userID!.isEmpty || userPassword!.isEmpty) {
            
            displayAlertMessage("모든 항목을 다 채워주세요.")
            return
        }
        
        // Login
        loginWithParseJSONData(loginParams)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        userIDTextField.endEditing(true)
        passwordTextField.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    // MARK: Custom Func
    func loginWithParseJSONData(searchParams: [String:AnyObject]) {
        Alamofire.request(.POST, loginUrl!, parameters: searchParams)
            .responseJSON { response in
                switch response.result {
                case .Success(let JSON):
                    //print(JSON)
                    let response = JSON as! NSDictionary
                    
                    if (response.count > 1) {
                        let userIDX = response.objectForKey("userIDX")!
                        let userNickname = response.objectForKey("userNickname")!
                        let userPhone = response.objectForKey("userPhone")!
                        let userFavCafe = response.objectForKey("userFavCafe")!
                        
                        NSUserDefaults.standardUserDefaults().setValue(searchParams["userID"], forKeyPath: "userID")
                        NSUserDefaults.standardUserDefaults().setValue(userIDX, forKey: "userIDX")
                        NSUserDefaults.standardUserDefaults().setValue(userNickname, forKey: "userNickname")
                        NSUserDefaults.standardUserDefaults().setValue(userPhone, forKey: "userPhone")
                        NSUserDefaults.standardUserDefaults().setValue(userFavCafe, forKey: "userFavCafe")
                        
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        
                        print(NSUserDefaults.standardUserDefaults().integerForKey("userIDX"))
                        print(NSUserDefaults.standardUserDefaults().stringForKey("userNickname")!)
                        print(NSUserDefaults.standardUserDefaults().stringForKey("userPhone")!)
                        print(NSUserDefaults.standardUserDefaults().integerForKey("userFavCafe"))
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    
                    else {
                        let alertMessage = String(response.objectForKey("message")!)
                        self.displayAlertMessage(alertMessage)
                    }
                    
                case .Failure(let error):
                    print("Request failed, \(error)")
                    
                    let alertMessage = String(error)
                    self.displayAlertMessage(alertMessage)
                }
        }
    }
    

}