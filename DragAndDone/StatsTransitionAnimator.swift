//
//  StatsTransitionAnimator.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-05.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class StatsTransitionAnimator: DNDTransitionAnimator {
    var taskViews = Array<TaskView>()
    let moveFactor:CGFloat = 0.5
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("ANIMATE TRANSITION")
        if dismissing
        {
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let containerView = transitionContext.containerView()
            let duration = self.transitionDuration(transitionContext)
            
            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//                for tv in self.taskViews
//                {
//                    if tv.task!.done
//                    {
//                        tv.center.x = (toVC as DragAndDoneViewController).doneXPosition
//                    } else {
//                        tv.center.x = (toVC as DragAndDoneViewController).todoXPosition
//                    }
//                }
                toVC!.view.frame.origin.x = 0
                fromVC!.view.frame.origin.x = containerView.bounds.size.width
                }, completion: { (completed) -> Void in
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        (toVC as DragAndDoneViewController).separatorLine.alpha = 1.0
                    })
                    transitionContext.completeTransition(true)
            })
            
        } else {
            
            let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            
            println("FROM VC \(fromVc) TO VC:\(toVc)")
            
            let containerView = transitionContext.containerView()
            var frame:CGRect!
            frame = CGRectMake(containerView.bounds.size.width, 0, containerView.bounds.size.width * self.moveFactor,containerView.bounds.size.height)
            toVc?.view.frame = frame
            containerView.addSubview(toVc!.view)
            let duration = self.transitionDuration(transitionContext)
            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//                for tv in self.taskViews
//                {
//                    if tv.task!.done
//                    {
//                        tv.center.x = (fromVc as DragAndDoneViewController).todoXPosition
//                    } else {
//                        tv.frame.origin.x = -tv.frame.size.width
//                    }
//                }
                fromVc?.view.frame.origin.x -= containerView.bounds.size.width * self.moveFactor
                toVc!.view.frame.origin.x = containerView.bounds.size.width * self.moveFactor
                }, completion: { (completed) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
        
        
        
    }
    
    override func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
}
