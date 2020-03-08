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
    var font: UIFont { get }
    var textColor: UIColor { get }
    var textFieldFont: UIFont { get }
    var tintColor: UIColor { get }
}

public extension UIWindowAppearance {
    @inlinable
    func apply<T: UIView>(on view: T) {
        switch view {
        case let window as UIWindow:
            window.apply {
                $0.backgroundColor = backgroundColor
                $0.tintColor = tintColor
            }
            
        case let tabBar as UITabBar:
            tabBar.apply {
                $0.barTintColor = backgroundColor
                $0.tintColor = textColor
                
                $0.isTranslucent = false
                $0.backgroundImage = UIImage()
                $0.shadowImage = UIImage()
            }
            
        case let navigationBar as UINavigationBar:
            navigationBar.apply {
                $0.barTintColor = backgroundColor
                $0.titleTextAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
                
                $0.isTranslucent = false
                $0.shadowImage = UIImage()
                
                $0.setBackgroundImage(UIImage(), for: .default)
            }
            
        case let collectionView as UICollectionView:
            collectionView.apply {
                $0.backgroundColor = backgroundColor
                
                $0.showsVerticalScrollIndicator = false
                $0.alwaysBounceVertical = true
            }
            
        case let label as UILabel:
            label.apply {
                $0.font = font
                $0.textColor = textColor
            }
            
        case let textField as UITextField:
            textField.apply {
                $0.font = textFieldFont
                $0.textColor = textColor
                
                $0.autocorrectionType = .no
            }
            
        default: break
        }
    }
}
