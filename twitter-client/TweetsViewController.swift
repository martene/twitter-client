//
//  TweetsViewController.swift
//  twitter-client
//
//  Created by Martene Mendy on 7/30/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   @IBOutlet weak var tweetsTableView: UITableView!
   @IBOutlet weak var logoutButtonItem: UIBarButtonItem!
   @IBOutlet weak var newBarButtonItem: UIBarButtonItem!

   var tweets = [Tweet]()

   let refreshControl = UIRefreshControl()

   var addedTweet: Tweet! {
      didSet {
         print("tweets added size 0: \(tweets.count)")
         tweets.insert(addedTweet, atIndex: 0)
         print("tweets size 1: \(tweets.count)")
         tweets.removeLast()
      }
   }

   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.

      //Adding Pull-to-Refresh
      refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
      tweetsTableView.insertSubview(refreshControl, atIndex: 0)

      logoutButtonItem.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Arial", size: 13)!], forState: UIControlState.Normal)
      newBarButtonItem.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Arial", size: 13)!], forState: UIControlState.Normal)

      tweetsTableView.dataSource = self
      tweetsTableView.delegate = self

      loadTweetData()
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   @IBAction func onLogoutUser(sender: AnyObject) {
      TwitterClient.sharedInstance.logoutUser()
   }

   @IBAction func onNewTweet(sender: AnyObject) {
      print("creating new tweet...")
   }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.

      print("segue id: \(segue.identifier)")

      if segue.identifier == "TweetDetailSeque" {
         let tweetCell = sender as! UITableViewCell
         let indexPath = tweetsTableView.indexPathForCell(tweetCell)
         print("segue: \(indexPath!.row)")
         let tweet = tweets[indexPath!.row]
         let detailViewController = segue.destinationViewController as! TweetDetailViewController
         detailViewController.tweet = tweet
      }
      else {
         
      }
   }


   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tweetsTableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCellView
      cell.tweet = tweets[indexPath.row]
      return cell
   }

   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tweets.count
   }

   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)
   }

   func loadTweetData(){
      if addedTweet != nil {
         print("tweets size 0: \(tweets.count)")
         self.tweets.insert(addedTweet, atIndex: 0)
         print("tweets size 1: \(tweets.count)")
         self.tweets.removeLast()
         print("tweets size 2: \(tweets.count)")
         self.tweetsTableView.reloadData()
      }else {
         print (" loadTweetData... ")
         TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) in
            self.tweets = tweets
            self.tweetsTableView.reloadData()

            }, failure: { (error: NSError) in
               print("Error getting home timeline: \(error.localizedDescription)")
         })
      }
   }

   func refreshControlAction(refreshControl: UIRefreshControl){

      loadTweetData()

      // Tell the refreshControl to stop spinning
      refreshControl.endRefreshing()
   }

}
