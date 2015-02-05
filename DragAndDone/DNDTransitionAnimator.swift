//
//  DNDTransitionAnimator.swift
//  DragAndDone
//
//  Created by Ricardo Gonzalez on 2015-02-05.
//  Copyright (c) 2015 Gabriel Kroll. All rights reserved.
//

import UIKit

class DNDTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var dismissing:Bool = false

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 2.0
    }
}
