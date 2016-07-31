//
//  TweetCellView.swift
//  twitter-client
//
//  Created by Martene Mendy on 7/30/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit

class TweetCellView: UITableViewCell {

   var tweet: Tweet! {
      didSet {

         let retweetedCount = (tweet.retweeted!) ?? 0
         if retweetedCount != 0{
            retweetedLabel.text = String(retweetedCount) + " retweeted"
            //retweetedLabel.icon = imageResized
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
         profileImage.setImageWithURL((tweet.user?.profileUrl)!)
         nameLabel.text = tweet.user?.name as? String
         screenNameLabel.text = "@" + ((tweet.user?.screenName)! as String)
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

   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }

   override func setSelected(selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
}
