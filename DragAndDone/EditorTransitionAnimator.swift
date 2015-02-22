//
//  EditorTransitionAnimator.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-05.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit
let topBarHeight:CGFloat = 64.0


class EditorTransitionAnimator: DNDTransitionAnimator {
    let moveFactor:CGFloat = 0.5
    var taskViews = Array<TaskView>()
    
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("ANIMATE TRANSITION")
        if dismissing
        {
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let containerView = transitionContext.containerView()
            let duration = self.transitionDuration(transitionContext)
            
            let editorEdge = EditorEdge(frame: CGRectMake(-3, 0, 3, containerView.bounds.size.height))

            toVC?.view.addSubview(editorEdge)

            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                toVC!.view.frame.origin.x = 0
                }, completion: { (completed) -> Void in
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                    })
                    editorEdge.removeFromSuperview()
                    transitionContext.completeTransition(true)
            })
            
        } else {
            let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
            
            println("FROM VC \(fromVc) TO VC:\(toVc)")
            
            let containerView = transitionContext.containerView()
            var frame:CGRect!
            //            frame = CGRectMake(-containerView.bounds.size.width * self.moveFactor, 0, containerView.bounds.size.width * self.moveFactor,containerView.bounds.size.height)
            frame = CGRectMake(0, 0, containerView.bounds.size.width * self.moveFactor,containerView.bounds.size.height)
            toVc?.view.frame = frame
            containerView.addSubview(toVc!.view)
            
            let editorEdge = EditorEdge(frame: CGRectMake(-3, 0, 3, containerView.bounds.size.height))
            fromVc?.view.addSubview(editorEdge)
            
            fromVc!.view.layer.zPosition = 100
//            containerView.addSubview(fromVc!.view)
            let duration = self.transitionDuration(transitionContext)
            
            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                fromVc!.view.center.x += containerView.bounds.size.width * self.moveFactor
                }, completion: { (completed) -> Void in
                    editorEdge.removeFromSuperview()
                    transitionContext.completeTransition(true)
            })
            
            //            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            //                fromVc?.view.center.x += containerView.bounds.size.width * self.moveFactor
            //                }, completion: { (completed) -> Void in
            //                    transitionContext.completeTransition(true)
            //            })
        }
        
        
        
    }
    
    override func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
}
