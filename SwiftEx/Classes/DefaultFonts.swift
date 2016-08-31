//
//  DefaultFonts.swift
//  smiity
//
//  Created by Diogo Grilo on 28/08/15.
//  Copyright © 2015 Diogo Grilo. All rights reserved.
//

import UIKit

public extension UILabel {

    var substituteFontName: String {
        get { return self.font.fontName }
        set {
            if self.font.fontName != newValue {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }

    public func setFontSize (size: CGFloat) {
        self.font = UIFont(name: self.font.fontName, size: size)
    }

    public func setFontIcon (fontName: String) {
        self.substituteFontName = fontName
    }

    public func setFontIconwhitName (name: String) {
        self.substituteFontName = name
    }
}
