//
//  TwitterClient.swift
//  twitter-client
//
//  Created by Martene Mendy on 7/30/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//


import BDBOAuth1Manager

let TWITTER_API_BASE_URL = NSURL(string: "https://api.twitter.com")
let TWITTER_API_CONSUMER_KEY = "hros60GYhKL3RnIQn6lPVQIVX"
let TWITTER_API_CONSUMER_SECRET = "Bb9NnOFEUsM5jiMICxDGp8oSJM21WkB7XCytyuFsbD8SEVLnQ1"
let TWITTER_API_AUTHORIZE_URL = "https://api.twitter.com/oauth/authorize"
let REQUEST_TOKEN_PATH = "oauth/request_token"

class TwitterClient: BDBOAuth1SessionManager {

   var loginSuccess: (() -> ())?
   var loginFailure: ((NSError) -> ())?

   class var sharedInstance: TwitterClient {
      struct Static {
         static let instance = TwitterClient(baseURL: TWITTER_API_BASE_URL, consumerKey: TWITTER_API_CONSUMER_KEY, consumerSecret: TWITTER_API_CONSUMER_SECRET)
      }
      return Static.instance
   }

   func loginUser(success: () -> (), failure: (NSError) -> ()){

      print("Log in request...")
      loginSuccess = success
      loginFailure = failure

      //1. get request token
      fetchRequestTokenWithPath(
         REQUEST_TOKEN_PATH,
         method: "GET",
         callbackURL: NSURL(string: "mm-twitter-client://oauth"),
         scope: nil,
         success: { (requestToken: BDBOAuth1Credential!) in
            print("...Got the request token")

            let authURL = NSURL(string: TWITTER_API_AUTHORIZE_URL + "?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)

      }) { (error: NSError!) in
         //print ("Error getting the request token")
         self.loginFailure?(error)
      }
   }

   func logoutUser(){
      print("Log out request...")
      User.currentUser = nil
      deauthorize()

      NSNotificationCenter.defaultCenter().postNotificationName(User.LOGOUT_NOTIFICATION, object: nil)
   }

   func handleOpenUrl(url: NSURL){
      fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) in
         print("...Got the access token...")

         self.currentUser({ (user: User) -> () in
            User.currentUser = user // setting the current user
            self.loginSuccess!()
            }, failure: { (error: NSError) -> () in
               self.loginFailure!(error)
         })


         /*// current user
          // can't use a return here, needs to be async. create a func that takes a closure func for callback
          self.currentUser({ (user: User) in
          print("...for user: \(user.name)")
          }, failure: { (error: NSError) in
          print("Error getting user: \(error.localizedDescription)")
          })

          // user's timeline
          // can't use a return here, needs to be async.
          self.homeTimeLine({ (tweets: [Tweet]) in
          print("...who has \(tweets.count) tweets")
          }, failure: { (error: NSError) in
          print("Error getting home timeline: \(error.localizedDescription)")
          })
          */

      }) { (error: NSError!) in
         print("Error getting access token: \(error.localizedDescription)")
         self.loginFailure!(error)
      }
   }


   func currentUser(success: (User) -> (), failure: (NSError) -> ()) {

      GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) in

         let userResponse = response as? NSDictionary
         let user = User(dictionary: userResponse!)
         success(user)

         }, failure: { (operation: NSURLSessionDataTask?, error: NSError) in
            print("Error getting user")
            failure(error)
      })
   }

   func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()){
      // 1.1/statuses/home_timeline.json
      GET("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) in

         let userTimeline = response as! [NSDictionary]
         let tweets = Tweet.tweetsFromArray(userTimeline)
         success(tweets)
         },failure: { (operation: NSURLSessionDataTask?, error: NSError) in
            failure(error)
      })
   }
}
