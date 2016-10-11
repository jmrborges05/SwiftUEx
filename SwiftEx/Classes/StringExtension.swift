//
//  StringExtension.swift
//  smiity
//
//  Created by João Borges on 04/01/16.
//  Copyright © 2016 Diogo Grilo. All rights reserved.
//

import Foundation

public extension String {

    public func substringWithRange(start: Int, end: Int) -> String {
        if (start < 0 || start > self.characters.count) {
            print("start index \(start) out of bounds")
            return ""
        } else if end < 0 || end > self.characters.count {
            print("end index \(end) out of bounds")
            return ""
        }
        let range = self.startIndex.advancedBy(start) ..< self.startIndex.advancedBy(end)
        return self.substringWithRange(range)
    }

    public func substringWithRange(start: Int, location: Int) -> String {
        if (start < 0 || start > self.characters.count) {
            print("start index \(start) out of bounds")
            return ""
        } else if location < 0 || start + location > self.characters.count {
            print("end index \(start + location) out of bounds")
            return ""
        }
        let range = self.startIndex.advancedBy(start) ..< self.startIndex.advancedBy(start + location)
        return self.substringWithRange(range)
    }


    public func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.max)

        let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)

        return boundingBox.height
    }

    public func removeHtmlTags ( htmltext: String ) -> String {
        return htmltext.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
    }

    public func fromBase64() -> String {
        let data = NSData(base64EncodedString: self, options: NSDataBase64DecodingOptions(rawValue: 0))
        return String(data: data!, encoding: NSUTF8StringEncoding)!
    }

    public func toBase64() -> String {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        return data!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    }

    public var length: Int {
        return self.characters.count
    }

    public var objcLength: Int {
        return self.utf16.count
    }

    public func detectLanguage() -> String? {
        if self.length > 4 {
            let tagger = NSLinguisticTagger(tagSchemes:[NSLinguisticTagSchemeLanguage], options: 0)
            tagger.string = self
            return tagger.tagAtIndex(0, scheme: NSLinguisticTagSchemeLanguage, tokenRange: nil, sentenceRange: nil)
        }
        return nil
    }

    public func detectScript() -> String? {
        if self.length > 1 {
            let tagger = NSLinguisticTagger(tagSchemes:[NSLinguisticTagSchemeScript], options: 0)
            tagger.string = self
            return tagger.tagAtIndex(0, scheme: NSLinguisticTagSchemeScript, tokenRange: nil, sentenceRange: nil)
        }
        return nil
    }

    public var isRightToLeft: Bool {
        let language = self.detectLanguage()
        return (language == "ar" || language == "he")
    }

    public func isOnlyEmptySpacesAndNewLineCharacters() -> Bool {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).length == 0
    }

    public func isTweetable() -> Bool {
        let tweetLength = 140,
        // Each link takes 23 characters in a tweet (assuming all links are https).
        linksLength = self.getLinks().count * 23,
        remaining = tweetLength - linksLength
        if linksLength != 0 {
            return remaining < 0
        } else {
            return !(self.utf16.count > tweetLength || self.utf16.count == 0 || self.isOnlyEmptySpacesAndNewLineCharacters())
        }
    }

    public func getLinks() -> [String] {
        let detector = try? NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        let links = detector?.matchesInString(self, options: NSMatchingOptions.ReportCompletion, range: NSRange(location: 0, length: length)).map {$0 }
        return links!.filter { link in
            return link.URL != nil
            }.map { link -> String in
                return link.URL!.absoluteString
        }
    }

    public func getURLs() -> [NSURL] {
        let detector = try? NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        let links = detector?.matchesInString(self, options: NSMatchingOptions.ReportCompletion, range: NSRange(location: 0, length: length)).map {$0 }
        return links!.filter { link in
            return link.URL != nil
            }.map { link -> NSURL in
                return link.URL!
        }
    }

    public  func getDates() -> [NSDate] {
        let error: NSErrorPointer = nil
        let detector: NSDataDetector?
        do {
            detector = try NSDataDetector(types: NSTextCheckingType.Date.rawValue)
        } catch let error1 as NSError {
            error.memory = error1
            detector = nil
        }
        let dates = detector?.matchesInString(self, options: NSMatchingOptions.WithTransparentBounds, range: NSMakeRange(0, self.utf16.count)) .map {$0 }
        return dates!.filter { date in
            return date.date != nil
            }.map { link -> NSDate in
                return link.date!
        }
    }

    public func getHashtags() -> [String]? {
        let hashtagDetector = try? NSRegularExpression(pattern: "#(\\w+)", options: NSRegularExpressionOptions.CaseInsensitive)
        let results = hashtagDetector?.matchesInString(self, options: NSMatchingOptions.WithoutAnchoringBounds, range: NSMakeRange(0, self.utf16.count)).map { $0 }
        return results?.map({
            (self as NSString).substringWithRange($0.rangeAtIndex(1))
        })
    }

    public func getUniqueHashtags() -> [String]? {
        return Array(Set(getHashtags()!))
    }

    public func getMentions() -> [String]? {
        let hashtagDetector = try? NSRegularExpression(pattern: "@(\\w+)", options: NSRegularExpressionOptions.CaseInsensitive)
        let results = hashtagDetector?.matchesInString(self, options: NSMatchingOptions.WithoutAnchoringBounds, range: NSMakeRange(0, self.utf16.count)).map { $0 }

        return results?.map({
            (self as NSString).substringWithRange($0.rangeAtIndex(1))
        })
    }

    public func getUniqueMentions() -> [String]? {
        return Array(Set(getMentions()!))
    }

    public func containsLink() -> Bool {
        return self.getLinks().count > 0
    }

    public  func containsDate() -> Bool {
        return self.getDates().count > 0
    }

    public func encodeToBase64Encoding() -> String {
        let utf8str = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        return utf8str.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
    }

    public func decodeFromBase64Encoding() -> String {
        let base64data = NSData(base64EncodedString: self, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        return NSString(data: base64data!, encoding: NSUTF8StringEncoding)! as String
    }

    public  var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        let firstMatch = dataDetector?.firstMatchInString(self, options: NSMatchingOptions.ReportCompletion, range: NSRange(location: 0, length: length))

        return (firstMatch?.range.location != NSNotFound && firstMatch?.URL?.scheme == "mailto")
    }

    public  func verifyUrl () -> Bool {
        if case self = self {
            if let url = NSURL(string: self) {
                return UIApplication.sharedApplication().canOpenURL(url)
            }
        }
        return false
    }

    public  func removeIframe () -> String {
        return (self as NSString).stringByReplacingOccurrencesOfString("<iframe[^>]*>", withString: "", options: [NSStringCompareOptions.CaseInsensitiveSearch, NSStringCompareOptions.RegularExpressionSearch], range: NSMakeRange(0, self.length))
    }

    public  func removeHtmlTags () -> String {
        return self.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
    }

    public  func getMinutesToPieFromDate () -> Float {
        let minutesFromDuration = Int(String(self.substringWithRange(Range<String.Index>(self.startIndex.advancedBy(3)..<self.endIndex.advancedBy(-3)))))
        let hoursFromDuration = Int(String(self.characters.prefix(2)))
        let minutesOfTrail: Double = (Double((hoursFromDuration)!) * 60) + Double((minutesFromDuration)!)
        if minutesOfTrail == 1440.0 {
            return 1.0
        }
        return ((Float(minutesOfTrail) * Float(1440)) / 24) / 100000
    }

    public func convertDateFromStringToDate () -> NSDate {
        let df = NSDateFormatter()
        df.dateFormat = "dd/MM/yyyy HH:mm"
        return df.dateFromString(self)!
    }

    public  func htmlText() -> NSAttributedString? {
        return try? NSAttributedString(data: self.dataUsingEncoding(NSUTF16StringEncoding )!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
    }

    public func htmlText2(fontName: String) -> NSAttributedString? {
        let htmlStr = "<div style=\"font-family: \(fontName);font-size: 16px;\">\(self)</div>"
        let attributedString = try? NSMutableAttributedString(data: htmlStr.dataUsingEncoding(NSUTF32StringEncoding, allowLossyConversion: false)!, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
        attributedString!.addAttribute(NSForegroundColorAttributeName, value: UIColor.darkGrayColor(), range: NSRange(location:0, length:(attributedString?.length)!))
        return attributedString
    }

    public  func stringify(params: [String:AnyObject]?, contents: [String]) -> String {
        let contentsString = (contents.count > 0) ? "{\(contents.joinWithSeparator(","))}" : ""
        if params == nil {
            return "\(self) \(contentsString)"
        }
        return "\(self) (\(self.stringifyParams(params!))) \(contentsString)"
    }

    public  func stringify2(params: [String:AnyObject]?, content: [String]?) -> String {

        if params == nil {
            return "\(self) {\(content!.joinWithSeparator(","))}"
        }

        var array = [String]()

        for (key, value) in params! {
            array.append("\(key):\(value)")
        }
        if content != nil {
            return "\(self) (\(array.joinWithSeparator(","))) {\(content!.joinWithSeparator(","))}"
        } else {
            return "\(self) (\(array.joinWithSeparator(",")))"
        }
    }

    public  func stringifyParams(params: [String:AnyObject]) -> String {
        var array = [String]()
        for (key, var value) in params {
            if let valueArray = value as? [[String:AnyObject]] {
                var strings = [String]()
                for valueDict in valueArray {
                    strings.append("{\("".stringifyParams(valueDict))}")
                }
                value = "[\(strings.joinWithSeparator(","))]"
            } else if let valueDict = value as? [String:AnyObject] {
                value = "{\("".stringifyParams(valueDict))}"
            } else if let valueString = value as? String {
                if value.containsString("#") {
                    value = String(valueString.characters.dropFirst())
                } else {
                    value = "\"\(value)\""
                }
            }
            array.append("\(key):\(value)")
        }
        return array.joinWithSeparator(",")
    }
    
    func truncate(length: Int, trailing: String? = nil) -> String {
        if self.characters.count > length {
            return self.substringToIndex(self.startIndex.advancedBy(length)) + (trailing ?? "")
        } else {
            return self
        }
    }
}
