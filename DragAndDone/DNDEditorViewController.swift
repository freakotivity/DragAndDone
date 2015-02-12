//
//  DNDEditorViewController.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-11.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

protocol DNDEditorDelegate {
    func pickedFolder(folder: String)
}

class DNDEditorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate {
    var delegate:DNDEditorDelegate?
    let doStuff = ["Sniff", "Worship"]
    let stuff = ["Satan", "Juice", "Disco", "Fubar", "Fork", "Salsa", "Rick Astley", "Freak", "Glue"]
    var selectedFolder:Int?
    let taskHandler = DNDTaskHandler()
    
    @IBOutlet weak var foldersTableView: UITableView!
    @IBOutlet weak var currentFolderLabel: UILabel!
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var toggleEditoButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //        self.tasksTableView.setEditing(true, animated: false)
        self.foldersTableView.backgroundView = EditorEdge()
        self.checkIfAddTaskButtonShouldBeEnabled()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.foldersTableView
        {
            return taskHandler.folders().count
        }
        if tableView == self.tasksTableView
        {
            if self.selectedFolder != nil
            {
                return taskHandler.tasksInFolder(taskHandler.folders()[self.selectedFolder!]).count
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        // Configure the cell...
        
        if tableView == self.foldersTableView
        {
            cell = tableView.dequeueReusableCellWithIdentifier("FolderCell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = taskHandler.folders()[indexPath.row]
            cell.textLabel?.textColor = taskHandler.colorForFolder(taskHandler.folders()[indexPath.row])
            
            if indexPath.row == selectedFolder
            {
                cell.backgroundView = UIView()
                cell.accessoryType = UITableViewCellAccessoryType.None
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                let bgv = EditorEdge()
                bgv.backgroundColor = UIColor.whiteColor()
                cell.backgroundView = bgv
            }
        }
        
        if tableView == self.tasksTableView
        {
            cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel?.text = ""
            if let selFol = self.selectedFolder
            {
                
                let task = taskHandler.tasksInFolder(taskHandler.folders()[selFol])[indexPath.row] as NSDictionary
                cell.textLabel?.text = task["Name"] as? String
            }
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.foldersTableView
        {
            self.currentFolderLabel.text = taskHandler.folders()[indexPath.row]
            self.selectedFolder = indexPath.row
            tableView.reloadData()
            self.tasksTableView.reloadData()
            delegate?.pickedFolder(taskHandler.folders()[indexPath.row])
            
        }
        if tableView == self.tasksTableView
        {
            println("SELECTED TASK")
            let cell = self.tasksTableView.cellForRowAtIndexPath(indexPath)
            
        }
        self.checkIfAddTaskButtonShouldBeEnabled()
        
    }
    
    @IBAction func addFolder() {
        let nuFolderAlert = UIAlertController(title: "New Folder", message: "Name:", preferredStyle: UIAlertControllerStyle.Alert)
        
        nuFolderAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            println("yeah")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        let addFolderAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default) { (action) -> Void in
            let tf = nuFolderAlert.textFields?.first as UITextField
            
            self.taskHandler.createFolder(tf.text)
            self.foldersTableView.reloadData()
        }
        nuFolderAlert.addAction(cancelAction)
        nuFolderAlert.addAction(addFolderAction)
        self.presentViewController(nuFolderAlert, animated: true) { () -> Void in
        }
        
    }
    
    func tappedDimmingView()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    // Override to support conditional rearranging of the table view.
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        println("CAN MOVE AT INDEXPATH \(indexPath)")
        if tableView == self.tasksTableView
        {
            if indexPath.row + 1 <= self.taskHandler.tasksInFolder(taskHandler.folders()[self.selectedFolder!]).count
            {
                println("YEP")
                return true
            }
        }
        println("NOPE")
        return false
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        println("MOVE FROM \(sourceIndexPath) TO \(destinationIndexPath)")
        self.taskHandler.moveTaskFromIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row, inFolder: self.taskHandler.folders()[self.selectedFolder!])
    }
    
    
    @IBAction func addTask() {
        println("ADD TASK!")

        self.performSegueWithIdentifier("addTask", sender: self)
        
        
//        let nuTask = DNDTask()
//        nuTask.name = self.doStuff[Int(arc4random_uniform(UInt32(self.doStuff.count)))] + " " + self.stuff[Int(arc4random_uniform(UInt32(self.stuff.count)))]
//        nuTask.imageName = "yeah"
//        nuTask.doneImageName = "yeha"
//        taskHandler.addTask(nuTask, folder: taskHandler.folders()[self.selectedFolder!])
//        self.tasksTableView.reloadData()
        self.checkIfAddTaskButtonShouldBeEnabled()
    }
    
    func checkIfAddTaskButtonShouldBeEnabled()
    {
        if self.selectedFolder == nil
        {
            self.addTaskButton.enabled = false
//            self.toggleEditoButton.enabled = false
        } else {
//            if taskHandler.tasksInFolder(taskHandler.folders()[self.selectedFolder!]).count > 0
//            {
//                self.toggleEditoButton.enabled = true
//            } else {
//                self.toggleEditoButton.enabled = false
//            }
            if taskHandler.tasksInFolder(taskHandler.folders()[self.selectedFolder!]).count >= 5
            {
                self.addTaskButton.enabled = false
            } else {
                self.addTaskButton.enabled = true
            }
        }
    }
    @IBAction func toggleEditMode(sender: AnyObject) {
        if self.tasksTableView.editing
        {
            self.tasksTableView.setEditing(false, animated: true)
            self.foldersTableView.setEditing(false, animated: true)
            self.toggleEditoButton.setTitle("Edit", forState: UIControlState.Normal)
        } else {
            self.tasksTableView.setEditing(true, animated: true)
            self.foldersTableView.setEditing(true, animated: true)
            self.toggleEditoButton.setTitle("Done", forState: UIControlState.Normal)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addTask"
        {
            let addTaskVC = segue.destinationViewController as AddTaskViewController
            self.modalPresentationStyle = UIModalPresentationStyle.Custom
            addTaskVC.modalPresentationStyle = UIModalPresentationStyle.Custom
            addTaskVC.transitioningDelegate = self
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AddTaskAnimator()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let taskAnim = AddTaskAnimator()
        taskAnim.dismissing = true
        return taskAnim
    }
}
