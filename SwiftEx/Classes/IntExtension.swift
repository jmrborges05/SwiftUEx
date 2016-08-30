//
//  IntExtension.swift
//  smiity
//
//  Created by João Borges on 21/07/16.
//  Copyright © 2016 Mobinteg. All rights reserved.
//

import Foundation


extension Int {
     func timeFormatted() -> String {
          let minutes: Int = (self / 60) % 60
          let hours: Int = self / 3600
          return String(format: "%02d:%02d", hours, minutes)
     }
}
