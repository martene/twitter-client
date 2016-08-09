//
//  ViewUtils.swift
//  twitter-client
//
//  Created by Martene Mendy on 7/31/16.
//  Copyright © 2016 Martene Mendy. All rights reserved.
//

import UIKit

struct FontsColors {
   static let TWITTER_LIGHT_BLUE = UIColor(red:0.33, green:0.67, blue:0.93, alpha:1.0)
   static let ARIAL13 = UIFont(name: "Arial", size: 13)!
   static let charade = UIColor(red:0.16, green:0.18, blue:0.20, alpha:1.0)
   static let flord = UIColor(red:0.40, green:0.46, blue:0.50, alpha:1.0)
   static let mischka = UIColor(red:0.70, green:0.74, blue:0.77, alpha:1.0)
   static let nephritis = UIColor(red:0.15, green:0.68, blue:0.38, alpha:1.0)
   static let paper = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)

   static let buttonFontAttributeName = UIFont(name: "Arial", size: 13)!

}


func customizeImage(imageView: UIImageView, url: NSURL){
   imageView.setImageWithURL(url)
   imageView.layer.cornerRadius = 3
   imageView.clipsToBounds = true
}

func viewBorderGray(view: UIView){
   view.layer.borderWidth = 1
   view.layer.borderColor = UIColor.lightGrayColor().CGColor
}


