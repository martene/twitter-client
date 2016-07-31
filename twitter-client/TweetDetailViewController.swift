//
//  TweetDetailViewController.swift
//  twitter-client
//
//  Created by Martene Mendy on 7/30/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

   @IBOutlet weak var replyButtonItem: UIBarButtonItem!

   @IBOutlet weak var retweetedLabel: UILabel!
   @IBOutlet weak var createdAtLabel: UILabel!
   @IBOutlet weak var tweetTextLabel: UILabel!
   @IBOutlet weak var profileImage: UIImageView!
   @IBOutlet weak var userNameLabel: UILabel!
   @IBOutlet weak var screenNameLabel: UILabel!

   @IBOutlet weak var retweetCountLabel: UILabel!
   @IBOutlet weak var favoriteCountLabel: UILabel!
   var tweet: Tweet!

   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
      replyButtonItem.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Arial", size: 13)!], forState: UIControlState.Normal)
      //navigationItem.backBarButtonItem!.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Arial", size: 13)!], forState: UIControlState.Normal)

      print ("tweet \(tweet.retweetCount)")
      let retweetedCount = (tweet.retweeted!) ?? 0
      if retweetedCount != 0{
         retweetedLabel.text = String(retweetedCount) + " retweeted"
         //retweetedLabel.icon = imageResized
         //retweetedLabel.iconPosition = .Left
      }

      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "M/d/y, HH:mm a"
      createdAtLabel.text = dateFormatter.stringFromDate((tweet.createdAt)!)

      tweetTextLabel.text = tweet.text! as String
      retweetCountLabel.text = String(tweet.retweetCount!)
      favoriteCountLabel.text = String(tweet.favoritesCount!)

      // user's
      profileImage.setImageWithURL((tweet.user?.profileUrl)!)
      userNameLabel.text = tweet.user?.name as? String
      screenNameLabel.text = "@" + ((tweet.user?.screenName)! as String)

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

}
