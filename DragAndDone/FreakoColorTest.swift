//
//  FreakoColorTest.swift
//  DragAndDone
//
//  Created by Gabriel Kroll on 21/02/15.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import Foundation

import UIKit

@IBDesignable
class FreakoColorTest : UIView {
    
    override func drawRect(rect: CGRect) {
        FreakoColors.drawDarkModerateBlue()
        FreakoColors.drawDarkCyanLimeGreen()
        FreakoColors.drawModerateVieolet()
        FreakoColors.drawStrongBlue()
        FreakoColors.drawVividOrange()
        FreakoColors.drawVividRed()
        FreakoColors.drawVividYellow()
    }
}

