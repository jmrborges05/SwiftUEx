//
//  JSON.swift
//  smiity
//
//  Created by João Borges on 22/08/16.
//  Copyright © 2016 Mobinteg. All rights reserved.
//

import Foundation
import SwiftyJSON

public extension JSON {
     mutating func changeKey(from: String, to: String) {
          if let entry = self.dictionaryObject?.removeValueForKey(from) {
               self[to] = JSON(entry)
          }
     }
}
