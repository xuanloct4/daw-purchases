//
//  NavigationViewController.swift
//  daw-purchases
//
//  Created by Tran Loc on 13/09/2021.
//  Copyright © 2021 Tran Loc. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    /**
     Pop current view controller to previous view controller.
     
     - parameter type:     transition animation type.
     - parameter duration: transition animation duration.
     */
    func pop(transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.popViewController(animated: false)
    }
    
    /**
     Push a new view controller on the view controllers's stack.
     
     - parameter vc:       view controller to push.
     - parameter type:     transition animation type.
     - parameter duration: transition animation duration.
     */
    func push(viewController vc: UIViewController, transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.pushViewController(vc, animated: false)
    }
    
    private func addTransition(transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = type
        self.view.layer.add(transition, forKey: nil)
    }
    
}



class SimpleOver: NSObject, UIViewControllerAnimatedTransitioning {
    
    var popStyle: Bool = false
    
    var offset: CGFloat = 200
    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.80
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if popStyle {
            
            animatePop(using: transitionContext)
            return
        }
        
        let fz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let tz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let f = transitionContext.finalFrame(for: tz)
        
        let fOff = f.offsetBy(dx: f.width, dy: offset)
        tz.view.frame = fOff
        
        transitionContext.containerView.insertSubview(tz.view, aboveSubview: fz.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                tz.view.frame = f
            }, completion: {_ in
                transitionContext.completeTransition(true)
            })
    }
    
    func animatePop(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let tz = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let f = transitionContext.initialFrame(for: fz)
        let fOffPop = f.offsetBy(dx: f.width, dy: offset)
        
        transitionContext.containerView.insertSubview(tz.view, belowSubview: fz.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fz.view.frame = fOffPop
            }, completion: {_ in
                transitionContext.completeTransition(true)
            })
    }
}
