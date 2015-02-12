//
//  AddTaskViewController.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-12.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var taskNameTextField: UITextField!
    let taskHandler = DNDTaskHandler()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardChanged:", name: UIKeyboardDidChangeFrameNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        taskNameTextField.becomeFirstResponder()
    }

    @IBAction func addTask() {
        println("ADD TASK")
        
    }

    @IBAction func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        println("DID BEGIN EDITING")
        taskNameTextField.becomeFirstResponder()
    }

//    - (void)myNotificationMethod:(NSNotification*)notification
    func keyboardChanged(notification: NSNotification)
    {
        println("KEYBOARD CHANGED \(notification)")
    }
    
}
