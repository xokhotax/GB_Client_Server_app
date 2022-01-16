//
//  CustomAnimationOpener.swift
//  VKInterface
//
//  Created by Ivan Okhota on 13.12.2021.
//

import UIKit


//MARK: Rotation

final class CustomAnimationOpener: NSObject, UIViewControllerAnimatedTransitioning  {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 3
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let sourceController = transitionContext.viewController(forKey: .from),
          let destinationController = transitionContext.viewController(forKey: .to)
    else {return}
    
    transitionContext.containerView.addSubview(destinationController.view)
    let destinationControllerViewFrame = destinationController.view.frame
    let destinationControllerViewBounds = destinationController.view.bounds
    let destinationControllerViewTransform = destinationController.view.transform
    
    destinationController.view.frame = destinationController.view.frame.offsetBy(dx: destinationController.view.frame.width, dy: 0)
    
    destinationController.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
    
    destinationController.view.transform = destinationController.view.transform.rotated(by: -.pi / 2)
    
    UIView.animate(withDuration: self.transitionDuration(using: transitionContext) * 0.5) {
    } completion: { _ in
      UIView.animate(withDuration: self.transitionDuration(using: transitionContext) * 0.5) {
        destinationController.view.frame = destinationControllerViewFrame
        destinationController.view.bounds = destinationControllerViewBounds
        destinationController.view.transform = destinationControllerViewTransform
      } completion: { isTrue in
        transitionContext.completeTransition(isTrue)
      }
    }
  }
}
