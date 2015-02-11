//
//  DNDEditorViewController.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-11.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class DNDEditorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let doStuff = ["Mock", "Brush", "Wash", "Sing", "Play", "Drink", "Eat", "Go", "Dance"]
    let stuff = ["Teeth", "Juice", "Disco", "Fubar", "Fork", "Salsa", "Rick Astley", "Freak", "Snow"]
    var selectedFolder:Int?
    let taskHandler = DNDTaskHandler()
    
    @IBOutlet weak var foldersTableView: UITableView!
    @IBOutlet weak var currentFolderLabel: UILabel!
    @IBOutlet weak var tasksTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        selectedFolder = 3
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
            return 5
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
                if (indexPath.row + 1) > (taskHandler.tasksInFolder(taskHandler.folders()[selFol]).count)
                {
                    if indexPath.row == 4
                    {
                        cell.textLabel?.text = "Add task"
                    }
                } else {
                    let task = taskHandler.tasksInFolder(taskHandler.folders()[selFol])[indexPath.row] as NSDictionary
                    cell.textLabel?.text = task["Name"] as? String
                }
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
        }
        if tableView == self.tasksTableView
        {
            println("SELECTED TASK")
            let cell = self.tasksTableView.cellForRowAtIndexPath(indexPath)
            if cell?.textLabel?.text == "Add task"
            {
                println("ADD TASK!")
                let nuTask = DNDTask()
                nuTask.name = self.doStuff[Int(arc4random_uniform(UInt32(self.doStuff.count)))] + " " + self.stuff[Int(arc4random_uniform(UInt32(self.stuff.count)))]
                nuTask.imageName = "yeah"
                nuTask.doneImageName = "yeha"
                taskHandler.addTask(nuTask, folder: taskHandler.folders()[self.selectedFolder!])
                self.tasksTableView.reloadData()
            }
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
            println("yeah")
        }
        
    }
    
    func tappedDimmingView()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
