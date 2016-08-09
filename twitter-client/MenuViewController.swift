//
//  MenuViewController.swift
//  twitter-client
//
//  Created by Martene Mendy on 8/5/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   @IBOutlet weak var menuTableView: UITableView!

   let menus: [NSDictionary] = [
      ["id": "0", "title": "Profile", "icon": "profile-eye", "navigationController": "ProfileNavigationController"]
      ,["id": "1", "title": "Home timeline", "icon": "timeline", "navigationController": "HomeTimelineNavigationController"]
      //,["id": "2", "title": "Mention", "icon": "user_group", "navigationController": "TweetsNavigationController"]
   ]

   var hamburgerViewController: HamburgerViewController! = nil

   override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.

      menuTableView.delegate = self
      menuTableView.dataSource = self

      // avoid extra line in the table
      menuTableView.tableFooterView = UIView(frame: CGRectZero)
      menuTableView.reloadData()
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
      return menus.count
   }

   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let menuDictionary = menus[indexPath.row]
      let menuCell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuViewCell
      menuCell.menu = Menu(dictionary: menuDictionary)
      //print("row \(menus[indexPath.row])")
      return menuCell
   }

   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      tableView.deselectRowAtIndexPath(indexPath, animated: true)

      let menuDictionary = menus[indexPath.row]
      let menu = Menu(dictionary: menuDictionary)

      let selectedController = menu.navigationController

      hamburgerViewController.contentViewController = selectedController
      hamburgerViewController.leftMarginConsgtraint.constant = 0
   }
}
