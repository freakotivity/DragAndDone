//
//  FreakoColors.swift
//  Colors for Drag And Done
//
//  Created by Gabriel on 21/02/15.
//  Copyright (c) 2015 Freakotivity. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//



import UIKit

public class FreakoColors : NSObject {

    //// Cache

    private struct Cache {
        static var freakoGreen: UIColor = UIColor(red: 0.102, green: 0.706, blue: 0.267, alpha: 1.000)
        static var freakoDarkBlue: UIColor = UIColor(red: 0.227, green: 0.286, blue: 0.706, alpha: 1.000)
        static var freakoViolet: UIColor = UIColor(red: 0.533, green: 0.251, blue: 0.655, alpha: 1.000)
        static var freakoBlue: UIColor = UIColor(red: 0.169, green: 0.518, blue: 0.827, alpha: 1.000)
        static var freakoOrange: UIColor = UIColor(red: 0.925, green: 0.424, blue: 0.063, alpha: 1.000)
        static var freakoRed: UIColor = UIColor(red: 0.894, green: 0.122, blue: 0.086, alpha: 1.000)
        static var freakoYellow: UIColor = UIColor(red: 0.929, green: 0.839, blue: 0.067, alpha: 1.000)
        static var freakoLighterGreen: UIColor = FreakoColors.freakoGreen.colorWithHighlight(0.2)
        static var freakoDarkerGreen: UIColor = FreakoColors.freakoGreen.colorWithShadow(0.2)
        static var freakoLighterDarkBlue: UIColor = FreakoColors.freakoDarkBlue.colorWithHighlight(0.2)
        static var freakoLighterViolet: UIColor = FreakoColors.freakoViolet.colorWithHighlight(0.2)
        static var freakoLighterBlue: UIColor = FreakoColors.freakoBlue.colorWithHighlight(0.2)
        static var freakoLighterOrange: UIColor = FreakoColors.freakoOrange.colorWithHighlight(0.2)
        static var freakoLighterRed: UIColor = FreakoColors.freakoRed.colorWithHighlight(0.2)
        static var freakoLighterYellow: UIColor = FreakoColors.freakoYellow.colorWithHighlight(0.2)
        static var freakoDarkerDarkBlue: UIColor = FreakoColors.freakoDarkBlue.colorWithShadow(0.2)
        static var freakoDarkerViolet: UIColor = FreakoColors.freakoViolet.colorWithShadow(0.2)
        static var freakoDarkerBlue: UIColor = FreakoColors.freakoBlue.colorWithShadow(0.2)
        static var freakoDarkerRed: UIColor = FreakoColors.freakoRed.colorWithShadow(0.2)
        static var freakoDarkerYellow: UIColor = FreakoColors.freakoYellow.colorWithShadow(0.2)
        static var freakoDarkerOrange: UIColor = FreakoColors.freakoOrange.colorWithShadow(0.2)
        static var imageOfDarkCyanLimeGreen: UIImage?
        static var darkCyanLimeGreenTargets: [AnyObject]?
        static var imageOfDarkModerateBlue: UIImage?
        static var darkModerateBlueTargets: [AnyObject]?
        static var imageOfModerateVieolet: UIImage?
        static var moderateVieoletTargets: [AnyObject]?
        static var imageOfStrongBlue: UIImage?
        static var strongBlueTargets: [AnyObject]?
        static var imageOfVividOrange: UIImage?
        static var vividOrangeTargets: [AnyObject]?
        static var imageOfVividRed: UIImage?
        static var vividRedTargets: [AnyObject]?
        static var imageOfVividYellow: UIImage?
        static var vividYellowTargets: [AnyObject]?
    }

    //// Colors

