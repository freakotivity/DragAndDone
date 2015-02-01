//
//  TaskView.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-01.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

@IBDesignable
class TaskView: UIView {
    var initialPosition:CGPoint!

    override func drawRect(rect: CGRect) {
        let lineWidth:CGFloat = 5.0
        let square = CGRectMake(0, 0, min(rect.size.width, rect.size.height), min(rect.size.width, rect.size.height))
        UIColor.blackColor().setStroke()
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, lineWidth)
        CGContextAddEllipseInRect(context, CGRectInset(square, lineWidth, lineWidth))
        CGContextStrokePath(context)
    }
}
