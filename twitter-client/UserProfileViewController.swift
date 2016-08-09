//
//  UserProfileViewController.swift
//  twitter-client
//
//  Created by Martene Mendy on 8/7/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   @IBOutlet weak var userTweetsTableView: UITableView!

   @IBOutlet weak var profileImageView: UIImageView!
   @IBOutlet weak var tweetCount: UILabel!
   @IBOutlet weak var followingCount: UILabel!
   @IBOutlet weak var followersCount: UILabel!
   @IBOutlet weak var usernameLabel: UILabel!
   @IBOutlet weak var screenNameLabel: UILabel!
   @IBOutlet weak var bannerImageView: UIImageView!

   @IBOutlet weak var tweetsView: UIView!
   @IBOutlet weak var followingView: UIView!
   @IBOutlet weak var followersView: UIView!

   var profileScreenName: NSString = (User.currentUser?.screenName)!

   var userTweets = [Tweet]()
   var userProfile: UserProfile! {
      didSet {
         bannerImageView.setImageWithURL(userProfile.profileUrlBanner)

         customizeImage(profileImageView, url: userProfile.profileUrl)         //profileImageView.setImageWithURL(userProfile.profileUrl)
         usernameLabel.text = userProfile.name as String
         screenNameLabel.text = "@" + String(userProfile.screenName)

         tweetCount.text = String((userProfile.tweetsCount) ?? 0)
         followersCount.text = String((userProfile.followers) ?? 0)
         followingCount.text = String((userProfile.following) ?? 0)
      }
   }

   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.

      userTweetsTableView.delegate = self
      userTweetsTableView.dataSource = self

      viewBorderGray(tweetsView)
      viewBorderGray(followersView)
      viewBorderGray(followingView)

      loadTweetData()
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


   /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return userTweets.count
   }

   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let tweetCell = userTweetsTableView.dequeueReusableCellWithIdentifier("UserTweetCell", forIndexPath: indexPath) as! UserTweetViewCell
      tweetCell.tweet = userTweets[indexPath.row]
      return tweetCell
   }

   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
   }

   func loadTweetData(){

      print (" loading user profile: \(profileScreenName)")
      let params: NSDictionary = ["screen_name" : profileScreenName ]

      TwitterClient.sharedInstance.userShow(params, success: { (userProfile: UserProfile) in
         self.userProfile = userProfile

         }, failure: { (error: NSError) in
            print("Error getting user timeline: \(error.localizedDescription)")
      })

      TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) in
         self.userTweets = tweets
         self.userTweetsTableView.reloadData()
         
         }, failure: { (error: NSError) in
            print("Error getting home timeline: \(error.localizedDescription)")
      })
   }
}

