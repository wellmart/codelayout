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

public final class UIPoppingNavigationController: UINavigationController {
    private var interactiveTransition: UIPercentDrivenInteractiveTransition?
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        
        view.addGestureRecognizer(UIScreenEdgePanGestureRecognizer(target: self, action: #selector(didPan)).apply {
            $0.edges = .left
            $0.maximumNumberOfTouches = 1
        })
    }
    
    @objc
    private func didPan(_ panGesture: UIScreenEdgePanGestureRecognizer) {
        guard let view = panGesture.view else {
            interactiveTransition = nil
            return
        }
        
        let percent = panGesture.translation(in: view).x / view.bounds.size.width
        
        if panGesture.state == .began {
            interactiveTransition = UIPercentDrivenInteractiveTransition()
            popViewController(animated: true)
        }
        else if panGesture.state == .changed {
            interactiveTransition?.update(percent)
        }
        else if panGesture.state == .ended {
            if percent > 0.25 {
                interactiveTransition?.finish()
            }
            else {
                interactiveTransition?.cancel()
            }
            
            interactiveTransition = nil
        }
    }
}

extension UIPoppingNavigationController: UINavigationControllerDelegate {
    private final class AnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
        private let operation: Operation
        
        init(operation: Operation) {
            self.operation = operation
        }
        
        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 0.25
        }
        
        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            guard let fromView = transitionContext.viewController(forKey: .from)?.view, let toView = transitionContext.viewController(forKey: .to)?.view else {
                return
            }
            
            let width = transitionContext.containerView.frame.width
            
            let transform = CGAffineTransform(translationX: width, y: 0)
            let transformBackView = CGAffineTransform(translationX: -width , y: 0)
            
            if operation == .push {
                toView.transform = transform
                transitionContext.containerView.addSubview(toView)
                
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    toView.transform = .identity
                    fromView.transform = transformBackView
                }) { _ in
                    toView.transform = .identity
                    fromView.transform = .identity
                    
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            }
            else if operation == .pop {
                toView.transform = transformBackView
                transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
                
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    toView.transform = .identity
                    fromView.transform = transform
                }) { _ in
                    toView.transform = .identity
                    fromView.transform = .identity
                    
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
            }
        }
    }
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatedTransitioning(operation: operation)
    }
}
