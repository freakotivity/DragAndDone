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
        FreakoColors.drawFreakoBlueCircle()
        FreakoColors.drawFreakoDarkBlueCircle()
        FreakoColors.drawFreakoOrangeCircle()
        FreakoColors.drawFreakoYellowCircle()
        FreakoColors.drawFreakoRedCircle()
        FreakoColors.drawFreakoVioletCircle()
        FreakoColors.drawFreakoGreenCircle()
        FreakoColors.drawCeckInACircle()
    }
}

