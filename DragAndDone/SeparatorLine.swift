//
//  SeparatorLine.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-20.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class SeparatorLine: UIView {

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        //        let oneColor = UIColor(white: 0.9, alpha: 1.0)
        //        let otherColor = UIColor(white: 0.95, alpha: 1.0)
//        let otherColor = UIColor(red: 0xFA / 255.0, green: 0xFA / 255.0, blue: 0xFA / 255.0, alpha: 1.0)
//        let oneColor = UIColor(red: 0xF7 / 255.0, green: 0xF7 / 255.0, blue: 0xF7 / 255.0, alpha: 1.0)
        //        let oneColor = UIColor.greenSea()
        //        let otherColor = UIColor.nephritis()
        //        let otherColor = UIColor(white: 0.95, alpha: 1.0)
//        let oneColor = UIColor.lightGrayColor()
//        let otherColor = UIColor.darkGrayColor()
//        
//        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [UIColor.lightGrayColor().CGColor, UIColor.darkGrayColor().CGColor, UIColor.lightGrayColor().CGColor], [0, 0.25, 0.5, 0.75, 1])
//
////        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [oneColor.CGColor, otherColor.CGColor, oneColor.CGColor], [0, 1])
//        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, rect.size.height), 0)
        UIColor.lightGrayColor().setFill()
        CGContextFillRect(context, rect)
    }

}
