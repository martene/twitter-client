//
//  ProfileViewController.swift
//  twitter-client
//
//  Created by Martene Mendy on 8/7/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController { //, UITableViewDelegate, UITableViewDataSource {

   var userTweets = [Tweet]()

   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
      //
      //    logoutButtonItem.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Arial", size: 13)!], forState: UIControlState.Normal)

      //userTweetsTableView.delegate = self
      //userTweetsTableView.dataSource = self

      // avoid extra line in the table
      //userTweetsTableView.tableFooterView = UIView(frame: CGRectZero)

//      loadTweetData()

      //tweetsTableView.reloadData()
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

   /*func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return userTweets.count
   }

   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let tweetCell = userTweetsTableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCellView
      tweetCell.tweet = userTweets[indexPath.row]
      return tweetCell
   }

   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
   }

   func loadTweetData(){

      print (" loadTweetData... ")
      TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) in
         self.userTweets = tweets
         self.userTweetsTableView.reloadData()

         }, failure: { (error: NSError) in
            print("Error getting home timeline: \(error.localizedDescription)")
      })
   } */
}
