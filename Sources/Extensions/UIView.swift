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
import Adrenaline

public extension UIView {
    static func shake(_ view: UIView, duration: TimeInterval = 0.5, translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            view.transform = CGAffineTransform(translationX: translation, y: 0)
        }
        
        propertyAnimator.addAnimations({
            view.transform = .identity
        }, delayFactor: 0.2)
        
        propertyAnimator.startAnimation()
    }
}

public extension UIView {
    @inlinable
    @discardableResult
    func anchor(top constant: CGFloat) -> NSLayoutConstraint {
        guard let superview = superview else {
            preconditionFailure("Superview was not specified")
        }
        
        return anchor(top: superview.topAnchor, constant: constant)
    }
    
    @inlinable
    @discardableResult
    func anchor(top anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        return topAnchor.constraint(equalTo: anchor, constant: constant).apply {
            $0.isActive = true
        }
    }
    
    @inlinable
    @discardableResult
    func anchor(trailing constant: CGFloat) -> NSLayoutConstraint {
        guard let superview = superview else {
            preconditionFailure("Superview was not specified")
        }
        
        return anchor(trailing: superview.trailingAnchor, constant: constant)
    }
    
    @inlinable
    @discardableResult
    func anchor(trailing anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        return trailingAnchor.constraint(equalTo: anchor, constant: -constant).apply {
            $0.isActive = true
        }
    }
    
    @inlinable
    @discardableResult
    func anchor(right constant: CGFloat) -> NSLayoutConstraint {
        guard let superview = superview else {
            preconditionFailure("Superview was not specified")
        }
        
        return anchor(right: superview.rightAnchor, constant: constant)
    }
    
    @inlinable
    @discardableResult
    func anchor(right anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        return rightAnchor.constraint(equalTo: anchor, constant: -constant).apply {
            $0.isActive = true
        }
    }
    
    @inlinable
    @discardableResult
    func anchor(bottom constant: CGFloat) -> NSLayoutConstraint {
        guard let superview = superview else {
            preconditionFailure("Superview was not specified")
        }
        
        return anchor(bottom: superview.bottomAnchor, constant: constant)
    }
    
    @inlinable
    @discardableResult
    func anchor(bottom anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        return bottomAnchor.constraint(equalTo: anchor, constant: -constant).apply {
            $0.isActive = true
        }
    }
    
    @inlinable
    @discardableResult
    func anchor(leading constant: CGFloat) -> NSLayoutConstraint {
        guard let superview = superview else {
            preconditionFailure("Superview was not specified")
        }
        
        return anchor(leading: superview.leadingAnchor, constant: constant)
    }
    
    @inlinable
    @discardableResult
    func anchor(leading anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        return leadingAnchor.constraint(equalTo: anchor, constant: constant).apply {
            $0.isActive = true
        }
    }
    
    @inlinable
    @discardableResult
    func anchor(left constant: CGFloat) -> NSLayoutConstraint {
        guard let superview = superview else {
            preconditionFailure("Superview was not specified")
        }
        
        return anchor(left: superview.leftAnchor, constant: constant)
    }
    
    @inlinable
    @discardableResult
    func anchor(left anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        return leftAnchor.constraint(equalTo: anchor, constant: constant).apply {
            $0.isActive = true
        }
    }
    
    @inlinable
    @discardableResult
    func anchor(width constant: CGFloat) -> NSLayoutConstraint {
        return widthAnchor.constraint(equalToConstant: constant).apply {
            $0.isActive = true
        }
    }
    
    @inlinable
    @discardableResult
    func anchor(width anchor: NSLayoutDimension, constant: CGFloat = 0) -> NSLayoutConstraint {
        return widthAnchor.constraint(equalTo: anchor, constant: -constant).apply {
            $0.isActive = true
        }
    }
    
    @inlinable
    @discardableResult
    func anchor(height constant: CGFloat) -> NSLayoutConstraint {
        return heightAnchor.constraint(equalToConstant: constant).apply {
            $0.isActive = true
        }
    }
    
