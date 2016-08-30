//
//  DoubleExtension.swift
//  smiity
//
//  Created by João Borges on 20/06/16.
//  Copyright © 2016 Mobinteg. All rights reserved.
//

import Foundation


public extension Double {
    public func format(f: String) -> String {
        return NSString(format: "%\(f)f", self) as String
    }

    func convertTimestampToDate () -> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateConverted = NSDate(timeIntervalSince1970: self)
        return formatter.dateFromString(formatter.stringFromDate(dateConverted))!
    }
}
