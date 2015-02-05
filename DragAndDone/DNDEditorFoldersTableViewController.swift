//
//  DNDEditorFoldersTableViewController.swift
//  DNDEditor
//
//  Created by Ricardo Gonzalez on 2015-02-03.
//  Copyright (c) 2015 FreakoSoft. All rights reserved.
//

import UIKit

class DNDEditorFoldersTableViewController: UITableViewController, UIViewControllerTransitioningDelegate, NewTaskDelegate {

    let taskHandler = DNDTaskHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light)) as UIVisualEffectView
        
        visualEffectView.frame = self.view.bounds
        
        self.tableView.backgroundView = visualEffectView
        
//        taskHandler.createFolder("Work")  // Make folder
        
//        let nuTask = DNDTask() // make task and put in folder
//        nuTask.name = "Mock Boss"
//        nuTask.imageName = "Mock.jpg"
//        taskHandler.addTask(nuTask, folder: "Work")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return taskHandler.folders().count + 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < taskHandler.folders().count
        {
        return taskHandler.tasksInFolder(taskHandler.folders()[section]).count
        }
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section
        {
        case taskHandler.folders().count:
            let cell = tableView.dequeueReusableCellWithIdentifier("AddCell", forIndexPath: indexPath) as UITableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            
            // Configure the cell...
            let folder = taskHandler.folders()[indexPath.section]
            let tasks = taskHandler.tasksInFolder(folder) as NSArray
            
            
            cell.textLabel?.text = tasks[indexPath.row]["Name"] as? String
            return cell
        }
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < taskHandler.folders().count
        {
        return taskHandler.folders()[section]
        }
        return nil
    }

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("SECTION: \(indexPath.section) NUMBER OF SECTIONS \(tableView.numberOfSections())")
        if indexPath.section < (tableView.numberOfSections() - 1)
        {
            println("DISMISS EDITOR!")
                self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addTask"
        {
            let addTaskVC = segue.destinationViewController as NewTaskViewController
            addTaskVC.delegate = self
            self.modalPresentationStyle = UIModalPresentationStyle.Custom
            addTaskVC.modalPresentationStyle = UIModalPresentationStyle.Custom
            addTaskVC.transitioningDelegate = self
        }
    }
    
    func addTask(task: DNDTask) {
        self.taskHandler.addTask(task, folder: "Work")
        self.tableView.reloadData()
    }
}
