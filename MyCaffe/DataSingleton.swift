//
//  DataSingleton.swift
//  MyCaffe
//
//  Created by YoungKwangLee on 2016. 8. 24..
//  Copyright © 2016년 YoungKwangLee. All rights reserved.
//

import Foundation

class DataSingleton {
    
    class var sharedInstance: DataSingleton {
        struct Static {
            static var instance: DataSingleton?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = DataSingleton()
        }
        
        return Static.instance!
    }
    
    var isCafeSelectedPop: Bool!
    var cafeIDX: Int!
    var cafeName: String!
    
}