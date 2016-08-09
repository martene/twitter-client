//
//  Menu.swift
//  twitter-client
//
//  Created by Martene Mendy on 8/6/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit

class Menu: NSObject {

   var title: NSString!
   var icon: UIImage!
   var navigationController: UIViewController!

   let storyboard = UIStoryboard(name: "Main", bundle: nil)

   init(dictionary: NSDictionary){
      title = dictionary["title"] as! String
      icon = UIImage(named: (dictionary["icon"] as! String))
      let navigationControllerID = dictionary["navigationController"] as! String
      navigationController =  storyboard.instantiateViewControllerWithIdentifier(navigationControllerID)
   }
}
