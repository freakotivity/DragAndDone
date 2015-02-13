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
        if let folder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as? String
        {
            self.addTask(task, folder: folder)
        }
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
        taskDict.setValue(task.done, forKey: "Done")
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
    
    func tasksInFolder(folder:String) ->Array<DNDTask>
    {
        // RETURNS ONLY AN ARRAY OF THE NAMES OF THE TASKS, NOT THE ACTUAL TASKS! FIX!
//        println("FOLDER \(folder)")
        var taskArray = Array<DNDTask>()
        var plist = self.plist() as NSDictionary
        if let folder = plist[folder] as? NSDictionary
        {
//            println("FOLDER CONTENT: \(folder)")
            if let tasks = folder["tasks"] as? NSArray
            {
//                println("TASKS ARRAY \(tasks)")
                
                for task in tasks
                {
                    let nuTask = DNDTask()
                    nuTask.done = task["Done"] as Bool
                    nuTask.name = task["Name"] as? String
                    nuTask.imageName = task["Imagename"] as? String
                    taskArray.append(nuTask)
                }
            }
        }
        return taskArray
    }
    
    func moveTaskFromIndex(fromIndex:Int, toIndex:Int, inFolder:String)
    {
        println("MOVE TASK FROM INDEX \(fromIndex) TO INDEX \(toIndex) IN FOLDER \(inFolder)")
        var plist = self.plist()
        println("PLIST FÖRE \(plist)")
        var foldersDict = plist[inFolder] as NSMutableDictionary
        var tasks = foldersDict["tasks"] as Array<AnyObject>
        
        println("TASKS ARRAY \(tasks)")
        
        if tasks.count > 0
        {
        tasks.insert(tasks.removeAtIndex(fromIndex), atIndex: toIndex)
        foldersDict.setObject(tasks, forKey: "tasks")
        plist.setObject(foldersDict, forKey: inFolder)
        if plist.writeToFile(self.plistLocation(), atomically: true)
        {
            println("SUCCESS")
        } else {
            println("FAIL")
            }
        }
        println("PLIST EFTER \(plist)")
    }
    
    func colorForFolder(folder: String) -> UIColor
    {
        var plist = self.plist()
        var foldersDict = plist[folder] as NSDictionary
        let colorString = foldersDict["color"] as String
        return UIColor.colorFromString(colorString)
    }
    
}
