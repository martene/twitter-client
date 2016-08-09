//
//  UserProfile.swift
//  twitter-client
//
//  Created by Martene Mendy on 8/8/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit

class UserProfile: NSObject {
   var name: NSString!
   var screenName: NSString!
   var profileUrl: NSURL!
   var profileUrlBanner: NSURL!
   var tagLine: NSString!
   var tweetsCount: Int!
   var followers: Int!
   var following: Int!

   // store initial dictionary for persistence
   var dictionary: NSDictionary!

   init(dictionary: NSDictionary){
      self.dictionary = dictionary

      name = dictionary["name"] as? String
      screenName = dictionary["screen_name"] as? String
      tagLine = dictionary["description"] as? String

      //tweets: statuses_count
      // followers_count
      // following: friends_count

      tweetsCount = dictionary["statuses_count"] as? Int
      followers = dictionary["followers_count"] as? Int
      following = dictionary["friends_count"] as? Int

      let urlBanner = dictionary["profile_banner_url"] as? String
      profileUrlBanner  = NSURL(string: urlBanner!)

      let url = dictionary["profile_image_url_https"] as? String
      profileUrl  = NSURL(string: url!)
   }
}
