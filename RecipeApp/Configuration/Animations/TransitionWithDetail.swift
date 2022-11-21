import UIKit

class TransitionWithDetail: NSObject, UIViewControllerAnimatedTransitioning {
    
    let animationDuration = 0.3
    var operation: UINavigationController.Operation = .push
    weak var storedContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        storedContext = transitionContext
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! AnimationDetailProtocol
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! AnimationDetailProtocol
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toViewController.view)
        
        if operation == .pop {
            containerView.bringSubviewToFront(fromViewController.view)
        }
        
        toViewController.view.setNeedsLayout()
        toViewController.view.layoutIfNeeded()
        
        let fromViews = fromViewController.viewsToAnimate()
        let toViews = toViewController.viewsToAnimate()
        
        //assert(fromViews.count == toViews.count, "Number of elements in fromViews and toViews have to be the same.")
        
        var intermediateViews = [UIView]()
        
        var toFrames = [CGRect]()
        
        for i in 0..<fromViews.count {
            let fromView = fromViews[i]
            let fromFrame = fromView.superview!.convert(fromView.frame, to: nil)
            fromView.alpha = 0
            
            let intermediateView = fromViewController.copyForView(fromView)
            intermediateView.frame = fromFrame
            
            containerView.addSubview(intermediateView)
            intermediateViews.append(intermediateView)
            
            let toView = toViews[i]
            
            var toFrame: CGRect
            if let tempToFrame = toViewController.frameForView?(toView) {
                toFrame = tempToFrame
            } else {
                toFrame = toView.superview!.convert(toView.frame, to: nil)
            }
            
            toFrames.append(toFrame)
            toView.alpha = 0
        }
        
        if operation == .push {
            toViewController.view.frame = fromViewController.view.frame.offsetBy(dx: 0, dy: fromViewController.view.frame.size.height)
        }
        
        UIView.animate(withDuration: 0.1) {
            let intermediateView = intermediateViews[9]
            intermediateView.alpha = 0
        }
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.2, options: [], animations: { () -> Void in
            if self.operation == .pop {
                fromViewController.view.frame = fromViewController.view.frame.offsetBy(dx: 0, dy: fromViewController.view.frame.size.height)
            } else {
                toViewController.view.frame = fromViewController.view.frame
            }
            
            for i in 0..<intermediateViews.count {
                let intermediateView = intermediateViews[i]
                if i != 9 {
                    intermediateView.frame = toFrames[i]
                }
            }
            
        }) { (_) -> Void in
            for i in 0..<intermediateViews.count {
                intermediateViews[i].removeFromSuperview()
                fromViews[i].alpha = 1
                if i == 9 {
                    UIView.animate(withDuration: 0.1, delay: 0.0) {
                        toViews[i].alpha = 1
                    }
                }
                toViews[i].alpha = 1
            }
            let finished = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(finished)
            
        }
    }
}
