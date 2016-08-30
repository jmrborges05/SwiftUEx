//
//  UIViewControllerExtension.swift
//  smiity
//
//  Created by Diogo Grilo on 27/08/15.
//  Copyright © 2015 Diogo Grilo. All rights reserved.
//

import UIKit

extension UIViewController {


     func removeTitleFromBacK() {
          self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<", style: .Plain, target: nil, action: nil)
     }

     func displayContentController(vc: UIViewController) {
          self.addChildViewController(vc)
          vc.view.frame = self.view.bounds
          vc.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
          self.view.addSubview(vc.view)
          vc.didMoveToParentViewController(self)
     }
     func displayContentControllerNavBar(vc: UIViewController) {
          self.addChildViewController(vc)
          var rect = self.view.bounds
          rect.origin.y = 64
          rect.size.height -= 64
          vc.view.frame = rect
          vc.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
          self.view.addSubview(vc.view)
          vc.didMoveToParentViewController(self)
     }

     func displayContentControllerInView(vc: UIViewController, v: UIView) {
          self.addChildViewController(vc)
          vc.view.frame = v.frame
          vc.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
          v.addSubview(vc.view)
          vc.didMoveToParentViewController(self)
     }

     func displayContentControllerInViewAnimated(vc: UIViewController, v: UIView) {
          self.addChildViewController(vc)
          vc.view.frame = v.frame
          vc.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
          v.addSubview(vc.view)
          UIView.animateWithDuration(0.2, animations: {}, completion: {(value: Bool) in
               vc.didMoveToParentViewController(self)
          })
     }

     func cycleViewController (oldViewController: UIViewController, newViewController: UIViewController, onComplete:(() -> Void)?) {
          oldViewController.willMoveToParentViewController(nil)
          oldViewController.removeFromParentViewController()
          addChildViewController(newViewController)
          newViewController.view.frame = self.view.bounds
          newViewController.view.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
          newViewController.view.alpha = 0
          self.view.addSubview(newViewController.view)
          newViewController.didMoveToParentViewController(self)
          UIView.animateWithDuration(0.25, animations: { () -> Void in
               newViewController.view.alpha = 1
               oldViewController.view.alpha = 0
          }) { (finished) -> Void in
               oldViewController.view.removeFromSuperview()
               if let completed = onComplete {
                    completed()
               }
          }
     }
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
