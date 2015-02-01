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
    var grabbedTaskView:TaskView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let taskViewSize = self.view.frame.size.height / 6
        let taskViewXPosition:CGFloat = self.view.frame.width / 4.0
        
        for i in 1...5
        {
            let taskView = TaskView()
            taskView.backgroundColor = UIColor.clearColor()
            taskView.frame = CGRectMake(0, 0, taskViewSize, taskViewSize)
            taskView.center = CGPointMake(taskViewXPosition, self.view.frame.height - (CGFloat(i) * taskViewSize))
            taskView.initialPosition = taskView.center
            self.view.addSubview(taskView)
            self.taskViews.append(taskView)
            // WHATTE FORK
        }
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
                    grabbedTaskView = taskView
                    break
                }
            }
        }
        if pan.state == UIGestureRecognizerState.Changed
        {
            if grabbedTaskView != nil
            {
                grabbedTaskView.center = panPoint
            }
        }
        if pan.state == UIGestureRecognizerState.Ended
        {
            if grabbedTaskView != nil
            {
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                    self.grabbedTaskView.center = self.grabbedTaskView.initialPosition
                    }, completion: nil)
                grabbedTaskView = nil
                
            }
        }
    }
}
