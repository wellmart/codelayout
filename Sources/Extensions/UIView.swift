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

@available(iOS 9, *)
public extension UIView {
    @inlinable
    @discardableResult
    func anchor(top constant: CGFloat) -> NSLayoutConstraint {
        return anchor(top: superview!.topAnchor, constant: constant)
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
    func anchor(right constant: CGFloat) -> NSLayoutConstraint {
        return anchor(right: superview!.rightAnchor, constant: constant)
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
        return anchor(bottom: superview!.bottomAnchor, constant: constant)
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
    func anchor(left constant: CGFloat) -> NSLayoutConstraint {
        return anchor(left: superview!.leftAnchor, constant: constant)
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
    func anchor(centerX constant: CGFloat) {
        anchor(centerX: superview!.centerXAnchor, constant: constant)
    }
    
    @inlinable
    func anchor(centerX anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    
    @inlinable
    func anchor(centerY constant: CGFloat) {
        anchor(centerY: superview!.centerYAnchor, constant: constant)
    }
    
    @inlinable
    func anchor(centerY anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
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
