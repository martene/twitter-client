//
//  MenuViewCell.swift
//  twitter-client
//
//  Created by Martene Mendy on 8/6/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit

class MenuViewCell: UITableViewCell {

   @IBOutlet weak var menuImageView: UIImageView!
   @IBOutlet weak var menuNameLabel: UILabel!
   
   var navigationController: UIViewController!

   var menu: Menu! {
      didSet {
         menuNameLabel.text = menu.title as String
         menuImageView.image = menu.icon
         navigationController = menu.navigationController
      }
   }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
