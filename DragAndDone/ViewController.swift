//
//  ViewController.swift
//  DragAndDone
//
//  Created by Gabriel Kroll on 01/02/15.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var taskViews: [TaskView] = []
    var doneTaskViews: [TaskView] = []
    var grabbedTaskView:TaskView!
    var panOffset:CGPoint!
    var taskViewSize:CGFloat!
    var placeholder = Placeholder(frame: CGRectMake(0, 0, 1, 1))
    var todoXPosition:CGFloat!
    var doneXPosition:CGFloat!
    var showEditorAnimation:(() -> Void)!
    var showStatsAnimation:(() -> Void)!
    var xMovement:CGFloat = 66.0
    var showsEditor = true
    var separatorLine:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("YEAH")
        
        self.showEditorAnimation = {
            for task in self.taskViews
            {
                if task.done
                {
                    task.center.x += (self.xMovement / 3)
                } else {
                    task.center.x += self.xMovement
                }
//                self.separatorLine.center.x += (self.xMovement / 7)
            }
        }
        self.showStatsAnimation = {
            for task in self.taskViews
            {
                if !task.done
                {
                    task.center.x += (self.xMovement / 3)
                } else {
                    task.center.x += self.xMovement
                }
            }
//            self.separatorLine.center.x += (self.xMovement / 7)
        }
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        // Do any additional setup after loading the view, typically from a nib.
        
        separatorLine = UIView(frame: CGRectMake(0, 0, 1, self.view.frame.height * 0.7))
        separatorLine.backgroundColor = UIColor.blackColor()
        separatorLine.center = self.view.center
        self.view.addSubview(separatorLine)
        
        self.taskViewSize = self.view.frame.size.height / 7
        todoXPosition = self.view.frame.width / 4.0
        doneXPosition = self.view.frame.width * 3 / 4.0
        
        for i in 1...5
        {
            let taskView = TaskView(frame: CGRectMake(0, 0, taskViewSize, taskViewSize))
            taskView.initialIndex = i
            taskView.backgroundColor = UIColor.clearColor()
            taskView.center = CGPointMake(todoXPosition, self.view.frame.height - (CGFloat(i) * taskViewSize))
            taskView.initialPosition = taskView.center
            taskView.textLabel.text = "\(i)"
            taskView.image = UIImage(named: "\(i).jpg")
            
            self.view.addSubview(taskView)
            self.taskViews.append(taskView)
            
            let tap = UITapGestureRecognizer(target: self, action: "handleTap:")
            taskView.addGestureRecognizer(tap)
        }
        
        self.placeholder.backgroundColor = UIColor.clearColor()
        //        self.placeholder.center = CGPointMake(doneXPosition, self.view.frame.height - self.taskViewSize)
        self.placeholder.center = CGPointMake(-500, -500)
        self.placeholder.bounds.size = CGSizeMake(taskViewSize, taskViewSize)
        self.view.addSubview(placeholder)
        
        self.navigationItem.title = "Daily Stuff"
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
                    grabbedTaskView.layer.zPosition = 1000
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
                    self.moveTaskToDone(grabbedTaskView)
                } else {
                    self.moveTaskToNotDone(grabbedTaskView)
                }
                grabbedTaskView.layer.zPosition = 100
                grabbedTaskView = nil
                self.hidePlaceholder()
            }
        }
    }
    
    func showPlaceholder()
    {
        self.placeholder.hidden = false
        self.placeholder.center = CGPointMake(doneXPosition, self.view.frame.height - self.taskViewSize)
        self.placeholder.bounds.size = CGSizeMake(1.0, 1.0)
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            self.placeholder.bounds.size = CGSizeMake(self.taskViewSize, self.taskViewSize)
            //            self.placeholder.setNeedsDisplay()
            }, completion: nil)
        
        self.shiftDoneTasksUp()
    }
    
    func shiftDoneTasksUp()
    {
        for taskView in self.taskViews
        {
            if taskView.done
            {
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                    taskView.center.y -= self.taskViewSize
                    
                    }, completion: nil)
            }
        }
    }
    
    func hidePlaceholder()
    {
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            //            self.placeholder.setNeedsDisplay()
            self.placeholder.bounds.size = CGSizeMake(1.0, 1.0)
            }) { (completed) -> Void in
                self.placeholder.hidden = true
        }
        var doneCount = 1
        for taskView in self.doneTaskViews
        {
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                    taskView.center.y = self.view.frame.height - (CGFloat(doneCount) * self.taskViewSize)
                }, completion:nil)
                doneCount++
        }
    }
    
    func moveTaskToDone(task: TaskView)
    {
        println("MOVE TO DONE")
        if (find(self.doneTaskViews, task) == nil)
        {
            self.doneTaskViews.insert(task, atIndex: 0)
        }
        task.done = true
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            task.center = CGPointMake(self.doneXPosition, self.view.frame.height - self.taskViewSize)
            }) {(completed) ->Void in
                self.checkTask(task)
                task.convertImageToGrayScale()
        }
        self.collapseTodoTasks()
        
    }
    
    func moveTaskToNotDone(task: TaskView)
    {
        println("MOVE TO NOT DONE")
        if let removeIndex = find(self.doneTaskViews, task)
        {
            self.doneTaskViews.removeAtIndex(removeIndex)
        }

        task.done = false
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            task.center = task.initialPosition
            }, completion: nil)
     self.collapseTodoTasks()
    }
    
    func collapseTodoTasks()
    {
        var i:Int = 0
        var todoer:CGFloat = 1.0
            //        for (i = self.taskViews.count - 1; i > -1; i--)
        for (i = 0; i < self.taskViews.count; i++)
        {
            println("i \(i)")
            if (!self.taskViews[i].done)
            {
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                    self.taskViews[i].center.y = self.view.frame.height - (self.taskViewSize * todoer)
                    }, completion: nil)

                todoer += 1.0
            }
        }
    }
    
    func handleTap(sender: UITapGestureRecognizer)
    {
        println("HANDLE TAP \(sender)")
        let task = sender.view as TaskView
        if !task.done
        {
        self.shiftDoneTasksUp()
        self.moveTaskToDone(sender.view as TaskView)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showStats"
        {
            self.showsEditor = false
            let stats = segue.destinationViewController as UIViewController
            self.modalPresentationStyle = UIModalPresentationStyle.Custom
            stats.modalPresentationStyle = UIModalPresentationStyle.Custom
            stats.transitioningDelegate = self
        }
        if segue.identifier == "showEditor"
        {
            self.showsEditor = true
            let stats = segue.destinationViewController as UIViewController
            self.modalPresentationStyle = UIModalPresentationStyle.Custom
            stats.modalPresentationStyle = UIModalPresentationStyle.Custom
            stats.transitioningDelegate = self
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let anCon = TransitionAnimator()
        anCon.showsEditor = self.showsEditor
        if self.showsEditor
        {
            anCon.animation = self.showEditorAnimation
        } else {
            anCon.animation = self.showStatsAnimation
        }
        return anCon
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let anCon = TransitionAnimator()
        anCon.showsEditor = self.showsEditor
        anCon.dismissing = true
        self.xMovement *= -1
        if self.showsEditor
        {
            anCon.animation = self.showEditorAnimation
        } else {
            anCon.animation = self.showStatsAnimation
        }
        return anCon
    }
    
    @IBAction func checkStats(sender: UIBarButtonItem) {
        println("CHECK STATS")
        self.xMovement = -150
        self.performSegueWithIdentifier("showStats", sender: self)
    }
    
    @IBAction func showEditor(sender: UIBarButtonItem) {
        println("SHOW EDITOR")
        self.xMovement = 150
        self.performSegueWithIdentifier("showEditor", sender: self)
    }
    
    func checkTask(task: TaskView)
    {
//        let bezierPath = UIBezierPath(catmullRomPoints: self.pointsArray, closed: false, alpha: 0.5)
//        let bezier:CAShapeLayer = CAShapeLayer()
//        bezier.path = bezierPath?.CGPath
//        bezier.strokeColor = UIColor.yellowColor().CGColor
//        bezier.fillColor = UIColor.clearColor().CGColor
//        bezier.lineWidth = 30.0
//        bezier.strokeStart = 0.0
//        bezier.strokeEnd = 1.0
//        self.scrollView.layer.addSublayer(bezier)

        let bezPath = UIBezierPath()
        let checkFrame = CGRectInset(task.frame, 10, 10)
        
//        bezierPath.moveToPoint(CGPointMake(8.5, 41.5))
//        bezierPath.addCurveToPoint(CGPointMake(20.5, 88.5), controlPoint1: CGPointMake(20.5, 85.5), controlPoint2: CGPointMake(20.5, 87.5))
//        bezierPath.addCurveToPoint(CGPointMake(91.5, 12.5), controlPoint1: CGPointMake(20.5, 89.5), controlPoint2: CGPointMake(31.5, 7.5))
        
        bezPath.moveToPoint(CGPointMake(checkFrame.size.width * 0.185, checkFrame.size.height * 0.415))
        bezPath.addCurveToPoint(CGPointMake(checkFrame.size.width * 0.305, checkFrame.size.height * 0.885), controlPoint1: CGPointMake(checkFrame.size.width * 0.305, checkFrame.size.height * 0.885), controlPoint2: CGPointMake(checkFrame.size.width * 0.305, checkFrame.size.height * 0.885))
        
        bezPath.addCurveToPoint(CGPointMake(checkFrame.size.width * 1.0, checkFrame.size.height * 0.125), controlPoint1: CGPointMake(checkFrame.size.width * 0.305, checkFrame.size.height * 0.895), controlPoint2: CGPointMake(checkFrame.size.width * 0.415, checkFrame.size.height * 0.075))
        
        
        let bezLayer = CAShapeLayer()
        bezLayer.path = bezPath.CGPath
        bezLayer.strokeColor = UIColor.purpleColor().CGColor
        bezLayer.fillColor = UIColor.clearColor().CGColor
        bezLayer.lineWidth = 8.0
        bezLayer.strokeStart = 0.0
        bezLayer.strokeEnd = 0.0
        task.layer.addSublayer(bezLayer)
        
        // Configure the animation
        var drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.repeatCount = 1.0
        
        // Animate from the full stroke being drawn to none of the stroke being drawn
        drawAnimation.fromValue = NSNumber(double: 0.0)
        drawAnimation.toValue = NSNumber(float: 5.0)
        
        drawAnimation.duration = 2
        
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        // Add the animation to the circle
        bezLayer.addAnimation(drawAnimation, forKey: "check")
    }

}
