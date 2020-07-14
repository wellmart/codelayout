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

public extension String {
    @inlinable
    func lineSpaced(_ lineSpacing: CGFloat, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.paragraphStyle: NSMutableParagraphStyle().apply {
            $0.alignment = alignment
            $0.lineSpacing = lineSpacing
        }])
    }
    
    @inlinable
    func strikethrough() -> NSAttributedString {
        return NSMutableAttributedString(string: self).apply {
            $0.addAttribute(NSAttributedString.Key.strikethroughStyle,
                            value: NSUnderlineStyle.single.rawValue | NSUnderlineStyle.byWord.rawValue,
                            range: NSMakeRange(0, count))
        }
    }
}
