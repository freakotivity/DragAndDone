//
//  EditorTransitionAnimator.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-05.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class EditorTransitionAnimator: DNDTransitionAnimator {
    
    var taskViews = Array<TaskView>()
    
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("ANIMATE TRANSITION")
        if dismissing
        {
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let containerView = transitionContext.containerView()
            let duration = self.transitionDuration(transitionContext)
            
            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                for tv in self.taskViews
                {
                    if tv.done
                    {
                        tv.center.x -= 60.0
                    } else {
                        tv.center.x -= 160.0
                    }
                }

                    fromVC!.view.frame.origin.x = -containerView.bounds.size.width * 2 / 3
                }, completion: { (completed) -> Void in
                    transitionContext.completeTransition(true)
            })
            
        } else {
            let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            
            println("FROM VC \(fromVc) TO VC:\(toVc)")
            
            let containerView = transitionContext.containerView()
            var frame:CGRect!
                frame = CGRectMake(-containerView.bounds.size.width * 2 / 3, 66, containerView.bounds.size.width * 2 / 3,containerView.bounds.size.height - 66)
            toVc?.view.frame = frame
            containerView.addSubview(toVc!.view)
            let duration = self.transitionDuration(transitionContext)
            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in

                for tv in self.taskViews
                {
                    if tv.done
                    {
                    tv.center.x += 60.0
                    } else {
                        tv.center.x += 160.0
                    }
                }
                    toVc!.view.frame.origin.x = 0
                }, completion: { (completed) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
        
        
        
    }
    
    override func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
}
