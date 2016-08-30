//
//  UIColorExtension.swift
//  smiity
//
//  Created by Diogo Grilo on 22/12/2015.
//  Copyright © 2015 Diogo Grilo. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    public convenience init(hexString: String) {
        let hexString: NSString = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let scanner            = NSScanner(string: hexString as String)

        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red:red, green:green, blue:blue, alpha:1)
    }

    public func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return NSString(format:"#%06x", rgb) as String
    }

    public convenience init( intRed: Int, intGreen: Int, intBlue: Int, alpha: CGFloat ) {
        self.init( red: CGFloat( intRed ) / 255, green: CGFloat( intGreen ) / 255, blue: CGFloat( intBlue ) / 255, alpha: alpha )
    }

    /// Returns a UIColor by scanning the string for a hex number.
    /// Skips any leading whitespace and ignores any trailing characters.


    /// Returns random color with supplied alpha.
    public  convenience init( randomWithAlpha alpha: CGFloat ) {
        let randomRed = Int( arc4random_uniform( 256 ) )
        let randomGreen = Int( arc4random_uniform( 256 ) )
        let randomBlue = Int( arc4random_uniform( 256 ) )
        self.init( intRed: randomRed, intGreen: randomGreen, intBlue: randomBlue, alpha: alpha )
    }


    public convenience init( int: UInt32 ) {

        let r = CGFloat(( int >> 16 ) & 0xFF )
        let g = CGFloat(( int >> 8 ) & 0xFF )
        let b = CGFloat( int & 0xFF )

        self.init( red: r / 255, green: g / 255, blue: b / 255, alpha: 1.0 )
    }

    public func randomColor() -> UIColor {
        let randomRed: CGFloat = CGFloat(drand48())
        let randomGreen: CGFloat = CGFloat(drand48())
        let randomBlue: CGFloat = CGFloat(drand48())
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