    public class var freakoGreen: UIColor { return Cache.freakoGreen }
    public class var freakoDarkBlue: UIColor { return Cache.freakoDarkBlue }
    public class var freakoViolet: UIColor { return Cache.freakoViolet }
    public class var freakoBlue: UIColor { return Cache.freakoBlue }
    public class var freakoOrange: UIColor { return Cache.freakoOrange }
    public class var freakoRed: UIColor { return Cache.freakoRed }
    public class var freakoYellow: UIColor { return Cache.freakoYellow }
    public class var freakoLighterGreen: UIColor { return Cache.freakoLighterGreen }
    public class var freakoDarkerGreen: UIColor { return Cache.freakoDarkerGreen }
    public class var freakoLighterDarkBlue: UIColor { return Cache.freakoLighterDarkBlue }
    public class var freakoLighterViolet: UIColor { return Cache.freakoLighterViolet }
    public class var freakoLighterBlue: UIColor { return Cache.freakoLighterBlue }
    public class var freakoLighterOrange: UIColor { return Cache.freakoLighterOrange }
    public class var freakoLighterRed: UIColor { return Cache.freakoLighterRed }
    public class var freakoLighterYellow: UIColor { return Cache.freakoLighterYellow }
    public class var freakoDarkerDarkBlue: UIColor { return Cache.freakoDarkerDarkBlue }
    public class var freakoDarkerViolet: UIColor { return Cache.freakoDarkerViolet }
    public class var freakoDarkerBlue: UIColor { return Cache.freakoDarkerBlue }
    public class var freakoDarkerRed: UIColor { return Cache.freakoDarkerRed }
    public class var freakoDarkerYellow: UIColor { return Cache.freakoDarkerYellow }
    public class var freakoDarkerOrange: UIColor { return Cache.freakoDarkerOrange }

    //// Drawing Methods

    public class func drawDarkCyanLimeGreen() {

        //// Dark Cyan-Lime Green Disk Drawing
        let darkCyanLimeGreenDiskPath = UIBezierPath(roundedRect: CGRectMake(0, 0, 160, 160), cornerRadius: 80)
        FreakoColors.freakoGreen.setFill()
        darkCyanLimeGreenDiskPath.fill()
    }

    public class func drawDarkModerateBlue() {

        //// Dark Moderate Blue Disk Drawing
        let darkModerateBlueDiskPath = UIBezierPath(roundedRect: CGRectMake(0, 0, 160, 160), cornerRadius: 80)
        FreakoColors.freakoDarkBlue.setFill()
        darkModerateBlueDiskPath.fill()
    }

    public class func drawModerateVieolet() {

        //// Moderate Vieolet Disk Drawing
        let moderateVieoletDiskPath = UIBezierPath(roundedRect: CGRectMake(0, 0, 160, 160), cornerRadius: 80)
        FreakoColors.freakoViolet.setFill()
        moderateVieoletDiskPath.fill()
    }

    public class func drawStrongBlue() {

        //// Strong Blue Disk Drawing
        let strongBlueDiskPath = UIBezierPath(roundedRect: CGRectMake(0, 0, 160, 160), cornerRadius: 80)
        FreakoColors.freakoBlue.setFill()
        strongBlueDiskPath.fill()
    }

    public class func drawVividOrange() {

        //// Vivid Orange Disk Drawing
        let vividOrangeDiskPath = UIBezierPath(roundedRect: CGRectMake(0, 0, 160, 160), cornerRadius: 80)
        FreakoColors.freakoOrange.setFill()
        vividOrangeDiskPath.fill()
    }

    public class func drawVividRed() {

        //// Vivid Red Disk Drawing
        let vividRedDiskPath = UIBezierPath(roundedRect: CGRectMake(0, 0, 160, 160), cornerRadius: 80)
        FreakoColors.freakoRed.setFill()
        vividRedDiskPath.fill()
    }

    public class func drawVividYellow() {

        //// Vivid Yellow Disk Drawing
        let vividYellowDiskPath = UIBezierPath(roundedRect: CGRectMake(0, 0, 160, 160), cornerRadius: 80)
        FreakoColors.freakoYellow.setFill()
        vividYellowDiskPath.fill()
    }

    public class func drawDarkCyanLimeGreen2() {
        //// Color Declarations
        let color0 = UIColor(red: 0.102, green: 0.706, blue: 0.267, alpha: 1.000)

