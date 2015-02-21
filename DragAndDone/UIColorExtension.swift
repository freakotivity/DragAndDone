//
//  UIColorExtension.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-08.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

extension UIColor {
    class func freakoRed() -> UIColor {
        return FreakoColors.freakoRed
    }
    class func freakoOrange() -> UIColor {
        return FreakoColors.freakoOrange
    }
    class func freakoYellow() -> UIColor {
        return FreakoColors.freakoYellow
    }
    class func freakoGreen() -> UIColor {
        return FreakoColors.freakoGreen
    }
    class func freakoBlue() -> UIColor {
        return FreakoColors.freakoBlue
    }
    class func freakoDarkBlue() -> UIColor {
        return FreakoColors.freakoDarkBlue
    }
    class func freakoViolet() -> UIColor {
        return FreakoColors.freakoViolet
    }
    class func wisteria() -> UIColor {
        return UIColor(red: 0x8E/255.0, green: 0x44/255.0, blue: 0xAD/255.0, alpha: 1.0)
    }
    class func belizeHole() -> UIColor {
        return UIColor(red: 0x29/255.0, green: 0x80/255.0, blue: 0xB9/255.0, alpha: 1.0)
    }
    class func nephritis() -> UIColor {
        return UIColor(red: 0x27/255.0, green: 0xAE/255.0, blue: 0x60/255.0, alpha: 1.0)
    }
    class func greenSea() -> UIColor {
        return UIColor(red: 0x16/255.0, green: 0xA0/255.0, blue: 0x85/255.0, alpha: 1.0)
    }
    class func sunFlower() -> UIColor {
        return UIColor(red: 0xF1/255.0, green: 0xC4/255.0, blue: 0x0F/255.0, alpha: 1.0)
    }
    class func carrot() -> UIColor {
        return UIColor(red: 0xE6/255.0, green: 0x7E/255.0, blue: 0x22/255.0, alpha: 1.0)
    }
    class func alizarin() -> UIColor {
        return UIColor(red: 0xE7/255.0, green: 0x4C/255.0, blue: 0x3C/255.0, alpha: 1.0)
    }
    class func colorFromString(colorString: String) -> UIColor
    {
        switch colorString
        {
        case "freakoRed":
            return UIColor.freakoRed()
        case "freakoOrange":
            return UIColor.freakoOrange()
        case "freakoYellow":
            return UIColor.freakoYellow()
        case "freakoGreen":
            return UIColor.freakoGreen()
        case "freakoBlue":
            return UIColor.freakoBlue()
        case "freakoDarkBlue":
            return UIColor.freakoDarkBlue()
        case "freakoViolet":
            return UIColor.freakoViolet()
        case "wisteria":
            return UIColor.wisteria()
        case "belizeHole":
            return UIColor.belizeHole()
        case "nephritis":
            return UIColor.nephritis()
        case "greenSea":
            return UIColor.greenSea()
        case "sunFlower":
            return UIColor.sunFlower()
        case "carrot":
            return UIColor.carrot()
        case "alizarin":
            return UIColor.alizarin()
        default:
            return UIColor.blackColor()
        }
    }
}
