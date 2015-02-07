//
//  CongratsPresentationController.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-05.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class CongratsPresentationController: UIPresentationController {
    lazy var dimmingView :UIView = {
        let fx = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let fxView = UIVisualEffectView(effect: fx)
        fxView.frame = self.containerView!.bounds
        fxView.alpha = 1.0
        return fxView
        //        return UIView()
        }()
    
    override func presentationTransitionWillBegin() {
        // Add the dimming view and the presented view to the heirarchy
        self.dimmingView.frame = self.containerView.bounds
        self.containerView.addSubview(self.dimmingView)
        self.containerView.addSubview(self.presentedView())
        
        if self.presentedViewController.respondsToSelector("tappedDimmingView")
        {
            let tap = UITapGestureRecognizer(target: self.presentedViewController, action: "tappedDimmingView")
            self.containerView.addGestureRecognizer(tap)
        }
        
        // Fade in the dimming view alongside the transition
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.dimmingView.alpha  = 1.0
                }, completion:nil)
        }
    }
    
    override func presentationTransitionDidEnd(completed: Bool)  {
        // If the presentation didn't complete, remove the dimming view
        if !completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin()  {
        // Fade out the dimming view alongside the transition
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.dimmingView.alpha  = 0.0
                }, completion:nil)
        }
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        // If the dismissal completed, remove the dimming view
        if completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        // We don't want the presented view to fill the whole container view, so inset it's frame
        var frame = self.containerView.bounds;
        //        frame = CGRectInset(frame, 50.0, 50.0)
        
        return frame
    }}