        //// Page-1
        //// Flat-UI-Color-Palette-by-@freakotivity
        //// Flat-UI-Color-Palette
        //// Dark-Cyan-Lime-Green 2
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRectMake(0, 0, 160, 134))
        color0.setFill()
        rectangle2Path.fill()
    }

    public class func drawDarkModerateBlue2() {
        //// Color Declarations
        let color = UIColor(red: 0.227, green: 0.286, blue: 0.706, alpha: 1.000)

        //// Page-1
        //// Flat-UI-Color-Palette-by-@freakotivity
        //// Flat-UI-Color-Palette
        //// Dark-Moderate-Blue 2
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRectMake(0, 0, 160, 134))
        color.setFill()
        rectangle2Path.fill()
    }

    public class func drawModerateVieolet2() {
        //// Color Declarations
        let color2 = UIColor(red: 0.533, green: 0.251, blue: 0.655, alpha: 1.000)

        //// Page-1
        //// Flat-UI-Color-Palette-by-@freakotivity
        //// Flat-UI-Color-Palette
        //// Moderate-Vieolet 2
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRectMake(0, 0, 160, 134))
        color2.setFill()
        rectangle2Path.fill()
    }

    public class func drawStrongBlue2() {
        //// Color Declarations
        let color3 = UIColor(red: 0.169, green: 0.518, blue: 0.827, alpha: 1.000)

        //// Page-1
        //// Flat-UI-Color-Palette-by-@freakotivity
        //// Flat-UI-Color-Palette
        //// Strong-Blue 2
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRectMake(0, 0, 160, 134))
        color3.setFill()
        rectangle2Path.fill()
    }

    public class func drawVividOrange2() {
        //// Color Declarations
        let color4 = UIColor(red: 0.925, green: 0.424, blue: 0.063, alpha: 1.000)

        //// Page-1
        //// Flat-UI-Color-Palette-by-@freakotivity
        //// Flat-UI-Color-Palette
        //// Vivid-Orange 2
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRectMake(0, 0, 160, 134))
        color4.setFill()
        rectangle2Path.fill()
    }

    public class func drawVividRed2() {
        //// Color Declarations
        let color5 = UIColor(red: 0.894, green: 0.122, blue: 0.086, alpha: 1.000)

        //// Page-1
        //// Flat-UI-Color-Palette-by-@freakotivity
        //// Flat-UI-Color-Palette
        //// Vivid-Red 2
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRectMake(0, 0, 160, 134))
        color5.setFill()
        rectangle2Path.fill()
    }

    public class func drawVividYellow2() {
        //// Color Declarations
        let color6 = UIColor(red: 0.929, green: 0.839, blue: 0.067, alpha: 1.000)

        //// Page-1
        //// Flat-UI-Color-Palette-by-@freakotivity
        //// Flat-UI-Color-Palette
        //// Vivid-Yellow 2
        //// Rectangle 2 Drawing
        let rectangle2Path = UIBezierPath(rect: CGRectMake(0, 0, 160, 134))
        color6.setFill()
        rectangle2Path.fill()
    }

    //// Generated Images

    public class var imageOfDarkCyanLimeGreen: UIImage {
        if Cache.imageOfDarkCyanLimeGreen != nil {
            return Cache.imageOfDarkCyanLimeGreen!
        }

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(160, 160), false, 0)
            FreakoColors.drawDarkCyanLimeGreen()

        Cache.imageOfDarkCyanLimeGreen = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfDarkCyanLimeGreen!
    }

    public class var imageOfDarkModerateBlue: UIImage {
        if Cache.imageOfDarkModerateBlue != nil {
            return Cache.imageOfDarkModerateBlue!
        }

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(160, 160), false, 0)
            FreakoColors.drawDarkModerateBlue()

        Cache.imageOfDarkModerateBlue = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfDarkModerateBlue!
    }

    public class var imageOfModerateVieolet: UIImage {
        if Cache.imageOfModerateVieolet != nil {
            return Cache.imageOfModerateVieolet!
        }

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(160, 160), false, 0)
            FreakoColors.drawModerateVieolet()

        Cache.imageOfModerateVieolet = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfModerateVieolet!
    }

    public class var imageOfStrongBlue: UIImage {
        if Cache.imageOfStrongBlue != nil {
            return Cache.imageOfStrongBlue!
        }

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(160, 160), false, 0)
            FreakoColors.drawStrongBlue()

        Cache.imageOfStrongBlue = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfStrongBlue!
    }

    public class var imageOfVividOrange: UIImage {
        if Cache.imageOfVividOrange != nil {
            return Cache.imageOfVividOrange!
        }

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(160, 160), false, 0)
            FreakoColors.drawVividOrange()

        Cache.imageOfVividOrange = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfVividOrange!
    }

    public class var imageOfVividRed: UIImage {
        if Cache.imageOfVividRed != nil {
            return Cache.imageOfVividRed!
        }

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(160, 160), false, 0)
            FreakoColors.drawVividRed()

        Cache.imageOfVividRed = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfVividRed!
    }

    public class var imageOfVividYellow: UIImage {
        if Cache.imageOfVividYellow != nil {
            return Cache.imageOfVividYellow!
        }

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(160, 160), false, 0)
            FreakoColors.drawVividYellow()

        Cache.imageOfVividYellow = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfVividYellow!
    }

    //// Customization Infrastructure

    @IBOutlet var darkCyanLimeGreenTargets: [AnyObject]! {
        get { return Cache.darkCyanLimeGreenTargets }
        set {
            Cache.darkCyanLimeGreenTargets = newValue
            for target: AnyObject in newValue {
                target.setImage(FreakoColors.imageOfDarkCyanLimeGreen)
            }
        }
    }

    @IBOutlet var darkModerateBlueTargets: [AnyObject]! {
        get { return Cache.darkModerateBlueTargets }
        set {
            Cache.darkModerateBlueTargets = newValue
            for target: AnyObject in newValue {
                target.setImage(FreakoColors.imageOfDarkModerateBlue)
            }
        }
    }

    @IBOutlet var moderateVieoletTargets: [AnyObject]! {
        get { return Cache.moderateVieoletTargets }
        set {
            Cache.moderateVieoletTargets = newValue
            for target: AnyObject in newValue {
                target.setImage(FreakoColors.imageOfModerateVieolet)
            }
        }
    }

    @IBOutlet var strongBlueTargets: [AnyObject]! {
        get { return Cache.strongBlueTargets }
        set {
            Cache.strongBlueTargets = newValue
            for target: AnyObject in newValue {
                target.setImage(FreakoColors.imageOfStrongBlue)
            }
        }
    }

    @IBOutlet var vividOrangeTargets: [AnyObject]! {
        get { return Cache.vividOrangeTargets }
        set {
            Cache.vividOrangeTargets = newValue
            for target: AnyObject in newValue {
                target.setImage(FreakoColors.imageOfVividOrange)
            }
        }
    }

    @IBOutlet var vividRedTargets: [AnyObject]! {
        get { return Cache.vividRedTargets }
        set {
            Cache.vividRedTargets = newValue
            for target: AnyObject in newValue {
                target.setImage(FreakoColors.imageOfVividRed)
            }
        }
    }

    @IBOutlet var vividYellowTargets: [AnyObject]! {
        get { return Cache.vividYellowTargets }
        set {
            Cache.vividYellowTargets = newValue
            for target: AnyObject in newValue {
                target.setImage(FreakoColors.imageOfVividYellow)
            }
        }
    }

}



