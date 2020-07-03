//
//  CodeLayout
//
//  Copyright (c) 2020 Wellington Marthas
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

public final class UISlidingNavigationController: UINavigationController {
    public final class SlidingTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
        private let operation: Operation
        
        public init(operation: Operation) {
            self.operation = !UIApplication.shared.leftToRightLayoutDirection ? operation : (operation != .pop ? .pop : .push)
        }
        
        public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 0.25
        }
        
        public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            guard let fromView = transitionContext.viewController(forKey: .from)?.view,
                  let toView = transitionContext.viewController(forKey: .to)?.view else {
                return
            }
            
            var width = transitionContext.containerView.frame.width
            
            if operation == .pop {
                width = -width
                transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
            }
            else {
                transitionContext.containerView.addSubview(toView)
            }
            
            toView.transform = CGAffineTransform(translationX: -width , y: 0)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toView.transform = .identity
                fromView.transform = CGAffineTransform(translationX: width, y: 0)
            }) { _ in
                toView.transform = .identity
                fromView.transform = .identity
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
    
    private var interactiveTransition: UIPercentDrivenInteractiveTransition?
    
    public override func loadView() {
        super.loadView()
        
        view.addGestureRecognizer(UIScreenEdgePanGestureRecognizer(target: self, action: #selector(didPan)).apply {
            $0.maximumNumberOfTouches = 1
            $0.edges = UIApplication.shared.leftToRightLayoutDirection ? .left : .right
        })
        
        delegate = self
    }
    
    @objc
    private func didPan(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        guard let view = recognizer.view else {
            interactiveTransition = nil
            return
        }
        
        let percent = abs(recognizer.translation(in: view).x / view.bounds.size.width)
        
        switch recognizer.state {
        case .began:
            interactiveTransition = UIPercentDrivenInteractiveTransition()
            popViewController(animated: true)
            
        case .changed:
            interactiveTransition?.update(percent)
            
        case .ended:
            if percent > 0.25 || (percent > 0.15 && recognizer.velocity(in: view).y > 0) {
                interactiveTransition?.finish()
            }
            else {
                interactiveTransition?.cancel()
            }
            
            interactiveTransition = nil
            
        default: break
        }
    }
}

extension UISlidingNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlidingTransitioning(operation: operation)
    }
}
