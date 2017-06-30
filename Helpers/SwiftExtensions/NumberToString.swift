//
//  NumberToString.swift
//  UCash
//
//  Created by Sagar.Gupta on 05/06/17.
//  Copyright © 2016 Hiteshi Infotech. All rights reserved.
//

import Foundation

fileprivate func currencyFormatter() -> NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = NumberFormatter.Style.currency
    formatter.locale = Locale(identifier: "es_CO")
    formatter.currencyCode = "COP"

    return formatter
}

extension Int {

    /// Integer value in Stirng format, i.g. "1"
    internal var toString: String {
        return String.init(describing: self)
    }

    /// Integer value in with $ currency sign
    internal var asPrice: String {
        let price = NSNumber(value: self)
        let formatter = currencyFormatter()
        return "\(formatter.string(from: price) ?? "")".replacingOccurrences(of: " ", with: "")
    }
}

extension Int8 {
    /// Integer value in Stirng format, i.g. "1"
    internal var toString: String {
        return String.init(describing: self)
    }

    /// Integer value in with $ currency sign
    internal var asPrice: String {
        let price = NSNumber(value: self)
        let formatter = currencyFormatter()
        return "\(formatter.string(from: price) ?? "")".replacingOccurrences(of: " ", with: "")
    }
}

extension Int16 {
    /// Integer value in Stirng format, i.g. "1"
    internal var toString: String {
        return String.init(describing: self)
    }

    /// Integer value in with $ currency sign
    internal var asPrice: String {
        let price = NSNumber(value: self)
        let formatter = currencyFormatter()
        return "\(formatter.string(from: price) ?? "")".replacingOccurrences(of: " ", with: "").replacingOccurrences(of: " ", with: "")
    }
}

extension Int32 {
    /// Integer value in Stirng format, i.g. "1"
    internal var toString: String {
        return String.init(describing: self)
    }

    /// Integer value in with $ currency sign
    internal var asPrice: String {
        let price = NSNumber(value: self)
        let formatter = currencyFormatter()
        return "\(formatter.string(from: price) ?? "")".replacingOccurrences(of: " ", with: "")
    }
}

extension Int64 {
    /// Integer value in Stirng format, i.g. "1"
    internal var toString: String {
        return String.init(describing: self)
    }

    /// Integer value in with $ currency sign
    internal var asPrice: String {
        let price = NSNumber(value: self)
        let formatter = currencyFormatter()
        return "\(formatter.string(from: price) ?? "")".replacingOccurrences(of: " ", with: "")
    }
}

extension UInt {

    /// UInteger value in Stirng format, i.g. "1"
    internal var toString: String {
        return String.init(describing: self)
    }

    /// Integer value in with $ currency sign
    internal var asPrice: String {
        let price = NSNumber(value: self)
        let formatter = currencyFormatter()
        return "\(formatter.string(from: price) ?? "")".replacingOccurrences(of: " ", with: "")
    }
}

extension UInt8 {
    /// UInteger value in Stirng format, i.g. "1"
    internal var toString: String {
        return String.init(describing: self)
    }

    /// Integer value in with $ currency sign
    internal var asPrice: String {
        let price = NSNumber(value: self)
        let formatter = currencyFormatter()
        return "\(formatter.string(from: price) ?? "")".replacingOccurrences(of: " ", with: "")
    }
}

extension UInt16 {
    /// UInteger value in Stirng format, i.g. "1"
    internal var toString: String {
        return String.init(describing: self)
    }

    /// Integer value in with $ currency sign
    internal var asPrice: String {
        let price = NSNumber(value: self)
        let formatter = currencyFormatter()
        return "\(formatter.string(from: price) ?? "")".replacingOccurrences(of: " ", with: "")
    }
}

extension UInt32 {
    /// UInteger value in Stirng format, i.g. "1"
    internal var toString: String {
        return String.init(describing: self)
    }

    /// Integer value in with $ currency sign
    internal var asPrice: String {
        let price = NSNumber(value: self)
        let formatter = currencyFormatter()
        return "\(formatter.string(from: price) ?? "")".replacingOccurrences(of: " ", with: "")
    }
}

extension UInt64 {
    /// UInteger value in Stirng format, i.g. "1"
    internal var toString: String {
        return String.init(describing: self)
    }
}

extension Double {
    /// Double value in Stirng format, i.g. "1.568"
    internal var toString: String {
        return String.init(describing: self)
    }

    /// Integer value in with $ currency sign
    internal var asPrice: String {
        let price = NSNumber(value: self)
        let formatter = currencyFormatter()
        return "\(formatter.string(from: price) ?? "")".replacingOccurrences(of: " ", with: "")
    }

    internal var asCountDownTimerWithMinute: String {
        let minutes = Int.init(self) / 60 % 60
        let seconds = Int.init(self) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}

extension Float {
    /// Float value in Stirng format, i.g. "1.568"
    internal var toString: String {
        return String.init(describing: self)
    }

    /// Integer value in with $ currency sign
    internal var asPrice: String {
        let price = NSNumber(value: self)
        let formatter = currencyFormatter()
        return "\(formatter.string(from: price) ?? "")".replacingOccurrences(of: " ", with: "")
    }
}

extension CGFloat {
    /// CGFloat value in Stirng format, i.g. "1.568"
    internal var toString: String {
        return String.init(describing: self)
    }
}
