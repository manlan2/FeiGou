//
//  UserModel.swift
//  FeiGou
//
//  Created by  paralworld－02 on 2016/11/1.
//  Copyright © 2016年 like. All rights reserved.
//

struct UserModel: HandyJSON {
    var msg: String!
    var mobilePhone: String!
    var userId: Int!
}

import Foundation

class UserManager:  NSObject{
    
    class func isLogin() -> Bool {
        let manager = UserDefaults.standard
        if manager.object(forKey: "isLogin") == nil {
            return false
        } else {
            return manager.object(forKey: "isLogin") as! Bool
        }
    }
    
    class func login(name: String, psd: String, userId: Int) {
        let manager = UserDefaults.standard
        manager.set(name, forKey: "name")
        manager.set(psd, forKey: "psd")
        manager.set(userId, forKey: "userId")
        manager.set(true, forKey: "isLogin")
        manager.synchronize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "isLogin"), object: nil)
    }
    
    class func exit() {
        let manager = UserDefaults.standard
        manager.set(false, forKey: "isLogin")
        manager.synchronize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "exit"), object: nil)
    }
    
    class func getUserId() -> Int64 {
        let manager = UserDefaults.standard
        return manager.object(forKey: "userId") as! Int64
    }
    
    class func getUserName() -> String {
        let manager = UserDefaults.standard
        return manager.object(forKey: "name") as! String
    }
    
}
