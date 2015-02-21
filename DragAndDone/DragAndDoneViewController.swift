//
//  ViewController.swift
//  DragAndDone
//
//  Created by Gabriel Kroll on 01/02/15.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

//         UIColor(red: 142/255.0, green: 68/255.0, blue: 173/255.0, alpha: 1.0)
// 142 68 173


import UIKit

class DragAndDoneViewController: UIViewController, UIViewControllerTransitioningDelegate, DNDEditorDelegate {
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
    var separatorLine:UIView!
    
    var transitionAnimator:DNDTransitionAnimator!
    var transitionPresentationController:UIPresentationController!
    
    
    var topBar = UIView()
    var topBarTitleLabel = UILabel()
    let taskHandler = DNDTaskHandler()
    
    var showsEditor = false
    var showsStats = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("YEAH")
        separatorLine = SeparatorLine(frame: CGRectMake(0, 0, 1, self.view.frame.height))
        separatorLine.center = self.view.center
        separatorLine.backgroundColor = UIColor.clearColor()
        self.view.addSubview(separatorLine)
        
        self.topBar.frame.size = CGSizeMake(self.view.bounds.size.width, 64.0)
        self.topBar.frame.origin = CGPointMake(0, 0)
        self.topBar.backgroundColor = UIColor.wisteria()
        
        self.view.addSubview(self.topBar)
        
        let hamburger = UIButton(frame: CGRectMake(8, 30, 22, 22))
        hamburger.setImage(UIImage(named: "menu burger navbar"), forState: UIControlState.Normal)
        hamburger.addTarget(self, action: "showEditor:", forControlEvents: UIControlEvents.TouchUpInside)
        self.topBar.addSubview(hamburger)
        
        let statsButton = UIButton(frame: CGRectMake(self.view.frame.size.width - 30, 30, 22, 22))
        statsButton.setImage(UIImage(named: "statistics circle navbar"), forState: UIControlState.Normal)
        statsButton.addTarget(self, action: "checkStats:", forControlEvents: UIControlEvents.TouchUpInside)
        self.topBar.addSubview(statsButton)
        
