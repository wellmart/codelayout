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

public extension UIApplication {
    @inlinable
    @available(iOS 10, *)
    static func openSettings() {
        guard let url = URL(string: openSettingsURLString), shared.canOpenURL(url) else {
            return
        }
        
        shared.open(url)
    }
    
    @inlinable
    var leftToRightLayoutDirection: Bool {
        return userInterfaceLayoutDirection != .rightToLeft
    }
    
    @inlinable
    var preferredContentMultiplier: CGFloat {
        switch preferredContentSizeCategory {
        case .accessibilityExtraExtraExtraLarge:
            return 1.4375
            
        case .accessibilityExtraExtraLarge:
            return 1.375
            
        case .accessibilityExtraLarge:
            return 1.3125
            
        case .accessibilityLarge:
            return 1.25
            
        case .accessibilityMedium:
            return 1.1875
            
        case .extraExtraExtraLarge:
            return 1.1875
            
        case .extraExtraLarge:
            return 1.125
            
        case .extraLarge:
            return 1.0625
            
        case .medium:
            return 0.9375
            
        case .small:
            return 0.875
            
        case .extraSmall:
            return 0.8125
            
        default:
            return 1
        }
    }
}
