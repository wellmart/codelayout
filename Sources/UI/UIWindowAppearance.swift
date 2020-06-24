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

public protocol UIWindowAppearance {
    var backgroundColor: UIColor { get }
    var buttonCornerRadius: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var font: UIFont { get }
    var highlightedTextColor: UIColor { get }
    var textColor: UIColor { get }
    var textFieldFont: UIFont { get }
    var tintColor: UIColor { get }
}

public extension UIWindowAppearance {
    @inlinable
    func apply(on window: UIWindow) {
        window.backgroundColor = backgroundColor
        window.tintColor = tintColor
    }
    
    @inlinable
    func apply(on tabBar: UITabBar) {
        tabBar.barTintColor = backgroundColor
        tabBar.tintColor = textColor
        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }
    
    @inlinable
    func apply(on navigationBar: UINavigationBar) {
        navigationBar.barTintColor = backgroundColor
        navigationBar.titleTextAttributes = [.font: font, .foregroundColor: textColor]
        //navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        
        if #available(iOS 11.0, *) {
            navigationBar.prefersLargeTitles = true
        }
        
        navigationBar.setBackgroundImage(backgroundColor.image(), for: .default)
    }
    
    @inlinable
    func apply(on collectionView: UICollectionView) {
        collectionView.backgroundColor = backgroundColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.clipsToBounds = false
    }
    
    @inlinable
    func apply(on label: UILabel) {
        label.font = font
        label.textColor = textColor
    }
    
    @inlinable
    func apply(on button: UIButton) {
        let highlightedImage = tintColor.image()
        
        button.setTitleColor(textColor, for: .normal)
        button.setTitleColor(highlightedTextColor, for: .highlighted)
        button.setTitleColor(highlightedTextColor, for: .selected)
        button.setTitleColor(highlightedTextColor, for: [.highlighted, .selected])
        
        button.setBackgroundImage(highlightedImage, for: .highlighted)
        button.setBackgroundImage(highlightedImage, for: .selected)
        button.setBackgroundImage(highlightedImage, for: [.highlighted, .selected])
        
        button.corner(radius: buttonCornerRadius)
    }
    
    @inlinable
    func apply(on textField: UITextField) {
        textField.font = textFieldFont
        textField.textColor = textColor
    }
    
    @inlinable
    func apply(on switchControl: UISwitch) {
        switchControl.onTintColor = tintColor
        switchControl.thumbTintColor = backgroundColor
    }
    
    @inlinable
    func apply(on view: UIView) {
        switch view {
        case let window as UIWindow:
            apply(on: window)
            
        case let tabBar as UITabBar:
            apply(on: tabBar)
            
        case let navigationBar as UINavigationBar:
            apply(on: navigationBar)
            
        case let collectionView as UICollectionView:
            apply(on: collectionView)
            
        case let label as UILabel:
            apply(on: label)
            
        case let button as UIButton:
            apply(on: button)
            
        case let textField as UITextField:
            apply(on: textField)
            
        case let switchControl as UISwitch:
            apply(on: switchControl)
            
        default: break
        }
    }
    
    @inlinable
    func createNavigationBarButton(title: String, font: UIFont? = nil, baselineOffset: CGFloat = 0, target: AnyObject?, action: Selector) -> UIBarButtonItem? {
        let attributes: [NSAttributedString.Key: Any] = [.font: font ?? self.font, .foregroundColor: textColor, .baselineOffset: baselineOffset]
        
        return UIBarButtonItem(title: title, style: .plain, target: target, action: action).apply {
            $0.setTitleTextAttributes(attributes, for: .normal)
            $0.setTitleTextAttributes(attributes, for: .highlighted)
            
            $0.setTitleTextAttributes([.font: font ?? self.font, .baselineOffset: baselineOffset], for: .disabled)
        }
    }
    
    @inlinable
    func createTabBarButton(title: String, font: UIFont, badgeFont: UIFont? = nil, positionVertical: CGFloat = 0) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: title, image: nil, selectedImage: nil).apply {
            $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -positionVertical)
            $0.setTitleTextAttributes([.font: font], for: .normal)
        }
        
        if #available(iOS 10, *) {
            tabBarItem.badgeColor = tintColor
            
            if let badgeFont = badgeFont {
                tabBarItem.setBadgeTextAttributes([.font: badgeFont], for: .normal)
                tabBarItem.setBadgeTextAttributes([.font: badgeFont], for: .selected)
            }
        }
        
        return tabBarItem
    }
}
