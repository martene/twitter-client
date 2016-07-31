//
//  ViewController.swift
//  twitter-client
//
//  Created by Martene Mendy on 7/30/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }

   @IBAction func onLogin(sender: UIButton) {
      // call the api to login
      TwitterClient.sharedInstance.loginUser({() -> () in
         print("User successfully login!")
         self.performSegueWithIdentifier("loginSuccessSegue", sender: nil)
      }) { (failure: NSError) in
            print("not login!")
      }
   }
}