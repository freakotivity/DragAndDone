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
    var image:UIImage?
    var task:DNDTask?
    
    
    override func drawRect(rect: CGRect) {
        println("drawrect uiimage:\(image)")
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
