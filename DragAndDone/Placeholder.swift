//
//  Placeholder.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-01.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class Placeholder: UIView {
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let circleRadius = (min(rect.size.height / 2, rect.size.width / 2)) * 0.8
        
        var startAngle:CGFloat = -CGFloat(M_PI / 2)
        let segmentAngle:CGFloat = 2 * CGFloat(M_PI) / 60
        
        CGContextSetLineWidth(context, min(rect.size.width / 30, rect.size.height / 30))
        
        UIColor(red: 142/255.0, green: 68/255.0, blue: 173/255.0, alpha: 1.0).setFill()
        CGContextFillEllipseInRect(context, rect)
//        for i in 0..<30
//        {
//            UIColor.grayColor().setStroke()
//            
//            CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, circleRadius, startAngle, startAngle + segmentAngle, 0)
//            
//            CGContextStrokePath(context)
//            startAngle += segmentAngle
//            UIColor.clearColor().setStroke()
//            CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, min(rect.size.width / 3, rect.size.height / 3), startAngle, startAngle + 0.1, 0)
//            startAngle += segmentAngle
//            CGContextStrokePath(context)
//        }
        UIColor.whiteColor().setStroke()
        CGContextMoveToPoint(context, rect.size.width / 2, rect.size.height / 3)
        CGContextAddLineToPoint(context, rect.size.width / 2, rect.size.height * 2 / 3)
        CGContextStrokePath(context)
        CGContextMoveToPoint(context, rect.size.width / 3, rect.size.height / 2)
        CGContextAddLineToPoint(context, rect.size.width * 2 / 3, rect.size.height / 2)
        CGContextStrokePath(context)
        
    }
}
