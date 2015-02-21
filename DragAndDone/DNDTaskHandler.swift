//
//  DNDTaskHandler.swift
//  DNDEditor
//
//  Created by Ricardo Gonzalez on 2015-02-03.
//  Copyright (c) 2015 FreakoSoft. All rights reserved.
//

import UIKit

enum TaskFrequency: Printable {
    case daily, weekly, monthly
    
    var description: String {
        switch self {
        case .daily: return "Daily"
        case .weekly: return "Weekly"
        case .monthly: return "Monthly"
        }
    }
}

class DNDTaskHandler: NSObject {
    let taskColors = ["wisteria", "belizeHole", "nephritis", "greenSea", "sunFlower", "carrot", "alizarin"]
    
    func createFolder(folderName: String, frequency:TaskFrequency)
    {
        let folder = NSMutableDictionary()
        var color:String!
        if self.folders().count >= taskColors.count
        {
            let colorIndex = self.folders().count % taskColors.count
            color = taskColors[colorIndex]
        } else {
            color = taskColors[self.folders().count]
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // superset of OP's format
        let dateString = dateFormatter.stringFromDate(NSDate())
        
        folder.setObject(dateString, forKey:"LastReset")
        folder.setObject(frequency.description, forKey: "frequency")
        folder.setObject(color, forKey: "color")
        let plist = self.plist()
        plist.setValue(folder, forKey: folderName)
        plist.writeToFile(plistLocation(), atomically: true)
    }
    
    func shouldResetFolder(folder: String) -> Bool
    {
        /*NSCalendar* calendar = [NSCalendar currentCalendar];
        
        unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
        NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
        NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
        
        return [comp1 day]   == [comp2 day] &&
        [comp1 month] == [comp2 month] &&
        [comp1 year]  == [comp2 year];}*/
        
        let foldersDict = self.plist()[folder] as NSMutableDictionary
        if let lastResetString = foldersDict["LastReset"] as? String
        {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let lastResetDate = dateFormatter.dateFromString(lastResetString)
            
            let calendar = NSCalendar.currentCalendar()
            let lastResetDateComponents = calendar.components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitWeekOfYear | NSCalendarUnit.CalendarUnitDay, fromDate: lastResetDate!)
            let todayComponents = calendar.components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitWeekOfYear | NSCalendarUnit.CalendarUnitDay, fromDate: NSDate())
            
            switch (foldersDict["frequency"] as String)
            {
            case "Daily":
                println("DAILY RESET")
                if ((lastResetDateComponents.year == todayComponents.year) && (lastResetDateComponents.month == todayComponents.month) && (lastResetDateComponents.day == todayComponents.day))
                {
                    println("SAME DAY, NO RESET")
                    return false
                } else {
                    println("NEW DAY! RESET!")
                    return true
                }
            case "Monthly":
                println("MONTHLY RESET")
                if ((lastResetDateComponents.year == todayComponents.year) && (lastResetDateComponents.month == todayComponents.month))
                {
                    println("SAME MONTH, NO RESET")
                    return false
                } else {
                    println("NEW MONTH! RESET!")
                    return true
                }
            case "Yearly":
                println("YEARLY RESET")
                if (lastResetDateComponents.year == todayComponents.year)
                {
                    println("SAME YEAR, NO RESET")
                    return false
                } else {
                    println("NEW YEAR! RESET!")
                    return true
                }            default: break
            }
        } else {
            println("NO LAST RESET FOUND")
            self.resetFolder(folder)
        }
        
