//
//  DNDEditorViewController.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-11.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
// 19

import UIKit

protocol DNDEditorDelegate {
    func editorPickedFolder(folder: String?)
    func editorWillDismiss()
    func editorReorderTask(from:Int, to:Int)
    func editorAddedTask()
}

class DNDEditorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate, DNDAddTaskDelegate {
    var delegate:DNDEditorDelegate?
    let doStuff = ["Sniff", "Worship"]
    let stuff = ["Satan", "Juice", "Disco", "Fubar", "Fork", "Salsa", "Rick Astley", "Freak", "Glue"]
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
            println("taskHandler.folders().count \(taskHandler.folders().count)")
            return taskHandler.folders().count
        }
        if tableView == self.tasksTableView
        {

            if let selectedFolder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as String?
            {
                if let tasks = taskHandler.tasksInFolder(selectedFolder) as NSArray?
                {
                    return tasks.count
                }
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
            
            if (taskHandler.folders()[indexPath.row] as String == NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as String?)
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
            
            if let selectedFolder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as String?
            {
                let task = taskHandler.tasksInFolder(selectedFolder)[indexPath.row] as DNDTask
                    cell.textLabel?.text = task.name
            }
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.foldersTableView
        {
            NSUserDefaults.standardUserDefaults().setObject(taskHandler.folders()[indexPath.row], forKey: "currentFolder")
            NSUserDefaults.standardUserDefaults().synchronize()
            self.currentFolderLabel.text = taskHandler.folders()[indexPath.row]
            tableView.reloadData()
            self.tasksTableView.reloadData()
            delegate?.editorPickedFolder(taskHandler.folders()[indexPath.row])
            
        }
        if tableView == self.tasksTableView
        {
            println("SELECTED TASK")
            let cell = self.tasksTableView.cellForRowAtIndexPath(indexPath)
            
        }
        self.checkIfAddTaskButtonShouldBeEnabled()
        
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        println("ACCESSORY BUTTON WAS TAPPED \(indexPath)")
        
        if let selectedFolder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as String?
        {
            let tasks = self.taskHandler.tasksInFolder(selectedFolder)
            let task = tasks[indexPath.row]
        self.performSegueWithIdentifier("editTask", sender: indexPath.row)
        }
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
        delegate?.editorWillDismiss()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    // Override to support conditional rearranging of the table view.
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        println("CAN MOVE AT INDEXPATH \(indexPath)")
        if tableView == self.tasksTableView
        {
            if let selectedFolder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as String?
            {
            if indexPath.row + 1 <= self.taskHandler.tasksInFolder(selectedFolder).count
            {
                println("YEP")
                return true
            }
            }
        }
        println("NOPE")
        return false
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        println("MOVE FROM \(sourceIndexPath) TO \(destinationIndexPath)")
        if let selectedFolder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as String?
        {
        self.taskHandler.moveTaskFromIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row, inFolder: selectedFolder)
        }
        delegate?.editorReorderTask(sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        println("COMMIT EDITING STYLE \(editingStyle) ON INDEXPATH \(indexPath)")
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            println("DELETE!! DELETE!!")
            if tableView == self.tasksTableView
            {
            self.taskHandler.removeTaskAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            self.didAddTask()
            }
            if tableView == self.foldersTableView
            {
                self.taskHandler.removeFolderAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
                delegate?.editorPickedFolder(nil)
            }
        }
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
        if let selectedFolder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as String?
        {
            let color = self.taskHandler.colorForFolder(selectedFolder)
            self.addTaskButton.setTitleColor(color, forState: UIControlState.Normal)
            self.toggleEditoButton.setTitleColor(color, forState: UIControlState.Normal)
            self.currentFolderLabel.textColor = color
            
            if let tasks = taskHandler.tasksInFolder(selectedFolder) as NSArray?
            {
                if tasks.count >= 5
                {
                    self.addTaskButton.enabled = false
                } else {
                    self.addTaskButton.enabled = true
                }
            }
        } else {
            self.addTaskButton.enabled = false
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
            addTaskVC.delegate = self
            self.modalPresentationStyle = UIModalPresentationStyle.Custom
            addTaskVC.modalPresentationStyle = UIModalPresentationStyle.Custom
            addTaskVC.transitioningDelegate = self
        }
        if segue.identifier == "editTask"
        {
            if let selectedFolder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as String?
            {
                let tasks = self.taskHandler.tasksInFolder(selectedFolder)
                let task = tasks[sender as Int]
                let editTaskVC = segue.destinationViewController as AddTaskViewController
                editTaskVC.taskIndex = sender as? Int
                editTaskVC.task = task
                editTaskVC.delegate = self
                editTaskVC.editTaskMode = true
                self.modalPresentationStyle = UIModalPresentationStyle.Custom
                editTaskVC.modalPresentationStyle = UIModalPresentationStyle.Custom
                editTaskVC.transitioningDelegate = self
            }
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
    
    
    
    func didAddTask() {
        self.checkIfAddTaskButtonShouldBeEnabled()
        self.tasksTableView.reloadData()
        self.delegate?.editorAddedTask()
    }
}