    @inlinable
    @discardableResult
    func anchor(height anchor: NSLayoutDimension, constant: CGFloat = 0) -> NSLayoutConstraint {
        return heightAnchor.constraint(equalTo: anchor, constant: -constant).apply {
            $0.isActive = true
        }
    }
    
    @inlinable
    @discardableResult
    func anchor(centerX constant: CGFloat) -> NSLayoutConstraint {
        guard let superview = superview else {
            preconditionFailure("Superview was not specified")
        }
        
        return anchor(centerX: superview.centerXAnchor, constant: constant)
    }
    
    @inlinable
    @discardableResult
    func anchor(centerX anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        return centerXAnchor.constraint(equalTo: anchor, constant: constant).apply {
            $0.isActive = true
        }
    }
    
    @inlinable
    @discardableResult
    func anchor(centerY constant: CGFloat) -> NSLayoutConstraint {
        guard let superview = superview else {
            preconditionFailure("Superview was not specified")
        }
        
        return anchor(centerY: superview.centerYAnchor, constant: constant)
    }
    
    @inlinable
    @discardableResult
    func anchor(centerY anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        return centerYAnchor.constraint(equalTo: anchor, constant: constant).apply {
            $0.isActive = true
        }
    }
}

public extension UIView {
    @inlinable
    @discardableResult
    func addConstraint(attribute attribute1: NSLayoutConstraint.Attribute, relatedBy relation: NSLayoutConstraint.Relation = .equal, toItem item: UIView? = nil, toAttribute attribute2: NSLayoutConstraint.Attribute = .notAnAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        guard let superview = superview else {
            preconditionFailure("Superview was not specified")
        }
        
        return NSLayoutConstraint(item: self, attribute: attribute1, relatedBy: relation, toItem: item, attribute: attribute2, multiplier: multiplier, constant: constant).apply {
            superview.addConstraint($0)
        }
    }
}

public extension UIView {
    @discardableResult
    func addSublayer<T: CALayer>(_ type: T.Type, apply work: (T) -> Void) -> T {
        return T().apply {
            $0.contentsScale = UIScreen.main.scale
            layer.addSublayer($0)
            
            work($0)
        }
    }
    
    func removeAllSublayers() {
        guard let sublayers = layer.sublayers else {
            return
        }
        
        for sublayer in sublayers {
            sublayer.removeFromSuperlayer()
        }
    }
}

public extension UIView {
    @discardableResult
    func addSubview<T: UIView>(_ type: T.Type, apply work: (T) -> Void) -> T {
        return T().apply {
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview($0)
            UIWindow.appearance?.apply(on: $0)
            
            work($0)
        }
    }
    
    @discardableResult
    func addSubview<T: UIView>(_ view: T, apply work: (T) -> Void) -> T {
        return view.apply {
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview($0)
            UIWindow.appearance?.apply(on: $0)
            
            work($0)
        }
    }
}

public extension UIView {
    @discardableResult
    func addPanGesture(target: Any, action: Selector?, delegate: UIGestureRecognizerDelegate? = nil) -> UIPanGestureRecognizer {
        let recognizer = UIPanGestureRecognizer(target: target, action: action).apply {
            $0.maximumNumberOfTouches = 1
            $0.delegate = delegate
        }
        
        addGestureRecognizer(recognizer)
        return recognizer
    }
    
    @discardableResult
    func addTapGesture(target: Any, action: Selector?, delegate: UIGestureRecognizerDelegate? = nil) -> UITapGestureRecognizer {
        let recognizer = UITapGestureRecognizer(target: target, action: action).apply {
            $0.numberOfTapsRequired = 1
            $0.numberOfTouchesRequired = 1
            $0.delegate = delegate
        }
        
        addGestureRecognizer(recognizer)
        return recognizer
    }
}

public extension UIView {
    @inlinable
    func corner(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
