//
//  AddFolderViewController.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-18.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

protocol DNDAddFolderDelegate {
    func didAddFolder()
}

class AddFolderViewController: UIViewController {

    var delegate:DNDAddFolderDelegate?
    var frequency:TaskFrequency!
    var taskHandler = DNDTaskHandler()
    @IBOutlet weak var folderNameTextField: UITextField!
    @IBOutlet weak var frequencySegmentedControl: UISegmentedControl! {
        didSet {
            self.updateFrequency()
        }
    }

    @IBAction func freqSegValueChanged(sender: UISegmentedControl) {
        println("FREQUENCY SEGMENT CONTROLLER CHANGED: \(frequencySegmentedControl.selectedSegmentIndex)")
        self.updateFrequency()
    }

    @IBAction func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addFolder() {
        println("ADD FOLDER NAMED: \(folderNameTextField.text) FREQUENCY: \(frequency)")
        self.taskHandler.createFolder(folderNameTextField.text, frequency: frequency)
        delegate?.didAddFolder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func updateFrequency()
    {
        switch frequencySegmentedControl.selectedSegmentIndex
        {
        case 0:
            frequency = TaskFrequency.daily
        case 1:
            frequency = TaskFrequency.weekly
        case 2:
            frequency = TaskFrequency.monthly
        default:
            break
        }
    }
}
