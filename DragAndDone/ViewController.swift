//
//  ViewController.swift
//  DragAndDone
//
//  Created by Gabriel Kroll on 01/02/15.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var taskViews: [TaskView] = []
    var doneTaskViews: [TaskView] = []
    var grabbedTaskView:TaskView!
    var panOffset:CGPoint!
    var taskViewSize:CGFloat!
    var placeholder = Placeholder(frame: CGRectMake(0, 0, 1, 1))
    var todoXPosition:CGFloat!
    var doneXPosition:CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let separatorLine = UIView(frame: CGRectMake(0, 0, 1, self.view.frame.height * 0.7))
        separatorLine.backgroundColor = UIColor.blackColor()
        separatorLine.center = self.view.center
        self.view.addSubview(separatorLine)
        
        self.taskViewSize = self.view.frame.size.height / 6
        todoXPosition = self.view.frame.width / 4.0
        doneXPosition = self.view.frame.width * 3 / 4.0
        
        for i in 1...5
        {
            let taskView = TaskView()
            taskView.initialIndex = i
            taskView.backgroundColor = UIColor.clearColor()
            taskView.frame = CGRectMake(0, 0, taskViewSize, taskViewSize)
            taskView.center = CGPointMake(todoXPosition, self.view.frame.height - (CGFloat(i) * taskViewSize))
            taskView.initialPosition = taskView.center
            self.view.addSubview(taskView)
            self.taskViews.append(taskView)
            // WHATTE FORK  <-HAHA! DID YOU DO THIS?
        }
        
        self.placeholder.backgroundColor = UIColor.clearColor()
        self.placeholder.center = CGPointMake(doneXPosition, self.view.frame.height - self.taskViewSize)
        self.placeholder.bounds.size = CGSizeMake(taskViewSize, taskViewSize)
        self.view.addSubview(placeholder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func handlePan(sender: AnyObject) {
        let pan = sender as UIPanGestureRecognizer
        let panPoint = pan.locationInView(self.view)
        
        if pan.state == UIGestureRecognizerState.Began
        {
            for taskView in self.taskViews
            {
                if CGRectContainsPoint(taskView.frame, panPoint)
                {
                    self.panOffset = CGPointMake(panPoint.x - taskView.center.x, panPoint.y - taskView.center.y)
                    grabbedTaskView = taskView
                    if !grabbedTaskView.done
                    {
                        self.showPlaceholder()
                    }
                    break
                }
            }
        }
        if pan.state == UIGestureRecognizerState.Changed
        {
            if grabbedTaskView != nil
            {
                grabbedTaskView.center = CGPointMake(panPoint.x - self.panOffset.x, panPoint.y - self.panOffset.y)
            }
        }
        if pan.state == UIGestureRecognizerState.Ended
        {
            if grabbedTaskView != nil
            {
                if grabbedTaskView.center.x > (self.view.frame.size.width / 2)
                {
                    grabbedTaskView.done = true
                    self.moveTaskToDone(grabbedTaskView)
                    self.hidePlaceholder(true)
                } else {
                    self.hidePlaceholder(false)
                    grabbedTaskView.done = false
                    UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                        self.grabbedTaskView.center = self.grabbedTaskView.initialPosition
                        }, completion: nil)
                }
                grabbedTaskView = nil
                
            }
        }
    }
    
    func showPlaceholder()
    {
        self.placeholder.hidden = false
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            self.placeholder.bounds.size = CGSizeMake(self.taskViewSize, self.taskViewSize)
//            self.placeholder.setNeedsDisplay()
            }, completion: nil)
        
        for taskView in self.doneTaskViews
        {
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                taskView.center.y -= self.taskViewSize
                }, completion: nil)
        }
    }
    
    func hidePlaceholder(addedTask:Bool)
    {
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
//            self.placeholder.setNeedsDisplay()
            self.placeholder.bounds.size = CGSizeMake(1.0, 1.0)
            }) { (completed) -> Void in
                self.placeholder.hidden = true
        }
        if !addedTask
        {
            for taskView in self.doneTaskViews
            {
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                    taskView.center.y += self.taskViewSize
                    }, completion: nil)
            }
        }
    }
    
    func moveTaskToDone(task: TaskView)
    {
        self.doneTaskViews.append(task)
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            task.center = CGPointMake(self.doneXPosition, self.view.frame.height - self.taskViewSize)
            }, completion: nil)
        
    }
}
