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

public enum LayoutDimension {
    case fullWidth
    case fullHeight
    case fittingHeight(_ view: UIView)
    case fractionalWidth(_ value: CGFloat)
    case fractionalHeight(_ value: CGFloat)
    case absolute(_ value: CGFloat)
    
    public func calculate(in rect: CGRect = UIScreen.main.bounds) -> CGFloat {
        switch self {
        case .fullWidth:
            return rect.width
            
        case .fullHeight:
            return rect.height
            
        case let .fittingHeight(view):
            return view.systemLayoutSizeFitting(.zero).height
            
        case let .fractionalWidth(value):
            return rect.width * value
            
        case let .fractionalHeight(value):
            return rect.height * value
            
        case let .absolute(value):
            return value
        }
    }
}
