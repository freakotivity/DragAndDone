//
//  TransitionAnimator.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-04.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
        var dismissing:Bool = false
        
        func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
            //////println("ANIMATE TRANSITION")
            if dismissing
            {
                let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
                let containerView = transitionContext.containerView()
                //        toVc?.view.alpha = 0.0
                let duration = self.transitionDuration(transitionContext)
                
                UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    fromVC!.view.frame.origin.x = containerView.bounds.size.width
                    }, completion: { (completed) -> Void in
                        transitionContext.completeTransition(true)
                })
                
            } else {
                let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
                let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
                
                let containerView = transitionContext.containerView()
                var frame = CGRectMake(containerView.bounds.size.width, 66, containerView.bounds.size.width * 2 / 3,containerView.bounds.size.height - 66)
                toVc?.view.frame = frame
                containerView.addSubview(toVc!.view)
                let duration = self.transitionDuration(transitionContext)
                UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    toVc!.view.frame.origin.x = containerView.bounds.size.width / 3
                    fromVc!.view.frame.origin.x = -containerView.bounds.size.width / 6
                }, completion: { (completed) -> Void in
                    transitionContext.completeTransition(true)
                })
            }
            
            
            
        }
        
        func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
            return 0.5
        }
}
