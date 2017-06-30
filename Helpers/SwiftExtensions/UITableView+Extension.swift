//
//  UITableView+Extension.swift
//  UCash
//
//  Created by Sagar.Gupta on 05/06/17.
//  Copyright © 2016 Hiteshi Infotech. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {

    func addExtraScrollAtTop(_ value: CGFloat) {
        contentInset = UIEdgeInsetsMake(value, 0.0, 0.0, 0.0)
    }

    func addExtraScrollAtLeft(_ value: CGFloat) {
        contentInset = UIEdgeInsetsMake(0.0, value, 0.0, 0.0)
    }

    func addExtraScrollAtBottom(_ value: CGFloat) {
        contentInset = UIEdgeInsetsMake(0.0, 0.0, value, 0.0)
    }

    func addExtraScrollAtRight(_ value: CGFloat) {
        contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, value)
    }
}

extension UITableView {
    /// Register a XIB file with UITableView. XIB file name is used as reuse identifier so keep in mind to use the file name as reuse identifier.
    ///
    /// - Parameter nibName: Name of the XIB file
    internal func registerNib(_ nibName: String) {
        let cellNib = UINib.init(nibName: nibName, bundle: nil)
        register(cellNib, forCellReuseIdentifier: nibName)
    }

    /// Make a UItableViewCell height automatic based on the AutoLayouts used.
    ///
    /// - Parameter _estimatedHeight: Estimated height for the row
    internal func autoHeightWith(estimatedHeight _estimatedHeight: CGFloat) {
        rowHeight = UITableViewAutomaticDimension
        estimatedRowHeight = _estimatedHeight
    }

    /// Hides extra rows created by UIKit with no data to display.
    internal func hideEmptyAndExtraRows() {
        tableFooterView = UIView.init()
    }
}
