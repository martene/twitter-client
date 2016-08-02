//
//  NewTweetViewController.swift
//  twitter-client
//
//  Created by Martene Mendy on 7/31/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit


let MAX_CHARATCER_COUNT = 140
let intialCharacterCount = String(MAX_CHARATCER_COUNT)

class NewTweetViewController: UIViewController, UITextViewDelegate {

   @IBOutlet weak var usernameLabel: UILabel!
   @IBOutlet weak var profileImage: UIImageView!
   @IBOutlet weak var newTweetTextView: UITextView!
   @IBOutlet weak var screenNameLabel: UILabel!

   var user = User.currentUser

   @IBOutlet weak var cancelButtonItem: UIBarButtonItem!
   @IBOutlet weak var tweetButtonItem: UIBarButtonItem!

   var charatersCountButton = UIBarButtonItem(title: intialCharacterCount, style: .Plain, target: nil, action: nil)

   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.

      newTweetTextView.delegate = self

      // customize navigation bar
      cancelButtonItem.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Arial", size: 13)!], forState: UIControlState.Normal)
      tweetButtonItem.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Arial", size: 13)!], forState: UIControlState.Normal)
      navigationItem.rightBarButtonItems?.append(charatersCountButton)

      usernameLabel.text = user?.name as? String
      screenNameLabel.text = "@" + ((user?.screenName)! as String)

      let url = user?.profileUrl
      profileImage.setImageWithURL(url!)
      profileImage.layer.cornerRadius = 3
      profileImage.clipsToBounds = true
      newTweetTextView.text = ""
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   @IBAction func onSendTweet(sender: AnyObject) {
      print("sending new tweet...")
      //let statusText = newTweetTextView.text.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
      //let params: NSDictionary = ["status" : statusText!]
      let params: NSDictionary = ["status" : newTweetTextView.text]
      TwitterClient.sharedInstance.createTweet(params, success: { (tweet: Tweet) in
         print("created \(tweet.text)")

         // go to hometimeline
         self.navigationController?.popViewControllerAnimated(true)
         
      }) { (error: NSError) in
            print("error creating tweet...\(error.localizedDescription)")
      }
   }

   @IBAction func onCancel(sender: AnyObject) {
      print("cancelling new tweet...")
      navigationController?.popViewControllerAnimated(true)
   }

   func textViewShouldBeginEditing(textView: UITextView) -> Bool {
      return true
   }

   func textViewDidChange(textView: UITextView) {
      let currentText = textView.text
      let charactersCount = currentText.characters.count
      if MAX_CHARATCER_COUNT >= charactersCount {
         let characterCountLeft = MAX_CHARATCER_COUNT - charactersCount
         print("text has changed \(characterCountLeft)")
         charatersCountButton.title = String(characterCountLeft)
      }
      else {
  // TODO
      //   textView.text = currentText.substringToIndex(currentText.endIndex.advancedBy(MAX_CHARATCER_COUNT-1))
      }
   }

   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.

      print("new tweet posted segue id: \(segue.identifier)")

      print("prepareForSegue sending new tweet...")
      //let statusText = newTweetTextView.text.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
      //let params: NSDictionary = ["status" : statusText!]
     let params: NSDictionary = ["status" : newTweetTextView.text]
      TwitterClient.sharedInstance.createTweet(params, success: { (tweet: Tweet) in
         print("created \(tweet.text)")

         // go to hometimeline
         //self.performSegueWithIdentifier("NewTweetPostedSegue", sender: nil)
         //sender?.popViewControllerAnimated(true//

         let tweetsViewController = segue.destinationViewController as! TweetsViewController
         tweetsViewController.addedTweet = tweet

      }) { (error: NSError) in
         print("error creating tweet...\(error.localizedDescription)")
      }
   }

}
