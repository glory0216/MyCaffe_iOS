//
//  InitController.swift
//  MyCaffe
//
//  Created by YoungKwangLee on 2016. 8. 20..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

enum UIModalTransitionStyle : Int {
    case CoverVertical = 0
    case FlipHorizontal
    case CrossDissolve
    case PartialCurl
}

class InitController: UIViewController {
    
    // MARK: Properties
    
    /*
    let registerUrl = NSURL(string: "http://localhost:8080/mycaffe/app/register.jsp")
    let loginUrl = NSURL(string: "http://localhost:8080/mycaffe/app/login.jsp")
    let currentCafeUrl = NSURL(string: "http://localhost:8080/mycaffe/app/home_current_cafe.jsp")
    let selectCafeUrl = NSURL(string: "http://localhost:8080/mycaffe/app/select_cafe.jsp")
    let cafeImagePathUrl = NSURL(string: "http://localhost:8080/mycaffe/fileDir/")
    let insertMenuOrderUrl = NSURL(string: "http://localhost:8080/mycaffe/app/insert_menu_order.jsp")
    */
    
    let registerUrl = NSURL(string: "http://52.78.42.3:8080/mycaffe/app/register.jsp")
    let loginUrl = NSURL(string: "http://52.78.42.3:8080/mycaffe/app/login.jsp")
    let currentCafeUrl = NSURL(string: "http://52.78.42.3:8080/mycaffe/app/home_current_cafe.jsp")
    let selectCafeUrl = NSURL(string: "http://52.78.42.3:8080/mycaffe/app/select_cafe.jsp")
    let cafeImagePathUrl = NSURL(string: "http://52.78.42.3:8080/mycaffe/fileDir/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.blackColor()
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    // MARK: Actions
    func displayAlertMessage(userMessage:String) {
        
        let okAlert = UIAlertController(title: "알림", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: nil)
        
        okAlert.addAction(okAction)
        self.presentViewController(okAlert, animated: true, completion: nil)
    }
    
}