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
//  The above copyright notice and this permission notice sCodeLayout be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SCodeLayout THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import Adrenaline

public extension UIView {
    @inlinable
    @discardableResult
    func addSubview<T: UIView>(_ type: T.Type, apply work: (T) -> Void) -> T {
        return T().apply {
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            $0.layer.drawsAsynchronously = true
            $0.isOpaque = true
            
            addSubview($0)
            work($0)
        }
    }
    
    @inlinable
    @discardableResult
    func addSubview<T: UIView>(_ view: T, apply work: (T) -> Void) -> T {
        return view.apply {
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            $0.layer.drawsAsynchronously = true
            $0.isOpaque = true
            
            addSubview($0)
            work($0)
        }
    }
}

public extension UIView {
    @inlinable
    @discardableResult
    func addConstraint(attribute attribute1: NSLayoutConstraint.Attribute, relatedBy relation: NSLayoutConstraint.Relation = .equal, toItem item: UIView? = nil, toAttribute attribute2: NSLayoutConstraint.Attribute = .notAnAttribute, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self, attribute: attribute1, relatedBy: relation, toItem: item, attribute: attribute2, multiplier: multiplier, constant: constant).apply {
            superview?.addConstraint($0)
        }
    }
}

public extension UIView {
    @inlinable
    func anchorTop(topOf view: UIView, constant: CGFloat = 0) {
        topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
    }
    
    @inlinable
    func anchorTop(bottomOf view: UIView, constant: CGFloat = 0) {
        topAnchor.constraint(equalTo: view.bottomAnchor, constant: constant).isActive = true
    }
    
    @inlinable
    func anchorRight(rightOf view: UIView, constant: CGFloat = 0) {
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: constant).isActive = true
    }
    
    @inlinable
    func anchorRight(leftOf view: UIView, constant: CGFloat = 0) {
        rightAnchor.constraint(equalTo: view.leftAnchor, constant: constant).isActive = true
    }
    
    @inlinable
    func anchorBottom(topOf view: UIView, constant: CGFloat = 0) {
        bottomAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
    }
    
    @inlinable
    func anchorBottom(bottomOf view: UIView, constant: CGFloat = 0) {
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant).isActive = true
    }
    
    @inlinable
    func anchorLeft(rightOf view: UIView, constant: CGFloat = 0) {
        leftAnchor.constraint(equalTo: view.rightAnchor, constant: constant).isActive = true
    }
    
    @inlinable
    func anchorLeft(leftOf view: UIView, constant: CGFloat = 0) {
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant).isActive = true
    }
}

public extension UIView {
    @inlinable
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        layer.mask = CAShapeLayer().apply {
            $0.path = path.cgPath
        }
    }
}
