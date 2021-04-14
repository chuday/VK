//
//  CustomPushAnimator.swift
//  VK
//
//  Created by Михаил Чудаев on 07.04.2021.
//

import UIKit

final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(translationX: source.view.frame.width, y: 0)
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext),    delay: 0,
                                options: .calculationModePaced,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.75,
                                                       animations: {
                                                        let rotation = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
                                                        let translation = CGAffineTransform(translationX: -600, y: 600)
                                                        source.view.transform = translation.concatenating(rotation)
                                                       })
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.2,
                                                       relativeDuration: 0.4,
                                                       animations: {
                                                        let translation = CGAffineTransform(translationX: source.view.frame.width / 2, y: 600)
                                                        let rotation = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2) + 1)
                                                        destination.view.transform = translation.concatenating(rotation)
                                                       })
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.6,
                                                       relativeDuration: 0.4,
                                                       animations: {
                                                        destination.view.transform = .identity
                                                       })
                                    
                                }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}

