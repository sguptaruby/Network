//
//  UIColorExtension.swift
//  UCash
//
//  Created by Sagar.Gupta on 05/06/17.
//  Copyright © 2016 Hiteshi Infotech. All rights reserved.
//

import UIKit

extension UIColor {

    /// Common background color used in app
    class var appGreyish: UIColor {
        return UIColor(white: 249.0 / 255.0, alpha: 1.0)
    }

    /// Common blue color used in most places in app.
    ///
    /// - Returns: app blue color
    class func getAppTHEME() -> UIColor {
        return self.init(red: 65.0 / 255.0,
                         green: 143.0 / 255.0,
                         blue: 222.0 / 255.0, alpha: CGFloat(1.0))
    }

    /// Get the UIColor object from Hex string.
    ///
    /// - Parameters:
    ///   - hex6: Hexadecimal string e.g. FFFFF
    ///   - alpha: Trasnparency value between 0 to 1
    /// - Returns: Object of UIColor
    class func getColorFromHEXA(hex6: Int, alpha: Float) -> UIColor {
        return self.init(red: CGFloat((hex6 & 0xFF0000) >> 16) / 255.0,
                         green: CGFloat((hex6 & 0x00FF00) >> 8) / 255.0,
                         blue: CGFloat((hex6 & 0x0000FF) >> 0) / 255.0, alpha: CGFloat(alpha))
    }

    /// Color to use for strikthrough line.
    ///
    /// - Returns: UIColor instance
    class func strikeThroughColor() -> UIColor {
        return UIColor.init(red: 140.0 / 255.0, green: 140.0 / 255.0, blue: 140.0 / 255.0, alpha: 1.0)
    }

    class func getOfferRedColor() -> UIColor {
        return self.init(red: 208.0 / 255.0,
                         green: 0.0 / 255.0,
                         blue: 0.0 / 255.0, alpha: CGFloat(1.0))
    }

    /// Common background color for all screen in app.
    ///
    /// - Returns: UIColor instance
    class func viewBackGroundColor() -> UIColor {
        return UIColor.init(red: 249.0 / 255.0, green: 249.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0)
    }
}
