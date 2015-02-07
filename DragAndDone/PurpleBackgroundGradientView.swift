//
//  PurpleBackgroundGradientView.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-06.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class PurpleBackgroundGradientView: UIView {

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let gradientColor = UIColor(red: 0.557, green: 0.267, blue: 0.678, alpha: 1.000)
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradientColor.CGColor, UIColor.whiteColor().CGColor], [0, 1])
        CGContextDrawLinearGradient(context, gradient, CGPointMake(rect.size.width / 2, 64), CGPointMake(rect.size.width / 2, 74), 0)
    }


}
