//
//  TweetCellView.swift
//  twitter-client
//
//  Created by Martene Mendy on 7/30/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit
import SMIconLabel

class TweetCellView: UITableViewCell {

   let tweetFavorited = false
   var tweet: Tweet! {
      didSet {

         retweetedLabel.text = ""
         let retweetedCount = (tweet.retweeted!) ?? 0
         if retweetedCount != 0{
            /*
             let labl = SMIconLabel()
             labl.text = "john retweeted"
             labl.icon = UIImage(named: "retweet") // Set icon image
             labl.iconPadding = 5               // Set padding between icon and label
             labl.numberOfLines = 0             // Required
             labl.iconPosition = SMIconLabelPosition.Left // Icon position
             theview.addSubview(labl)
             */
            retweetedLabel.text = String(retweetedCount) + " retweeted"
            //retweetedLabel.icon = UIImage(named: "retweet-action")
            //retweetedLabel.iconPosition = .Left
         }

         let interval = Int(-(tweet.createdAt?.timeIntervalSinceNow)!)
         var intervalText: String!
         if interval < 60 {
            intervalText =  String(interval) + "s"
         }else if interval > 3600 {
            intervalText =  String(interval/3600) + "h"
         }else {
            intervalText =  String((interval / 60) % 60) + "m"
         }
         createdSinceLabel.text = intervalText
         tweetTextLabel.text = tweet.text! as String
         //retweetCountLabel.text = String(tweet.retweetCount!)
         //favoritesCountLabel.text = String(tweet.favoritesCount!)

         // user's
         customizeImage(profileImage, url: (tweet.user?.profileUrl)!)
         let tap = UITapGestureRecognizer(target: self, action: #selector(TweetCellView.openUserProfile))
         profileImage.addGestureRecognizer(tap)
         profileImage.userInteractionEnabled = true


         nameLabel.text = tweet.user?.name as? String
         screenNameLabel.text = "@" + ((tweet.user?.screenName)! as String)


         replyButton.setImage(UIImage(named: "reply"), forState: UIControlState.Normal)
         retweetButton.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)

         // check if user favorite this tweet
         //tweetFavorited = { from tweet }
         var favImage: UIImage!
         if tweetFavorited {
            favImage = UIImage(named: "star-gold")
         }else {
            favImage = UIImage(named: "star2")
         }
         favoriteButton.setImage(favImage, forState: UIControlState.Normal)
      }
   }

   @IBOutlet weak var retweetedLabel: UILabel!
   @IBOutlet weak var profileImage: UIImageView!
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var screenNameLabel: UILabel!
   @IBOutlet weak var createdSinceLabel: UILabel!
   @IBOutlet weak var tweetTextLabel: UILabel!
   @IBOutlet weak var retweetCountLabel: UILabel!
   @IBOutlet weak var favoritesCountLabel: UILabel!

   @IBOutlet weak var replyImageView: UIImageView!
   @IBOutlet weak var retweetImageView: UIImageView!
   @IBOutlet weak var favoriteImageView: UIImageView!

   @IBOutlet weak var replyButton: UIButton!
   @IBOutlet weak var retweetButton: UIButton!
   @IBOutlet weak var favoriteButton: UIButton!
   // @IBOutlet weak var replyButton: UIButton!
   //@IBOutlet weak var retweetButton: UIButton!
   //@IBOutlet weak var favoriteButton: UIButton!

   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }

   override func setSelected(selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)

      // Configure the view for the selected state
   }

   @IBAction func onReplyButton(sender: UIButton) {
      print("Reply button....")

   }
   @IBAction func onRetweetButton(sender: UIButton) {
      print("Retweet button....")

   }
   @IBAction func onFavoriteButton(sender: UIButton) {
      print("Favorite button....")

   }

   func openUserProfile(){
      print(" open user profile \(tweet.user?.screenName)")
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let profileNavigationController = storyboard.instantiateViewControllerWithIdentifier("ProfileNavigationController") as! UINavigationController
      let userProfileViewController = profileNavigationController.topViewController as! UserProfileViewController
      userProfileViewController.profileScreenName = (tweet.user?.screenName)!

      let hamburgerNavigationController = storyboard.instantiateViewControllerWithIdentifier("HamburgerNavigationController") as! UINavigationController
      let hamburgerViewController = hamburgerNavigationController.topViewController as! HamburgerViewController
      hamburgerViewController.profileScreenName = (tweet.user?.screenName)!
      hamburgerViewController.contentViewController = profileNavigationController

      window?.rootViewController = hamburgerViewController
   }
}
