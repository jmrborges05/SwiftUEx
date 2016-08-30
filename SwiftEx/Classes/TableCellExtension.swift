//
//  TableCellExtension.swift
//  smiity
//
//  Created by João Borges on 05/07/16.
//  Copyright © 2016 Mobinteg. All rights reserved.
//

import Foundation


extension UITableViewCell {
     func shareItem(description: NSAttributedString, link: String) {
          let activityViewController = UIActivityViewController(activityItems: [link], applicationActivities: nil)
          let excludeActivities = [
               UIActivityTypeAssignToContact, UIActivityTypePostToVimeo, UIActivityTypePostToFlickr, UIActivityTypeSaveToCameraRoll, UIActivityTypeAirDrop
          ]
          activityViewController.excludedActivityTypes = excludeActivities
          activityViewController.completionWithItemsHandler = {
               (activity, success, items, error) in
               UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
          }
          if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Phone {
               UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(activityViewController, animated: true, completion: nil)
               UIBarButtonItem.appearance().tintColor = UIColor(red: 0.259, green:0.522, blue:0.957, alpha:1)
          }
     }
}
