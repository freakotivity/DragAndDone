//
//  AddTaskAnimator.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-12.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class AddTaskAnimator: DNDTransitionAnimator {
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("ANIMATE TRANSITION")
        if dismissing
        {
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let containerView = transitionContext.containerView()
            let duration = self.transitionDuration(transitionContext)
            
            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                //                self.animation()
                fromVC!.view.alpha = 0.0
                }, completion: { (completed) -> Void in
                    transitionContext.completeTransition(true)
            })
            
        } else {
            let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            
            println("FROM VC \(fromVc) TO VC:\(toVc)")
            
            let containerView = transitionContext.containerView()
            var frame:CGRect!
//            frame = CGRectMake(0, 20, 300, 400)
            frame = CGRectMake(5, 5, containerView.frame.size.width - 10, containerView.frame.size.height - 271)
            toVc?.view.frame = frame
            toVc?.view.center.x = containerView.center.x
            toVc?.view.alpha = 0.0
            containerView.addSubview(toVc!.view)
            let duration = self.transitionDuration(transitionContext)
            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                toVc!.view.alpha = 1.0
                }, completion: { (completed) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
        
        
        
    }
    
    override func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }

}
