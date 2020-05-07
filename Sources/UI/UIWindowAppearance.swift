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
    var largeTitleFont: UIFont { get }
    var textColor: UIColor { get }
    var textFieldFont: UIFont { get }
    var tintColor: UIColor { get }
}

public extension UIWindowAppearance {
    @inlinable
    func apply<T: UIView>(on view: T) {
        switch view {
        case let window as UIWindow:
            window.backgroundColor = backgroundColor
            window.tintColor = tintColor
            
        case let tabBar as UITabBar:
            tabBar.barTintColor = backgroundColor
            tabBar.tintColor = textColor
            tabBar.isTranslucent = false
            tabBar.backgroundImage = UIImage()
            tabBar.shadowImage = UIImage()
            
        case let navigationBar as UINavigationBar:
            navigationBar.barTintColor = backgroundColor
            navigationBar.titleTextAttributes = [.font: font, .foregroundColor: textColor]
            navigationBar.isTranslucent = false
            navigationBar.shadowImage = UIImage()
            
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            
            if #available(iOS 11, *) {
                navigationBar.prefersLargeTitles = true
                navigationBar.largeTitleTextAttributes = [.font: largeTitleFont, .foregroundColor: textColor]
            }
            
        case let collectionView as UICollectionView:
            collectionView.backgroundColor = backgroundColor
            collectionView.showsVerticalScrollIndicator = false
            collectionView.alwaysBounceVertical = true
            collectionView.clipsToBounds = false
            
        case let label as UILabel:
            label.font = font
            label.textColor = textColor
            
        case let button as UIButton:
            let highlightedImage = tintColor.image()
            
            button.setTitleColor(textColor, for: .normal)
            button.setTitleColor(highlightedTextColor, for: .highlighted)
            button.setTitleColor(highlightedTextColor, for: .selected)
            button.setTitleColor(highlightedTextColor, for: [.highlighted, .selected])
            
            button.setBackgroundImage(highlightedImage, for: .highlighted)
            button.setBackgroundImage(highlightedImage, for: .selected)
            button.setBackgroundImage(highlightedImage, for: [.highlighted, .selected])
            
            button.corner(radius: buttonCornerRadius)
            
        case let textField as UITextField:
            textField.font = textFieldFont
            textField.textColor = textColor
            textField.autocorrectionType = .no
            
        case let switchControl as UISwitch:
            switchControl.onTintColor = tintColor
            switchControl.thumbTintColor = backgroundColor
            
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
