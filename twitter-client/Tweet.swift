//
//  Tweet.swift
//  twitter-client
//
//  Created by Martene Mendy on 7/30/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit

class Tweet: NSObject {

   var user: User?
   var text: NSString!
   var retweetCount: Int!
   var favoritesCount: Int!
   var createdAt: NSDate!
   var retweeted: Int!

   init(dictionary: NSDictionary){

      let userDictionary = dictionary["user"] as? NSDictionary
      user = User(dictionary: userDictionary!)
      text = dictionary["text"] as? String
      retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
      favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
      retweeted = (dictionary["retweeted"] as? Int) ?? 0

      let createdAtString = dictionary["created_at"] as? String
      let dateFormatter = NSDateFormatter()
 //     dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
      dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
 //     dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
      createdAt = dateFormatter.dateFromString(createdAtString!)

   }

   // this is a class function (static)
   class func tweetsFromArray(dictionaries: [NSDictionary]) -> [Tweet] {
      var tweets = [Tweet]()

      for dictionary in dictionaries{

         //print("tweet: \(dictionary)")
         let tweet = Tweet(dictionary: dictionary)
         tweets.append(tweet)
      }
      return tweets
   }
}
