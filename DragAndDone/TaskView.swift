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
    var textLabel:UILabel!
    var nameLabel:UILabel!
    var image:UIImage?
    var task:DNDTask?
    var taskColor:UIColor!
    
    override func drawRect(rect: CGRect) {
        println("drawrect uiimage:\(image)")
        let lineWidth:CGFloat = min(rect.size.width, rect.size.height)/10
        let square = CGRectMake(0, 0, min(rect.size.width, rect.size.height), min(rect.size.width, rect.size.height))
//        UIColor.blackColor().setStroke()
        self.taskColor.setFill()
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, lineWidth)
        CGContextAddEllipseInRect(context, CGRectInset(square, lineWidth, lineWidth))
        CGContextClip(context)
        
        CGContextAddEllipseInRect(context, CGRectInset(square, lineWidth, lineWidth))
//        CGContextStrokePath(context)
        CGContextFillPath(context)
//        if image != nil
//        {
            image?.drawInRect(rect)
//        }
    }
    
//    func convertImageToGrayScale(image: UIImage) -> UIImage {
//
//    // Create image rectangle with current image width/height
//    let imageRect = CGRectMake(0, 0, image.size.width, image.size.height)
//
//    // Grayscale color space
//    let colorSpace = CGColorSpaceCreateDeviceGray()
//
//    // Create bitmap content with current image size and grayscale colorspace
//    let context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone)
//
//    // Draw image into current context, with specified rectangle
//    // using previously defined context (with grayscale colorspace)
//    CGContextDrawImage(context, imageRect, image.CGImage)
//
//    // Create bitmap image info from pixel data in current context
//    let imageRef = CGBitmapContextCreateImage(context)
//
//    // Create a new UIImage object
//        let newImage : UIImage = imageWithCGImage(imageRef)
//
//    // Release colorspace, context and bitmap information
//    CGColorSpaceRelease(colorSpace);
//    CGContextRelease(context);
//    CFRelease(imageRef);
//
//    // Return the new grayscale image
//    return newImage
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        println("TASK VIEW INIT WITH FRAME")
        self.clipsToBounds = false
        self.textLabel = UILabel(frame: frame)
        self.textLabel.font = UIFont(name: "HelveticaNeue-Light", size: 25.0)
        self.textLabel.textColor = UIColor.whiteColor()
        self.textLabel.backgroundColor = UIColor.clearColor()
        //        self.textLabel.text = "YEAH"
        self.textLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(self.textLabel)
        
//        self.nameLabel = UILabel(frame: CGRectMake(bounds.origin.x, bounds.size.height * 0.8, bounds.size.width, bounds.size.height))
        self.nameLabel = UILabel(frame: CGRectZero)
        self.nameLabel.font = UIFont(name: "HelveticaNeue-Light", size: 19.0)
        self.nameLabel.textColor = UIColor.blackColor()
        self.nameLabel.backgroundColor = UIColor.clearColor()
        //        self.textLabel.text = "YEAH"
        self.nameLabel.textAlignment = NSTextAlignment.Center
        self.nameLabel.text = ""
        self.addSubview(self.nameLabel)
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    func convertImageToGrayScale()
    {
        println("DO SOME AWESOME STUFF TO THE IMAGE SO IT APPEARS BLACK N WHITE!!")
    }

    func toggleName()
    {
        println("SHOW TASK NAME")
        if self.nameLabel.text == ""
        {
        self.nameLabel.text = self.task?.name
        self.nameLabel.sizeToFit()
        self.nameLabel.center.x = self.bounds.size.width / 2
        self.nameLabel.center.y = self.bounds.size.height - (self.nameLabel.bounds.size.height / 1)
        } else {
            self.nameLabel.text = ""
        }
    }
    
    func hideName()
    {
        self.nameLabel.text = ""
    }
}
