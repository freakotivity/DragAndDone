//
//  ADDProgressCircle.swift
//  ProgressCircle
//
//  Created by Ricardo Gonzalez on 2015-01-29.
//  Copyright (c) 2015 FreakoSoft. All rights reserved.
//

import UIKit

@IBDesignable
class ADDProgressCircle: UIView {
    @IBInspectable var numberOfSegments:Int = 3
        {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var completedSegments:Int = 2
        {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var incompletedSegmentColor:UIColor = UIColor.grayColor()
        {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var completedSegmentColor:UIColor = UIColor.blackColor()
        {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var shadow:Bool = false
        {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var shadowXOffset:CGFloat = 0.0
        {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var shadowYOffset:CGFloat = 0.0
        {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var shadowBlur:CGFloat = 0.0
        {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    
    
    let wholeCircle:CGFloat = CGFloat(M_PI * 2)

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        var startAngle:CGFloat = -CGFloat(M_PI / 2)
        let segmentAngle:CGFloat = (wholeCircle / CGFloat(numberOfSegments)) - 0.1
        
        CGContextSetLineWidth(context, min(rect.size.width / 20, rect.size.height / 20))
        
        for i in 0..<numberOfSegments
        {
            println("SEGMENT \(i)")

            if i < completedSegments
            {
                completedSegmentColor.setStroke()
            } else {
                incompletedSegmentColor.setStroke()
            }
            
            CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, min(rect.size.width / 3, rect.size.height / 3), startAngle, startAngle + segmentAngle, 0)
            
            if shadow
            {
            CGContextSetShadow(context, CGSizeMake(shadowXOffset, shadowYOffset), shadowBlur)
            }

            CGContextStrokePath(context)
            startAngle += segmentAngle
            UIColor.clearColor().setStroke()
            CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, min(rect.size.width / 3, rect.size.height / 3), startAngle, startAngle + 0.1, 0)
            startAngle += 0.1
            CGContextStrokePath(context)
        }
        
    }
}
