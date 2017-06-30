//
//  NSObjectExtension.swift
//  UCash
//
//  Created by Sagar.Gupta on 05/06/17.
//  Copyright © 2016 Hiteshi Infotech. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {

    /// Name of the class
    class var stringRepresentation: String {
        let name = String(describing: self)
        return name
    }

    /// Get the path of the document directory in app file system.
    ///
    /// - Returns: Full path of document directory.
    internal func documentDirectoryPath() -> String {
        let paths: Array = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir: String = paths[0]
        return docDir
    }

    /// Get the file path of the document directory in app file system.
    ///
    /// - Parameter fileName: Name of the file
    /// - Returns: Full path for the file in document directory
    internal func filePathInDocDirectory(fileName: String) -> String {
        let paths: Array = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir: String = paths[0]
        let filePath: String = docDir + "/" + fileName

        return filePath
    }

    internal func getDeviceTokenInDocDirectory() -> String {
        let location = filePathInDocDirectory(fileName: "DeviceToken")
        let deviceToken = try? String(contentsOfFile: location, encoding: String.Encoding.utf8)
        // print(deviceToken! as String)
        return deviceToken ?? UUID.init().uuidString
    }

    /// String from Date Object. Uses "yyyy-MM-dd" as default format.
    ///
    /// - Parameter date: Date Object
    /// - Returns: String generated from Date.
    internal func stringFromDateWithCommonFormat(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date as Date)
    }

    /// Date from string Object. Uses "yyyy-MM-dd" as default format.
    ///
    /// - Parameter dateAsString: Valid date as stirng
    /// - Returns: Date object
    internal func dateFromStringWithCommonFormat(dateAsString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = dateFormatter.date(from: dateAsString) else {
            fatalError("String is not in supported date format plese cross check")
        }

        return date
    }

    /// Padding for text field
    ///
    /// - Parameter size: Margin to use
    /// - Returns: View object to use for padding on UITextfield
    internal func padding(withSize size: CGSize) -> UIView {
        let viewFrame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let paddingView = UIView(frame: viewFrame)
        return paddingView
    }

    /// Number of minutes from given time.
    ///
    /// - Parameter timeStr: Time to be used for calculation
    /// - Returns: Minutes from the given time.
    internal func getMinutesFrom(timeStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        if let date = dateFormatter.date(from: timeStr) {
            dateFormatter.dateFormat = "mm"
            let timeMin = dateFormatter.string(from: date)
            return timeMin
        }
        return ""
    }

    static func delay(time: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            // your code here
            closure()
        }
    }
}
