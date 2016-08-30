//
//  MINSDateExtension.swift
//  Ichor Sports
//
//  Created by João Borges on 19/02/16.
//  Copyright © 2016 João Borges. All rights reserved.
//
import Foundation

public extension NSDate {

    public func getUTC () -> String {
        let date = NSDate()

        if let utcCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
            if let utcTimeZone = NSTimeZone(abbreviation: "UTC") {

                utcCalendar.timeZone = utcTimeZone

                let ymdhmsUnitFlags: NSCalendarUnit = [NSCalendarUnit.Year, .Month, .Day, .Hour, .Minute, .Second]

                let utcDateComponents = utcCalendar.components(ymdhmsUnitFlags, fromDate: date)

                // Create string of form "yyyy-mm-dd hh:mm:ss"
                let utcDateTimeString = NSString(format: "%04u-%02u-%02u %02u:%02u:%02u",
                                                 UInt(utcDateComponents.year),
                                                 UInt(utcDateComponents.month),
                                                 UInt(utcDateComponents.day),
                                                 UInt(utcDateComponents.hour),
                                                 UInt(utcDateComponents.minute),
                                                 UInt(utcDateComponents.second))
                return utcDateTimeString as String
            }
        }
        return ""
    }

    public func getDayOfDate() -> Int {
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let stringFromDate = formatter.stringFromDate(self)
        let todayDate = formatter.dateFromString(stringFromDate)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Day, fromDate: todayDate)
        let weekDay = myComponents.day
        return weekDay
    }

    public func plusSeconds(s: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }

    public func minusSeconds(s: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: -Int(s), minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }

    public func plusMinutes(m: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }

    public func minusMinutes(m: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: -Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
    }

    public func plusHours(h: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }

    public func minusHours(h: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: -Int(h), days: 0, weeks: 0, months: 0, years: 0)
    }

    public func plusDays(d: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: Int(d), weeks: 0, months: 0, years: 0)
    }

    public func minusDays(d: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: -Int(d), weeks: 0, months: 0, years: 0)
    }

    public func plusWeeks(w: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: Int(w), months: 0, years: 0)
    }

    public func minusWeeks(w: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: -Int(w), months: 0, years: 0)
    }

    public func plusMonths(m: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: Int(m), years: 0)
    }

    public func minusMonths(m: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: -Int(m), years: 0)
    }

    public func plusYears(y: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: Int(y))
    }

    public func minusYears(y: UInt) -> NSDate {
        return self.addComponentsToDate(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: -Int(y))
    }

    public func addComponentsToDate(seconds sec: Int, minutes min: Int, hours hrs: Int, days d: Int, weeks wks: Int, months mts: Int, years yrs: Int) -> NSDate {
        let dc: NSDateComponents = NSDateComponents()
        dc.second = sec
        dc.minute = min
        dc.hour = hrs
        dc.day = d
        dc.weekOfYear = wks
        dc.month = mts
        dc.year = yrs
        return NSCalendar.currentCalendar().dateByAddingComponents(dc, toDate: self, options: [])!
    }

    public func midnightUTCDate() -> NSDate {
        let dc: NSDateComponents = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: self)
        dc.hour = 0
        dc.minute = 0
        dc.second = 0
        dc.nanosecond = 0
        dc.timeZone = NSTimeZone(forSecondsFromGMT: 0)

        return NSCalendar.currentCalendar().dateFromComponents(dc)!
    }

    public func oneMinuteToMidnightUTCDate() -> NSDate {
        let dc: NSDateComponents = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: self)
        dc.hour = 23
        dc.minute = 59
        dc.second = 0
        dc.nanosecond = 0
        dc.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        return NSCalendar.currentCalendar().dateFromComponents(dc)!
    }

    public  func secondsBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Second, fromDate: d1, toDate: d2, options:[])
        return dc.second
    }

    public  func minutesBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Minute, fromDate: d1, toDate: d2, options: [])
        return dc.minute
    }

    public  func hoursBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: d1, toDate: d2, options: [])
        return dc.hour
    }

    public  func daysBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Day, fromDate: d1, toDate: d2, options: [])
        return dc.day
    }

    public  func weeksBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.WeekOfYear, fromDate: d1, toDate: d2, options: [])
        return dc.weekOfYear
    }

    public  func monthsBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: d1, toDate: d2, options: [])
        return dc.month
    }

    public  func yearsBetween(date1 d1: NSDate, date2 d2: NSDate) -> Int {
        let dc = NSCalendar.currentCalendar().components(NSCalendarUnit.Year, fromDate: d1, toDate: d2, options: [])
        return dc.year
    }

    public func isGreaterThan(date: NSDate) -> Bool {
        return (self.compare(date) == .OrderedDescending)
    }

    public func isLessThan(date: NSDate) -> Bool {
        return (self.compare(date) == .OrderedAscending)
    }

    public var day: UInt {
        return UInt(NSCalendar.currentCalendar().component(.Day, fromDate: self))
    }

    public var month: UInt {
        return UInt(NSCalendar.currentCalendar().component(.Month, fromDate: self))
    }

    public var year: UInt {
        return UInt(NSCalendar.currentCalendar().component(.Year, fromDate: self))
    }

    public var hour: UInt {
        return UInt(NSCalendar.currentCalendar().component(.Hour, fromDate: self))
    }

    public var minute: UInt {
        return UInt(NSCalendar.currentCalendar().component(.Minute, fromDate: self))
    }

    public var second: UInt {
        return UInt(NSCalendar.currentCalendar().component(.Second, fromDate: self))
    }

    public var monthName: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.stringFromDate(self)
    }
    public var hour0x: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh"
        return dateFormatter.stringFromDate(self)
    }
    public var minute0x: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "mm"
        return dateFormatter.stringFromDate(self)
    }
}

extension NSDate: Comparable {

}

public func + (date: NSDate, timeInterval: NSTimeInterval) -> NSDate {
    return date.dateByAddingTimeInterval(timeInterval)
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    if lhs.compare(rhs) == .OrderedSame {
        return true
    }
    return false
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    if lhs.compare(rhs) == .OrderedAscending {
        return true
    }
    return false
}

public extension NSTimeZone {
    public func offsetStringFromGMT() -> String {
        var offsetSeconds = secondsFromGMT
        var offsetString = "+00:00"
        var offsetSymbol = "+"
        var offsetHoursLeadString = "0"
        var offsetMinutesLeadString = "0"
        if offsetSeconds < 0 {
            offsetSymbol = "-"
            offsetSeconds = (offsetSeconds * -1)
        }
        let offsetHours = Int(offsetSeconds / 3600)
        let offsetMinutes = offsetSeconds - (offsetHours * 3600)
        if offsetHours > 10 {
            offsetHoursLeadString = ""
        }
        if offsetMinutes > 10 {
            offsetMinutesLeadString = ""
        }
        offsetString = String(format: "%@%@%i:%@%i", offsetSymbol, offsetHoursLeadString, offsetHours, offsetMinutesLeadString, offsetMinutes)
        return offsetString
    }
}
