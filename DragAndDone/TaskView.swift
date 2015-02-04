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
    var donePosition:CGPoint!
    var done = false
    var initialIndex:Int!
    var doneIndex:Int!
    var textLabel:UILabel!
    var image:UIImage?

    override func drawRect(rect: CGRect) {
        println("drawrect")
        let lineWidth:CGFloat = 10.0
        let square = CGRectMake(0, 0, min(rect.size.width, rect.size.height), min(rect.size.width, rect.size.height))
        UIColor.blackColor().setStroke()
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, lineWidth)
        CGContextAddEllipseInRect(context, CGRectInset(square, lineWidth, lineWidth))
        CGContextClip(context)
        if image != nil
        {
            image!.drawInRect(rect)
        }

        CGContextAddEllipseInRect(context, CGRectInset(square, lineWidth, lineWidth))
        CGContextStrokePath(context)
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        println("TASK VIEW INIT WITH FRAME")
        self.textLabel = UILabel(frame: frame)
        self.textLabel.backgroundColor = UIColor.clearColor()
//        self.textLabel.text = "YEAH"
        self.textLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(self.textLabel)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    func convertImageToGrayScale()
    {
        println("DO SOME AWESOME STUFF TO THE IMAGE SO IT APPEARS BLACK N WHITE!!")
    }

}
