//
//  NumberToString.swift
//  UCash
//
//  Created by Sagar.Gupta on 05/06/17.
//  Copyright © 2016 Hiteshi Infotech. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    /// Shows image from remote URL and resizes it as per the Image View size
    ///
    /// - Parameter remoteURL: URL of the image
    func showImage(fromURL remoteURL: URL?) {

    }

    /// Renders image with given color
    ///
    /// - Parameter colorToSet: Color to use for rendering image.
    internal func renderWithColor(_ colorToSet: UIColor?) {
        image = image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        tintColor = colorToSet
    }
}