extension UIColor {
    func colorWithHue(newHue: CGFloat) -> UIColor {
        var saturation: CGFloat = 1.0, brightness: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getHue(nil, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: newHue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    func colorWithSaturation(newSaturation: CGFloat) -> UIColor {
        var hue: CGFloat = 1.0, brightness: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getHue(&hue, saturation: nil, brightness: &brightness, alpha: &alpha)
        return UIColor(hue: hue, saturation: newSaturation, brightness: brightness, alpha: alpha)
    }
    func colorWithBrightness(newBrightness: CGFloat) -> UIColor {
        var hue: CGFloat = 1.0, saturation: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getHue(&hue, saturation: &saturation, brightness: nil, alpha: &alpha)
        return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
    }
    func colorWithAlpha(newAlpha: CGFloat) -> UIColor {
        var hue: CGFloat = 1.0, saturation: CGFloat = 1.0, brightness: CGFloat = 1.0
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: newAlpha)
    }
    func colorWithHighlight(highlight: CGFloat) -> UIColor {
        var red: CGFloat = 1.0, green: CGFloat = 1.0, blue: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * (1-highlight) + highlight, green: green * (1-highlight) + highlight, blue: blue * (1-highlight) + highlight, alpha: alpha * (1-highlight) + highlight)
    }
    func colorWithShadow(shadow: CGFloat) -> UIColor {
        var red: CGFloat = 1.0, green: CGFloat = 1.0, blue: CGFloat = 1.0, alpha: CGFloat = 1.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: red * (1-shadow), green: green * (1-shadow), blue: blue * (1-shadow), alpha: alpha * (1-shadow) + shadow)
    }
}

@objc protocol StyleKitSettableImage {
    func setImage(image: UIImage!)
}

@objc protocol StyleKitSettableSelectedImage {
    func setSelectedImage(image: UIImage!)
}
