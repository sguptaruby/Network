//
//  StringExtension.swift
//  UCash
//
//  Created by Sagar.Gupta on 05/06/17.
//  Copyright © 2016 Hiteshi Infotech. All rights reserved.
//

import Foundation

extension NSString {

    /// Localized string for the current text.
    var localizedStringValue: String {
        return NSLocalizedString(self as String, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

    /// Makes a string Strikethrough e.g. "S̶t̶r̶i̶k̶e̶t̶h̶r̶o̶u̶g̶h̶"
    ///
    /// - Returns: Stikethoughed object
    internal func makeStrikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self as String)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.strikeThroughColor(), range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

extension String {

    /// Makes a string Strikethrough e.g. "S̶t̶r̶i̶k̶e̶t̶h̶r̶o̶u̶g̶h̶"
    ///
    /// - Returns: Stikethoughed object
    internal func makeStrikeThrough() -> NSAttributedString {
        return (self as NSString).makeStrikeThrough()
    }

    /// Checks if string is can be used as email address or not.
    ///
    /// - Returns: true if valid email otherwise false
    func isValidEmail() -> Bool {
        let trimmedValue = trimmedString()

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: trimmedValue)
    }

    /// Checks if string is a valid first name
    ///
    /// - Returns: true if vaild first name otherwise false
    func isValidFirstName() -> Bool {
        let trimmedValue = trimmedString()

        let emailRegEx = "^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$"

        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        let result = emailTest.evaluate(with: trimmedValue)

        return result
    }

    /// Checks if string fullfills the requirement of a valid password.
    ///
    /// - Returns: true if can be used as password otherwise false
    func isValidPassword() -> Bool {
        let trimmedValue = trimmedString()
        if trimmedValue.characters.count < 6 {
            return false
        }

        return true
    }

    /// Checks a valid mobile number
    ///
    /// - Returns: true if mobile number is valid otherwise false
    func isValidMobileNumber() -> Bool {
        if characters.count < 10 {
            return false
        }

        return true
    }
    
    func splitString() -> (data1:String?,data2:String?) {
        let dateTime = self.components(separatedBy: " ")
        let data1    = dateTime[0] as String
        let data2 = dateTime[1] as String
        return(data1 ,data2 )
    }

    /// Removes unnecessary whites spaces from a string.
    ///
    /// - Returns: trimmed string.
    func trimmedString() -> String {
        let trimmedString = trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        return trimmedString
    }

    /// Localized string for the current text.
    var localizedStringValue: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

    /// Boolean vale for the string. e.g. See -[NSStirng boolValue] documentation for more details
    var boolValue: Bool {
        return NSString(string: self).boolValue
    }

    /// Double vale for the string. e.g. See -[NSStirng doubleValue] documentation for more details
    var doubleValue: Double {
        return NSString(string: self).doubleValue
    }

    /// Float vale for the string. e.g. See -[NSStirng floatValue] documentation for more details
    var floatValue: Float {
        return NSString(string: self).floatValue
    }

    /// Integer vale for the string. e.g. See -[NSStirng integerValue] documentation for more details
    var integerValue: Int {
        return NSString(string: self).integerValue
    }

    /// Int64 vale for the string. e.g. See -[NSStirng longValue] documentation for more details
    var longValue: Int64 {
        return NSString(string: self).longLongValue
    }
}
