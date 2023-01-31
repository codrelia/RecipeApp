import UIKit

class TransitionWithSearch: NSObject, UIViewControllerAnimatedTransitioning {
    
    let animationDuration = 0.3
    var operation: UINavigationController.Operation = .push
    weak var storedContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        storedContext = transitionContext
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! AnimationSearchProtocol
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! AnimationSearchProtocol
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(toViewController.view)
        
        if operation == .pop {
            containerView.bringSubviewToFront(fromViewController.view)
        }
        
        toViewController.view.setNeedsLayout()
        toViewController.view.layoutIfNeeded()
        
        let fromViews = fromViewController.buttonToAnimate()
        let toViews = toViewController.buttonToAnimate()
        
        var intermediateViews = [UIView]()
        
        var toFrames = [CGRect]()
        
        for i in 0..<fromViews.count {
            let fromView = fromViews[i]
            let fromFrame = fromView.superview!.convert(fromView.frame, to: nil)
            fromView.alpha = 0
            
            let intermediateView = fromViewController.copyButton(fromView)
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
            toViewController.view.alpha = 0.0
        }
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0.2, options: [], animations: { () -> Void in
            if self.operation == .pop {
                fromViewController.view.alpha = 0.0
            } else {
                toViewController.view.alpha = 1.0
            }
            
            for i in 0..<intermediateViews.count {
                let intermediateView = intermediateViews[i]
                intermediateView.frame = toFrames[i]
            }
            
        }) { (_) -> Void in
            for i in 0..<intermediateViews.count {
                intermediateViews[i].removeFromSuperview()
                fromViews[i].alpha = 1
                toViews[i].alpha = 1
            }
            let finished = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(finished)
            
        }
    }
}
