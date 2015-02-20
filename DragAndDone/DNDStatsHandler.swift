//
//  DNDStatsHandler.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-18.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class DNDStatsHandler: NSObject {
    func docDir() -> NSString
    {
        let paths:NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray
        return paths.firstObject as NSString
    }
    
    func plistLocation() -> NSString
    {
        println(docDir().stringByAppendingPathComponent("stats.plist"))
        return docDir().stringByAppendingPathComponent("stats.plist")
    }
    
    func plist() -> NSMutableDictionary
    {
        if let dict = NSMutableDictionary(contentsOfFile: self.plistLocation())
        {
            return dict
        } else {
            let nuDict = NSMutableDictionary()
            nuDict.writeToFile(self.plistLocation(), atomically: true)
            return nuDict
        }
    }
}
