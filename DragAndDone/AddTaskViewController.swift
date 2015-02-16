//
//  AddTaskViewController.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-12.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

protocol DNDAddTaskDelegate {
    func didAddTask()
}

class AddTaskViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var task:DNDTask?
    var taskIndex:Int?
    @IBOutlet weak var taskNameTextField: UITextField!
    let taskHandler = DNDTaskHandler()
    var delegate:DNDAddTaskDelegate?
    var image:UIImage?
    var editTaskMode = false

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var takePictureButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardChanged:", name: UIKeyboardDidChangeFrameNotification, object: nil)
        if editTaskMode
        {
            self.addButton.setTitle("Save", forState: UIControlState.Normal)
            self.titleLabel.text = "Edit " + task!.name!
            self.taskNameTextField.text = task!.name!
            self.image = UIImage(contentsOfFile: taskHandler.docDir().stringByAppendingPathComponent(self.task!.imageName!))
            self.takePictureButton.setImage(UIImage(contentsOfFile: taskHandler.docDir().stringByAppendingPathComponent(self.task!.imageName!)), forState: UIControlState.Normal)

        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        taskNameTextField.becomeFirstResponder()
    }

    @IBAction func addTask() {
        println("ADD TASK")
        let nuTask = DNDTask()
        let docDir = taskHandler.docDir()
        
//        NSDate *now = [NSDate date];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyMMdd-HHmmss"];
//        
//        NSString *stringFromDate = [formatter stringFromDate:now];
//        
//        int slumpish = arc4random() %10000;
//        
//        NSString* filName = [NSString stringWithFormat:@"%@-%d.png", stringFromDate, slumpish];
        
        let now = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyMMdd-HHmmss"
        let stringFromDate = formatter.stringFromDate(now)
        let fileName = stringFromDate + "-\(arc4random_uniform(10000)).png"
        let picPath = docDir.stringByAppendingPathComponent(fileName)


        
        nuTask.name = self.taskNameTextField.text
        nuTask.imageName = fileName
        nuTask.doneImageName = "yeha"
        
        if let saveImage = self.image as UIImage?
        {
        UIImagePNGRepresentation(saveImage).writeToFile(picPath, atomically: true)
        }
        
        if editTaskMode
        {
        taskHandler.replaceTaskAtIndex(taskIndex!, withTask: nuTask)
        } else {
        taskHandler.addTaskInCurrentFolder(nuTask)
        }
        delegate?.didAddTask()
        self.dismissViewControllerAnimated(false, completion: nil)
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
    
    @IBAction func takePicture() {
        println("TAKE PICTURE")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.image = image!
        self.takePictureButton.setImage(image!, forState: UIControlState.Normal)
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
