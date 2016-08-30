//
//  UIViewExtension.swift
//  smiity
//
//  Created by João Borges on 16/06/16.
//  Copyright © 2016 Mobinteg. All rights reserved.
//

import Foundation

extension UIView {
     func fadeIn(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
          UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
               self.alpha = 1.0
               }, completion: completion)  }

     func fadeOut(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: (Bool) -> Void = {(finished: Bool) -> Void in}) {
          UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
               self.alpha = 0.0
               }, completion: completion)
     }
}
