//
//  EditorPresentationController.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-11.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class EditorPresentationController: UIPresentationController {
    override func presentationTransitionWillBegin() {
        // Add the dimming view and the presented view to the heirarchy
        let dummyView = UIView(frame: CGRectMake(self.containerView.frame.size.width / 2, 0, self.containerView.frame.size.width / 2, self.containerView.frame.size.height))
        self.containerView.addSubview(self.presentedView())
        self.containerView.addSubview(dummyView)
        
        if self.presentedViewController.respondsToSelector("tappedDimmingView")
        {
            let tap = UITapGestureRecognizer(target: self.presentedViewController, action: "tappedDimmingView")
            dummyView.addGestureRecognizer(tap)
        }
        
    }
    
//    override func presentationTransitionDidEnd(completed: Bool)  {
//        // If the presentation didn't complete, remove the dimming view
//        if !completed {
//            self.dimmingView.removeFromSuperview()
//        }
//    }
    
//    override func dismissalTransitionWillBegin()  {
//        // Fade out the dimming view alongside the transition
//        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
//            transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
//                self.dimmingView.alpha  = 0.0
//                }, completion:nil)
//        }
//    }
    
//    override func dismissalTransitionDidEnd(completed: Bool) {
//        // If the dismissal completed, remove the dimming view
//        if completed {
//            self.dimmingView.removeFromSuperview()
//        }
//    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        // We don't want the presented view to fill the whole container view, so inset it's frame
        var frame = self.containerView.bounds;
        //        frame = CGRectInset(frame, 50.0, 50.0)
        
        return frame
    }
}
