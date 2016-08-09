//
//  HamburgerViewController.swift
//  twitter-client
//
//  Created by Martene Mendy on 8/5/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

   @IBOutlet weak var menuView: UIView!
   @IBOutlet weak var contentView: UIView!
   @IBOutlet weak var leftMarginConsgtraint: NSLayoutConstraint!

   var originalLeftmargin: CGFloat!

   var profileScreenName: NSString!

   var menuViewController: MenuViewController! {
      didSet {
         view.layoutIfNeeded()
         menuView.addSubview(menuViewController.view)
      }
   }
   var contentViewController: UIViewController! {
      didSet {
         view.layoutIfNeeded()
         contentView.addSubview(contentViewController.view)
      }
   }

   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let homeNavigationController = storyboard.instantiateViewControllerWithIdentifier("HomeTimelineNavigationController")
      let menuNavigationController = storyboard.instantiateViewControllerWithIdentifier("MenuNavigationController") as! UINavigationController
      //let contentNavigationController = storyboard.instantiateViewControllerWithIdentifier("ContentNavigationController") as! UINavigationController
       menuViewController = menuNavigationController.topViewController as! MenuViewController

      if profileScreenName == nil {
      contentViewController = homeNavigationController
         leftMarginConsgtraint.constant = 0
      }

      menuViewController.hamburgerViewController = self
   
      view.reloadInputViews()
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {

      let translation = sender.translationInView(view)
      let velocity = sender.velocityInView(view)

      if sender.state == UIGestureRecognizerState.Began {
         originalLeftmargin = leftMarginConsgtraint.constant

      }else if sender.state == UIGestureRecognizerState.Changed {
         leftMarginConsgtraint.constant = originalLeftmargin + translation.x

      }else if sender.state == UIGestureRecognizerState.Ended {
         UIView.animateWithDuration(0.3, animations: {
            if velocity.x > 0 {
               // opening
               self.leftMarginConsgtraint.constant = self.view.frame.width - 45
            } else {
               self.leftMarginConsgtraint.constant = 0
            }
            self.view.layoutIfNeeded()
         })
      }
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
