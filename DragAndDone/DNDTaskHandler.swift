//
//  DNDTaskHandler.swift
//  DNDEditor
//
//  Created by Ricardo Gonzalez on 2015-02-03.
//  Copyright (c) 2015 FreakoSoft. All rights reserved.
//

import UIKit

class DNDTaskHandler: NSObject {
    let taskColors = ["wisteria", "belizeHole", "nephritis", "greenSea", "sunFlower", "carrot", "alizarin"]
   
    func createFolder(folderName: String)
    {
        let folder = NSMutableDictionary()
        if self.folders().count >= taskColors.count
        {
            folder.setObject("noColor", forKey: "color")
        } else {
        let color = taskColors[self.folders().count]
        folder.setObject(color, forKey: "color")
        }
        let plist = self.plist()
        plist.setValue(folder, forKey: folderName)
        plist.writeToFile(plistLocation(), atomically: true)
    }
    
    func addTaskInCurrentFolder(task: DNDTask)
    {
        
    }
    
    func addTask(task: DNDTask, folder: String)
    {
//        println("ADD TASK \(task.name!)")
        let plist = self.plist()
        
        var foldersDictionary = NSMutableDictionary()
        var foldersArray = NSMutableArray()
        if plist[folder] != nil
        {
        foldersDictionary = plist[folder] as NSMutableDictionary
            if let tasks = foldersDictionary["tasks"] as? NSMutableArray
            {
        foldersArray.addObjectsFromArray(tasks)
            }
        }
        
        let taskDict = NSMutableDictionary()
        taskDict.setValue(task.name!, forKey: "Name")
        taskDict.setValue(task.imageName!, forKey: "Imagename")
//        taskDict.setValue(task.doneImageName, forKey: "Doneimagename")
        foldersArray.addObject(taskDict)
        foldersDictionary.setObject(foldersArray, forKey: "tasks")
        plist.setValue(foldersDictionary, forKey: folder)
        plist.writeToFile(plistLocation(), atomically: true)
    }
    
    func docDir() -> NSString
    {
        let paths:NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as NSArray
        return paths.firstObject as NSString
    }
    
    func plistLocation() -> NSString
    {
        println(docDir().stringByAppendingPathComponent("tasks.plist"))
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
        if let tasks = (self.plist()[folder] as NSDictionary)["tasks"] as? NSArray
        {
            return tasks
        }
        return NSArray()
    }
    
    func moveTaskFromIndex(fromIndex:Int, toIndex:Int, inFolder:String)
    {
        var plist = self.plist()
        var foldersDict = plist[inFolder] as NSMutableDictionary
        var tasks = self.tasksInFolder(inFolder) as Array
        tasks.insert(tasks.removeAtIndex(fromIndex), atIndex: toIndex)
        foldersDict.setObject(tasks, forKey: "tasks")
        plist.setObject(foldersDict, forKey: inFolder)
        plist.writeToFile(self.plistLocation(), atomically: true)
    }
    
    func colorForFolder(folder: String) -> UIColor
    {
        var plist = self.plist()
        var foldersDict = plist[folder] as NSDictionary
        let colorString = foldersDict["color"] as String
        return UIColor.colorFromString(colorString)
    }
    
}
