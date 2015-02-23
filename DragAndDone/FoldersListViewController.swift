//
//  FoldersListViewController.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-23.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class FoldersListViewController: UIViewController, DNDEditorDelegate, UITableViewDataSource, UITableViewDelegate {

    var delegate:DNDEditorDelegate?
    
    @IBOutlet weak var foldersListTableView: UITableView! {
        didSet {
            self.foldersListTableView.contentInset = UIEdgeInsetsMake(topBarHeight, 0.0, 0.0, 0.0)
        }
    }
    
    let taskHandler = DNDTaskHandler()

    func tappedDimmingView()
    {
        delegate?.editorWillDismiss()
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func editorAddedTask() {
        
    }
    
    func editorPickedFolder(folder: String?) {
        
    }
    
    func editorReorderTask(from: Int, to: Int) {
        
    }
    
    func editorWillDismiss() {
        
    }
    
    // TABLE VIEW DATASOURCE
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0: return 5
        case 1: return 1
        case 2: return taskHandler.folders().count + 1
        default: return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as FoldersListTableViewCell
        
        let selectedFolder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as String?

        
        switch indexPath.section
        {
        case 0:
            cell.theTextLabel.textColor = UIColor.blackColor()
            if indexPath.row < taskHandler.tasksInFolder(selectedFolder!).count
            {
                let task = taskHandler.tasksInFolder(selectedFolder!)[indexPath.row] as DNDTask
                
                cell.theTextLabel.text = task.name
                cell.editButton.hidden = false
            } else {
                if indexPath.row == taskHandler.tasksInFolder(selectedFolder!).count
                {
                    cell.theTextLabel.textColor = FreakoColors.freakoRed
                    cell.theTextLabel.text = "add new task"
                } else {
                    cell.theTextLabel.text = ""
                }
                cell.editButton.hidden = true

            }

            cell.colorView.backgroundColor = UIColor.clearColor()
            cell.backgroundColor = UIColor.clearColor()
        case 1:
            cell.theTextLabel.text = ""
            cell.colorView.backgroundColor = UIColor.clearColor()
            cell.backgroundColor = UIColor.lightGrayColor()
            cell.editButton.hidden = true
        case 2:
            if indexPath.row < taskHandler.folders().count
            {
            cell.theTextLabel.text = taskHandler.folders()[indexPath.row]
            cell.theTextLabel.textColor = taskHandler.colorForFolder(taskHandler.folders()[indexPath.row])
            cell.colorView.backgroundColor = (selectedFolder == taskHandler.folders()[indexPath.row]) ? taskHandler.colorForFolder(taskHandler.folders()[indexPath.row]) : UIColor.clearColor()
            cell.backgroundColor = UIColor.clearColor()
            cell.editButton.hidden = false
            } else {
                cell.theTextLabel.text = "add new folder"
                cell.theTextLabel.textColor = FreakoColors.freakoRed
                cell.colorView.backgroundColor = UIColor.clearColor()
                cell.editButton.hidden = true
            }
        default: break
        }

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section
        {
        case 0:
            println("Selected task")
        case 2:
            println("Selected folder")
            if indexPath.row < taskHandler.folders().count
            {
                NSUserDefaults.standardUserDefaults().setObject(taskHandler.folders()[indexPath.row], forKey: "currentFolder")
                NSUserDefaults.standardUserDefaults().synchronize()
                tableView.reloadData()
            } else {
                println("ADD TASK")
            }
        default: break
        }
        

    }
}