        self.topBarTitleLabel.center.x = self.topBar.center.x
        self.topBarTitleLabel.center.y = 25 // Y position for title label
        self.topBarTitleLabel.textColor = UIColor.whiteColor()
        self.topBarTitleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 25.0)
        self.topBar.addSubview(self.topBarTitleLabel)
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        self.taskViewSize = self.view.frame.size.height / 6
        todoXPosition = self.view.frame.width / 4.0
        doneXPosition = self.view.frame.width * 3 / 4.0
        
        self.loadCurrentFolder()
        
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
                    if !grabbedTaskView.task!.done
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
            } else {
                //                println("PAN TRANSLATION \(pan.translationInView(self.view).y)")
                if pan.translationInView(self.view).y < -50
                {
                    println("LOAD PREVIOUS FOLDER")
                    self.loadPreviousFolder()
                    pan.setTranslation(CGPointZero, inView: self.view)
                }
                if pan.translationInView(self.view).y > 50
                {
                    println("LOAD NEXT FOLDER")
                    self.loadNextFolder()
                    pan.setTranslation(CGPointZero, inView: self.view)
                }
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
        if let folder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as? String
        {
            self.placeholder.color = self.taskHandler.colorForFolder(folder)
            self.placeholder.setNeedsDisplay()
        }
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
            if taskView.task!.done
            {
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                    taskView.center.y -= self.taskViewSize * 1.5
                    
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
        //        for taskView in self.doneTaskViews
        //        {
        //            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
        //                taskView.center.y = self.view.frame.height - (CGFloat(doneCount) * self.taskViewSize)
        //                }, completion:nil)
        //            doneCount++
        //        }
        self.collapseTodoTasks()
    }
    
    func moveTaskToDone(task: TaskView)
    {
        println("MOVE TO DONE")
        if (find(self.doneTaskViews, task) == nil)
        {
            self.doneTaskViews.insert(task, atIndex: 0)
        }
        if task.task?.done == false
        {
            task.task?.done = true
            println("MOVE TASK: \(task.task)")
            self.taskHandler.taskIsDone(task.task!.taskID!)
            self.checkTask(task)
            task.convertImageToGrayScale()
        }
        self.collapseTodoTasks()
        
        
        if ((self.doneTaskViews.count == 3) || (self.doneTaskViews.count == 5))
        {
            self.performSegueWithIdentifier("congratulations", sender: self)
        }
    }
    
    func moveTaskToNotDone(task: TaskView)
    {
        println("MOVE TO NOT DONE")
        if let removeIndex = find(self.doneTaskViews, task)
        {
            self.doneTaskViews.removeAtIndex(removeIndex)
        }
        self.taskHandler.taskIsNotDone(task.task!.taskID!)
        task.task?.done = false
        task.center.x = todoXPosition
        self.collapseTodoTasks()
    }
    
    func collapseTodoTasks()
    {
        let startFactor:CGFloat = 0.7
        var i:Int = 0
        var todoer:CGFloat = startFactor
        
        // NOT DONE
        for (i = self.taskViews.count - 1; i > -1; i--)
            //        for (i = 0; i < self.taskViews.count; i++)
        {
            println("i \(i)")
            if (!self.taskViews[i].task!.done)
            {
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: nil, animations: { () -> Void in
                    //                    self.taskViews[i].center.y = self.view.frame.height - (self.taskViewSize * todoer)
                    self.taskViews[i].center.y = self.view.frame.height - (self.taskViewSize * todoer)
                    
                    }, completion: nil)
                
                todoer += 1.0
            }
        }
        
        // DONE
        
        todoer = startFactor
        //        for (i = self.doneTaskViews.count - 1; i > -1; i--)
        for (i = 0; i < self.doneTaskViews.count; i++)
        {
            println("i \(i)")
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: nil, animations: { () -> Void in
                self.doneTaskViews[i].center.y = self.view.frame.height - (self.taskViewSize * todoer)
                self.doneTaskViews[i].center.x = self.doneXPosition
                
                }, completion: nil)
            
            todoer += 1.0
        }
    }
    
    func handleTap(sender: UITapGestureRecognizer)
    {
        println("HANDLE TAP \(sender)")
        let task = sender.view as TaskView
        if !task.task!.done
        {
            self.shiftDoneTasksUp()
            self.moveTaskToDone(sender.view as TaskView)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.transitionAnimator = nil
        self.transitionPresentationController = nil
        
        if segue.identifier == "showStats"
        {
            self.transitionAnimator = StatsTransitionAnimator()
            (self.transitionAnimator as StatsTransitionAnimator).taskViews = self.taskViews
            let stats = segue.destinationViewController as UIViewController
            self.modalPresentationStyle = UIModalPresentationStyle.Custom
            stats.modalPresentationStyle = UIModalPresentationStyle.Custom
            stats.transitioningDelegate = self
        }
        if segue.identifier == "showEditor"
        {
            self.showsEditor = true
            let editorVC = segue.destinationViewController as DNDEditorViewController
            editorVC.delegate = self
            self.transitionPresentationController = EditorPresentationController()
            self.transitionAnimator = EditorTransitionAnimator()
            (self.transitionAnimator as EditorTransitionAnimator).taskViews = self.taskViews
            let stats = segue.destinationViewController as UIViewController
            self.modalPresentationStyle = UIModalPresentationStyle.Custom
            stats.modalPresentationStyle = UIModalPresentationStyle.Custom
            stats.transitioningDelegate = self
        }
        if segue.identifier == "congratulations"
        {
            self.transitionPresentationController = CongratsPresentationController()
            self.transitionAnimator = CongratulationsTransitionAnimator()
            let congrats = segue.destinationViewController as UIViewController
            self.modalPresentationStyle = UIModalPresentationStyle.Custom
            congrats.modalPresentationStyle = UIModalPresentationStyle.Custom
            congrats.transitioningDelegate = self
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return self.transitionAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionAnimator.dismissing = true
        return self.transitionAnimator
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController) -> UIPresentationController? {
        if self.transitionPresentationController != nil
        {
            if self.transitionPresentationController.isKindOfClass(CongratsPresentationController.self)
            {
                self.transitionPresentationController = CongratsPresentationController(presentedViewController: presented, presentingViewController: presenting)
            }
            if self.transitionPresentationController.isKindOfClass(EditorPresentationController.self)
            {
                self.transitionPresentationController = EditorPresentationController(presentedViewController: presented, presentingViewController: presenting)
            }
            
            return self.transitionPresentationController
        }
        return nil
    }
    
    @IBAction func checkStats(sender: UIBarButtonItem) {
        println("CHECK STATS")
        self.hideLine()
        self.performSegueWithIdentifier("showStats", sender: self)
    }
    
    @IBAction func showEditor(sender: UIBarButtonItem) {
        println("SHOW EDITOR")
        self.hideLine()
        self.performSegueWithIdentifier("showEditor", sender: self)
    }
    
    func hideLine()
    {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.separatorLine.alpha = 0.0
        })
    }
    
    func checkTask(task: TaskView)
    {
        var checkColor:UIColor!
        if let folder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as? String
        {
            checkColor = self.taskHandler.colorForFolder(folder)
        }
        
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
        //        bezLayer.strokeColor = UIColor.purpleColor().CGColor
        if task.image != nil
        {
            bezLayer.strokeColor = checkColor.CGColor
        } else {
            bezLayer.strokeColor = UIColor.blackColor().CGColor
        }
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
    
    func editorPickedFolder(folder: String?) {
        println("PICKED FOLDER \(folder)")
        NSUserDefaults.standardUserDefaults().setObject(folder, forKey: "currentFolder")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.loadCurrentFolder()
        
    }
    
    func loadCurrentFolder()
    {
        self.loadCurrentFolder(true)
    }
    
    func loadCurrentFolder(fromTop: Bool)
    {
        println("LOAD CURRENT FOLDER")
        self.clearTaskViews(fromTop)
        self.taskViews.removeAll()
        self.doneTaskViews.removeAll()
        
        if let folder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as? String
        {
            let color = self.taskHandler.colorForFolder(folder)
            self.topBar.backgroundColor = color
            self.topBarTitleLabel.text = folder
            self.topBarTitleLabel.sizeToFit()
            self.topBarTitleLabel.center.x = self.topBar.center.x
            
            
            if self.taskHandler.shouldResetFolder(folder)
            {
                self.taskHandler.resetFolder(folder)
            }
            
            let tasks = taskHandler.tasksInFolder(folder)
            for (index, task) in enumerate(tasks)
            {
                println("LOADING TASK \(task)")
                
                let taskView = TaskView(frame: CGRectMake(0, 0, taskViewSize, taskViewSize))
                taskView.taskColor = taskHandler.colorForFolder(folder)
                taskView.task = task
                taskView.backgroundColor = UIColor.clearColor()
                //                taskView.center.y = self.view.frame.height - (CGFloat(index + 1) * taskViewSize)
                //                taskView.center.y = self.view.frame.height - (CGFloat(taskHandler.tasksInFolder(folder).count - index) * taskViewSize)
                taskView.center.y = fromTop ? -taskViewSize : self.view.frame.size.height + taskViewSize
                if self.showsEditor {
                    taskView.center.x = self.doneXPosition
                } else {
                    if task.done
                    {
                        taskView.center.x = self.doneXPosition
                    } else {
                        taskView.center.x = self.todoXPosition
                    }
                }
                println("TASKVIEW IMAGE: \(taskView.task!.imageName!)")
                
                taskView.image = UIImage(contentsOfFile: taskHandler.docDir().stringByAppendingPathComponent(taskView.task!.imageName!))
                
                println("TASKVIEW IMAGE UIIMAGE: \(taskView.image)")
                
                if taskView.image == nil
                {
                    let taskNameArray = split(taskView.task!.name!) {$0 == " "}
                    println("TASKNAME ARRAY \(taskNameArray)")
                    var firsts = ""
                    for word in taskNameArray
                    {
                        println("WORD SUBSTRING \(word.substringToIndex(advance(word.startIndex, 1)).capitalizedString)")
                        firsts += word.substringToIndex(advance(word.startIndex, 1)).capitalizedString
                    }
                    
                    taskView.textLabel.text = firsts
                } else {
                    taskView.textLabel.text = ""
                }
                
                self.view.addSubview(taskView)
                self.taskViews.append(taskView)
                
                let tap = UITapGestureRecognizer(target: self, action: "handleTap:")
                taskView.addGestureRecognizer(tap)
            }
            
            // build the done tasks array
            if let doneTasks = self.taskHandler.doneTasks()
            {
                println("WE GOT SOME DONE TASKS HERE: \(doneTasks)")
                for doneTask in doneTasks
                {
                    for maybeDoneTask in self.taskViews
                    {
                        if maybeDoneTask.task?.taskID == doneTask
                        {
                            self.moveTaskToDone(maybeDoneTask)
                        }
                    }
                }
                
            }
            
            self.collapseTodoTasks()
            if showsEditor
            {
                (self.transitionAnimator as EditorTransitionAnimator).taskViews = self.taskViews
            }
            
        }
    }
    
    func clearTaskViews()
    {
        self.clearTaskViews(true)
    }
    
    func clearTaskViews(down: Bool)
    {
        for taskView in self.view.subviews
        {
            if taskView is TaskView
            {
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: nil, animations: { () -> Void in
                    (taskView as TaskView).center = down ? CGPointMake(self.view.center.x, 1000) : CGPointMake(self.view.center.x, -self.taskViewSize)
                }, completion: { (completed) -> Void in
                    taskView.removeFromSuperview()
                })
//                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: nil, animations: { () -> Void in
//                    (taskView as TaskView).center.y = 1000 //self.view.frame.size.height + self.taskViewSize
//                    }, completion:{() -> Void in
//                        taskView.removeFromSuperview()
//                    }
//                )
            }
        }
    }
    
    func editorWillDismiss() {
        self.showsEditor = false
    }
    
    func editorReorderTask(from: Int, to: Int) {
        self.taskViews.insert(self.taskViews.removeAtIndex(from), atIndex: to)
        self.collapseTodoTasks()
    }
    
    func editorAddedTask() {
        self.loadCurrentFolder()
    }
    
    func loadNextFolder()
    {
        if let currentFolder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as? String
        {
            if let currentFolderIndex = find(self.taskHandler.folders(), currentFolder)
            {
                if currentFolderIndex == (self.taskHandler.folders().count - 1)
                {
                    NSUserDefaults.standardUserDefaults().setObject(self.taskHandler.folders().first, forKey: "currentFolder")
                } else {
                    NSUserDefaults.standardUserDefaults().setObject(self.taskHandler.folders()[currentFolderIndex + 1], forKey: "currentFolder")
                }
                NSUserDefaults.standardUserDefaults().synchronize()
                self.loadCurrentFolder()
            }
        }
    }
    
    func loadPreviousFolder()
    {
        if let currentFolder = NSUserDefaults.standardUserDefaults().objectForKey("currentFolder") as? String
        {
            if let currentFolderIndex = find(self.taskHandler.folders(), currentFolder)
            {
                if currentFolderIndex == 0
                {
                    NSUserDefaults.standardUserDefaults().setObject(self.taskHandler.folders().last, forKey: "currentFolder")
                } else {
                    NSUserDefaults.standardUserDefaults().setObject(self.taskHandler.folders()[currentFolderIndex - 1], forKey: "currentFolder")
                }
                NSUserDefaults.standardUserDefaults().synchronize()
                self.loadCurrentFolder(false)
            }
        }
    }
}
