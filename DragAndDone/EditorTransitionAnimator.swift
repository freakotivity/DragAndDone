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
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as DragAndDoneViewController
            let containerView = transitionContext.containerView()
            let duration = self.transitionDuration(transitionContext)
            
            let editorEdge = EditorEdge(frame: CGRectMake(-3, 0, 3, containerView.bounds.size.height))

            toVC.view.addSubview(editorEdge)

            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                toVC.topBar.frame.origin.x += containerView.bounds.size.width * self.moveFactor
                toVC.view.frame.origin.x = 0
                }, completion: { (completed) -> Void in
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                    })
                    editorEdge.removeFromSuperview()
                    transitionContext.completeTransition(true)
            })
            
        } else {
            let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
            let fromVc = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as DragAndDoneViewController
            
            println("FROM VC \(fromVc) TO VC:\(toVc)")
            
            let containerView = transitionContext.containerView()
            var frame:CGRect!
            //            frame = CGRectMake(-containerView.bounds.size.width * self.moveFactor, 0, containerView.bounds.size.width * self.moveFactor,containerView.bounds.size.height)
            frame = CGRectMake(0, topBarHeight, containerView.bounds.size.width * self.moveFactor,containerView.bounds.size.height - topBarHeight)
            toVc?.view.frame = frame
            containerView.addSubview(toVc!.view)
            
            let editorEdge = EditorEdge(frame: CGRectMake(-3, topBarHeight, 3, containerView.bounds.size.height))
//            fromVc.view.addSubview(editorEdge)
            
            fromVc.view.layer.zPosition = 1000
//            containerView.addSubview(fromVc.slideView)
            let duration = self.transitionDuration(transitionContext)
            
            UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                fromVc.topBar.frame.origin.x -= containerView.bounds.size.width * self.moveFactor
                fromVc.view.center.x += containerView.bounds.size.width * self.moveFactor
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