        return false
    }
    
    func resetFolder(folder: String)
    {
        println("RESET FOLDER \(folder)")
        var plist = self.plist()
        var foldersDict = plist[folder] as NSMutableDictionary
        
        println("FOLDERSDICT \(foldersDict)")
        
        let tasksArray = foldersDict["tasks"] as NSMutableArray
        for task in tasksArray
        {
            (task as NSMutableDictionary).setValue(false, forKey: "Done")
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // superset of OP's format
        let dateString = dateFormatter.stringFromDate(NSDate()) as String
        
        foldersDict.setObject(dateString, forKey:"LastReset")
        foldersDict.setObject(tasksArray, forKey: "tasks")
        foldersDict.setObject([], forKey: "doneTasks")
        plist.setObject(foldersDict, forKey: folder)
        
        println("PLIST RESET \(plist)")
        
        if plist.writeToFile(plistLocation(), atomically: true)
        {
            println("YEAH RESET FOLDER SOMETHING!!")
        } else {
            println("NOOO DIDNT RESET FOLDER SHIT")
        }
    }
    
    func taskWithID(taskID: String) -> DNDTask?
    {
        var plist = self.plist()
        for (folder, key) in plist
        {
            if let tasks = folder["tasks"] as? Array<Dictionary<String, AnyObject>>
            {
                for task in tasks
                {
                    if (task["TaskID"] as String) == taskID
                    {
                        let foundTask = DNDTask()
                        foundTask.done = task["Done"] as Bool
                        foundTask.name = task["Name"] as? String
                        foundTask.imageName = task["Imagename"] as? String
                        foundTask.taskID = task["TaskID"] as? String
                        return foundTask
                    }
                }
            }
        }
        return nil
    }
    
    func doneTasks() -> Array<String>?
    {
        if let folder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as? String
        {
            var plist = self.plist()
            var foldersDict = plist[folder] as NSMutableDictionary
            if let doneTasks = foldersDict["doneTasks"] as? Array<String>
            {
                return doneTasks
            }
        }
        return nil
    }
    
    func taskIsDone(taskID: String)
    {
        if let folder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as? String
        {
            var plist = self.plist()
            var foldersDict = plist[folder] as NSMutableDictionary
            var doneTasks = [String]()
            if let themOldDoneTasks = foldersDict["doneTasks"] as? Array<String>
            {
                doneTasks += themOldDoneTasks
            }
            doneTasks.append(taskID)
            foldersDict.setObject(doneTasks, forKey: "doneTasks")
            let tasksArray = foldersDict["tasks"] as NSMutableArray
            for task in tasksArray
            {
                if (task as NSMutableDictionary)["TaskID"] as String == taskID
                {
                    (task as NSMutableDictionary).setValue(true, forKey: "Done")
                }
            }
            plist.setObject(foldersDict, forKey: folder)
            if plist.writeToFile(plistLocation(), atomically: true)
            {
                println("YEAH TASK IS DONE!!")
            } else {
                println("NOOO TASK DONE FAIL!!")
            }
        }
    }
    
    func taskIsNotDone(taskID: String)
    {
        if let folder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as? String
        {
            var plist = self.plist()
            var foldersDict = plist[folder] as NSMutableDictionary
            var doneTasks = [String]()
            doneTasks += foldersDict["doneTasks"] as Array<String>
            
            println("DONETASKS BEFORE \(doneTasks)")
            if let taskIndex = find(doneTasks, taskID)
            {
                doneTasks.removeAtIndex(taskIndex)
            }
            println("DONETASKS AFTER \(doneTasks)")
            
            foldersDict.setObject(doneTasks, forKey: "doneTasks")
            
            
            let tasksArray = foldersDict["tasks"] as NSMutableArray
            for task in tasksArray
            {
                if (task as NSMutableDictionary)["TaskID"] as String == taskID
                {
                    (task as NSMutableDictionary).setValue(false, forKey: "Done")
                }
            }
            plist.setObject(foldersDict, forKey: folder)
            if plist.writeToFile(plistLocation(), atomically: true)
            {
                println("YEAH TASK IS UNDONE!!")
            } else {
                println("NOOO TASK UNDONE FAIL!!")
            }
        }    }
    
    
    func addTaskInCurrentFolder(task: DNDTask)
    {
        if let folder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as? String
        {
            self.addTask(task, folder: folder)
        }
    }
    
    func removeFolderAtIndex(index: Int)
    {
        let plist = self.plist()
        plist.removeObjectForKey(plist.allKeys[index])
        NSUserDefaults.standardUserDefaults().removeObjectForKey("currentFolder")
        NSUserDefaults.standardUserDefaults().synchronize()
        if plist.writeToFile(plistLocation(), atomically: true)
        {
            println("YEAH DELETED FOLDER SOMETHING!!")
        } else {
            println("NOOO DIDNT DELETE FOLDER SHIT")
        }
    }
    
    func removeTaskAtIndex(index: Int)
    {
        println("REPLACE TASK AT INDEX \(index)")
        if let folder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as? String
        {
            println("FOLDER \(folder)")
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
            
            //        taskDict.setValue(task.doneImageName, forKey: "Doneimagename")
            foldersArray.removeObjectAtIndex(index)
            foldersDictionary.setObject(foldersArray, forKey: "tasks")
            plist.setValue(foldersDictionary, forKey: folder)
            if plist.writeToFile(plistLocation(), atomically: true)
            {
                println("YEAH REPLACED SOMETHING!!")
            } else {
                println("NOOO DIDNT REPLACE SHIT")
            }
        }    }
    
    func replaceTaskAtIndex(index: Int, withTask task:DNDTask)
    {
        println("REPLACE TASK AT INDEX \(index)")
        if let folder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as? String
        {
            println("FOLDER \(folder)")
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
            println("FOLDERSARRAY: \(foldersArray)")
            let oldTask = foldersArray.objectAtIndex(index) as Dictionary<String, AnyObject>
            println("OLD TASK \(oldTask)")
            let taskDict = NSMutableDictionary()
            taskDict.setValue(task.done, forKey: "Done")
            taskDict.setValue(task.name!, forKey: "Name")
            taskDict.setValue(oldTask["TaskID"], forKey: "TaskID")
            taskDict.setValue(task.imageName!, forKey: "Imagename")
            //        taskDict.setValue(task.doneImageName, forKey: "Doneimagename")
            foldersArray.removeObjectAtIndex(index)
            
            // TODO: REMOVE OLD IMAGE FILE!!!!!!!!!!!
            
            foldersArray.insertObject(taskDict, atIndex: index)
            foldersDictionary.setObject(foldersArray, forKey: "tasks")
            plist.setValue(foldersDictionary, forKey: folder)
            
            println("NEW TASK \(taskDict)")
            if plist.writeToFile(plistLocation(), atomically: true)
            {
                println("YEAH REPLACED SOMETHING!!")
            } else {
                println("NOOO DIDNT REPLACE SHIT")
            }
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
        taskDict.setValue(self.randomStringWithLength(10), forKey: "TaskID")
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
                    nuTask.taskID = task["TaskID"] as? String
                    taskArray.append(nuTask)
                }
            }
        }
        println("TASKS TO RETURN \(taskArray)")
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
    
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            var length = UInt32 (letters.length)
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
}
