//
//  EditorEdge.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-11.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class EditorEdge: UIView {

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [UIColor.blackColor().CGColor, UIColor.lightGrayColor().CGColor], [0, 1])
        CGContextDrawLinearGradient(context, gradient, CGPointMake(rect.size.width, 1), CGPointMake(rect.size.width - 3, 1), 0)
    }

}
