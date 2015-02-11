//
//  DNDTaskHandler.swift
//  DNDEditor
//
//  Created by Ricardo Gonzalez on 2015-02-03.
//  Copyright (c) 2015 FreakoSoft. All rights reserved.
//

import UIKit

class DNDTaskHandler: NSObject {
   
    func createFolder(folderName: String)
    {
        let plist = self.plist()
        plist.setValue(NSMutableArray(), forKey: folderName)
        plist.writeToFile(plistLocation(), atomically: true)
    }
    
    func addTask(task: DNDTask, folder: String)
    {
//        println("ADD TASK \(task.name!)")
        let plist = self.plist()
        
        var foldersArray = NSMutableArray()
        if plist[folder] != nil
        {
        foldersArray.addObjectsFromArray(plist[folder] as NSMutableArray)
        }
        
        let taskDict = NSMutableDictionary()
        taskDict.setValue(task.name!, forKey: "Name")
        taskDict.setValue(task.imageName!, forKey: "Imagename")
//        taskDict.setValue(task.doneImageName, forKey: "Doneimagename")
        foldersArray.addObject(taskDict)
        plist.setValue(foldersArray, forKey: folder)
        plist.writeToFile(plistLocation(), atomically: true)
    }
    
    func docDir() -> NSString
    {
        let paths:NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray
        return paths.firstObject as NSString
    }
    
    func plistLocation() -> NSString
    {
//        println(docDir().stringByAppendingPathComponent("tasks.plist"))
        return docDir().stringByAppendingPathComponent("tasks.plist")
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
    
    func folders() ->Array<String>
    {
        let plist = self.plist()
        
        return plist.allKeys as Array<String>
    }
    
    func tasksInFolder(folder:String) ->NSArray
    {
        return self.plist()[folder] as NSArray
    }
    
    func moveTaskFromIndex(fromIndex:Int, toIndex:Int, inFolder:String)
    {
        var plist = self.plist()
        var tasks = self.tasksInFolder(inFolder) as Array
        tasks.insert(tasks.removeAtIndex(fromIndex), atIndex: toIndex)
        plist.setObject(tasks, forKey: inFolder)
        plist.writeToFile(self.plistLocation(), atomically: true)
    }
}
