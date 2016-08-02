//
//  TwitterUser.swift
//  twitter-client
//
//  Created by Martene Mendy on 7/30/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit

class User: NSObject {
   var name: NSString!
   var screenName: NSString!
   var profileUrl: NSURL!
   var tagLine: NSString!
   // store initial dictionary for persistence
   var dictionary: NSDictionary!

   // instance member
   static let USER_KEY = "USER_KEY"
   static let LOGOUT_NOTIFICATION = "LOGOUT_NOTIFICATION"

   static var _currentUser: User?


   init(dictionary: NSDictionary){
      self.dictionary = dictionary
      name = dictionary["name"] as? String
      screenName = dictionary["screen_name"] as? String
      tagLine = dictionary["description"] as? String

      let url = dictionary["profile_image_url_https"] as? String
      profileUrl  = NSURL(string: url!)
   }


   // classs property available for the class itself. Computer property
   class var currentUser: User? {
      get {
         if _currentUser == nil {
            let defaults = NSUserDefaults.standardUserDefaults()
            let userData = defaults.objectForKey(USER_KEY) as? NSData
            if let userData = userData {
               let userDictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
               _currentUser = User(dictionary: userDictionary)
            }
         }
         return _currentUser
      }

      set(user) {
         _currentUser = user
         let defaults = NSUserDefaults.standardUserDefaults()

         if let user = user {
            let userData = try! NSJSONSerialization.dataWithJSONObject(user.dictionary, options: [])
            defaults.setObject(userData, forKey: USER_KEY)
         }
         else {
            defaults.setObject(nil, forKey: USER_KEY)
         }
         defaults.synchronize()
      }
   }
}
