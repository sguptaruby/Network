//
//  UIViewExtensions.swift
//  UCash
//
//  Created by Sagar.Gupta on 05/06/17.
//  Copyright © 2016 Hiteshi Infotech. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIView {

    /// X Origin of UIView
    var xOrigin: CGFloat {
        get {
            return frame.origin.x
        }
        set(newX) {
            frame.origin.x = newX
        }
    }

    /// Y Origin of UIView
    var yOrigin: CGFloat {
        get {
            return frame.origin.y
        }
        set(newY) {
            frame.origin.y = newY
        }
    }

    /// New height of the UIView
    var heightValue: CGFloat {
        get {
            return self.frame.size.height
        }
        set(newHeight) {
            frame.size.height = newHeight
        }
    }

    /// New Width of the UIView
    var widthValue: CGFloat {
        get {
            return self.frame.size.width
        }
        set(newWidth) {
            frame.size.width = newWidth
        }
    }

    ///  Make a UIView circular. Width and height of the UIView must be same otherwise resultant view will be oval not a circle.
    @discardableResult func makeCircular() -> UIView {
        self.layer.cornerRadius = min(heightValue, widthValue) / 2.0
        self.clipsToBounds = true
        return self
    }

    /// Shows horizontal border by adding a sublayer at specified position on UIView.
    ///
    /// - Parameters:
    ///   - borderColor: Color to set for the border. If ignored White is used by default
    ///   - yPosition: Y Axis position where the border will be shown.
    ///   - borderHeight: Height of the border.
    @discardableResult func horizontalBorder(borderColor: UIColor = UIColor.white, yPosition: CGFloat = 0, borderHeight: CGFloat = 1.0) -> UIView {
        let lowerBorder = CALayer()
        lowerBorder.backgroundColor = borderColor.cgColor
        lowerBorder.frame = CGRect(x: 0, y: yPosition, width: frame.width, height: borderHeight)
        layer.addSublayer(lowerBorder)
        clipsToBounds = true
        return self
    }

    /// Shows vertical border by adding a sublayer at specified position on UIView.
    ///
    /// - Parameters:
    ///   - borderColor: Color to set for the border. If ignored White is used by default
    ///   - xPosition: X Axis position where the border will be shown.
    ///   - borderWidth: Width of the border
    @discardableResult func verticalBorder(borderColor: UIColor = UIColor.white, xPosition: CGFloat = 0, borderWidth: CGFloat = 1.0) -> UIView {
        let lowerBorder = CALayer()
        lowerBorder.backgroundColor = borderColor.cgColor
        lowerBorder.frame = CGRect(x: xPosition, y: 0, width: frame.width, height: borderWidth)
        layer.addSublayer(lowerBorder)
        return self
    }

    /// Shows dashed border around the view.
    func addDashedBorder() {
        let color = UIColor.red.cgColor

        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [6, 3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

        self.layer.addSublayer(shapeLayer)
    }

    /// Instantiate a view from xib.
    ///
    /// - Returns: Instantiatd view from XIB
    class func instanceFromNib() -> UIView {
        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

    /// Shows Imaginamos progress view
    internal func showHUD() {
        MBProgressHUD.showAdded(to: self, animated: true)
    }

    /// Hides Imaginamos progress view
    internal func hideHUD() {
        MBProgressHUD.hide(for: self, animated: false)
    }

    /// Capture screenshot of a view and return as an instance of UIImage.
    ///
    /// - Returns: screenshot of the view
    internal func captureSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        // old style [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// show filter view
    internal func showFilterView() {
        UIView.animate(withDuration: 0.3,
                       delay: 0.3,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        }, completion: { (finished) -> Void in
            // ....
        })
    }
    
    /// hide filter view
    internal func hideFilterView() {
        UIView.animate(withDuration: 0.3,
                       delay: 0.3,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: { () -> Void in
                        self.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: self.frame.height)
        }, completion: { (finished) -> Void in
            // ....
        })

    }
    
    /// show view shadow
    internal func showShadow() {
        self.layer.shadowColor =  UIColor(red: 80.0/255.0, green: 102.0/255.0, blue: 138.0/255.0, alpha: 0.6).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}

/// View with Dashed border
class UIViewWithDashedLineBorder: UIView {
    override func draw(_ rect: CGRect) {

        let path = UIBezierPath(roundedRect: rect, cornerRadius: 0)

        UIColor.white.setFill()
        path.fill()

        UIColor.black.setStroke()
        path.lineWidth = 2

        let dashPattern: [CGFloat] = [10, 4]
        path.setLineDash(dashPattern, count: 2, phase: 0)
        path.stroke()
    }
}
