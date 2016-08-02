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
   var favoriteCount: Int!
   var createdAt: NSDate!
   var retweeted: Int!
   var id: NSString!
   var favorited: Int!

   init(dictionary: NSDictionary){
      //print("tweet: \(dictionary["id_str"])" )

      let userDictionary = dictionary["user"] as? NSDictionary
      user = User(dictionary: userDictionary!)
      id = dictionary["id_str"] as? String
      text = dictionary["text"] as? String
      retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
      favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0
      retweeted = (dictionary["retweeted"] as? Int) ?? 0

      let createdAtString = dictionary["created_at"] as? String
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
      createdAt = dateFormatter.dateFromString(createdAtString!)

      favorited = (dictionary["favorited"] as? Int) ?? 0
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
