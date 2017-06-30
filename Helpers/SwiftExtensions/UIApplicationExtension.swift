//
//  UIApplicationExtension.swift
//  UCash
//
//  Created by Sagar.Gupta on 05/06/17.
//  Copyright © 2016 Hiteshi Infotech. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {

    /// Version number of the application
    ///
    /// - Returns: Version number as string
    class func versionNumber() -> String {
        let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        return appVersionString
    }

    /// Root View controller of the UIWindow
    ///
    /// - Returns: RootView controller object
    func rootViewController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }

    /// Print all the fonts loaded in console. Useful for the dubugging purpose.
    class func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
}
