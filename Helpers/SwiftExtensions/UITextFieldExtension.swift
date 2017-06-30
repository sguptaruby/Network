//
//  UITextFieldExtension.swift
//  UCash
//
//  Created by Sagar.Gupta on 05/06/17.
//  Copyright © 2016 Hiteshi Infotech. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {

    /// Sets placehoder text color
    ///
    /// - Parameter placeHoderTextColor: placeHoderTextColor color to set for the placehoder text.
    func setPlaceHolderTextColor(placeHoderTextColor: UIColor) {
        let mutable = NSMutableAttributedString(string: placeholder!)
        let range = NSRange.init(location: 0, length: placeholder!.characters.count)
        mutable.addAttribute(NSForegroundColorAttributeName, value: placeHoderTextColor, range: range)
        attributedPlaceholder = mutable
    }

    /// Adds a done button on textfield to hide the keyboard. Useful when showing number pad.
    internal func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resignFirstResponder))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        inputAccessoryView = keyboardToolbar
    }

    internal func addTextFieldtintcolor() {
        tintColor = UIColor.white
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
}
