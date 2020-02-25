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

public extension UIColor {
    @inlinable
    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13, *) {
            self.init {
                return $0.userInterfaceStyle != .dark ? light : dark
            }
        }
        else {
            self.init(cgColor: light.cgColor)
        }
    }
    
    @inlinable
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    @inlinable
    func adjust(hueBy hue: CGFloat = 0, saturationBy saturation: CGFloat = 0, brightnessBy brightness: CGFloat = 0) -> UIColor {
        var colorHue: CGFloat = 0
        var colorSaturation: CGFloat = 0
        var colorBrigthness: CGFloat = 0
        var colorAlpha: CGFloat = 0
        
        if getHue(&colorHue, saturation: &colorSaturation, brightness: &colorBrigthness, alpha: &colorAlpha) {
            return UIColor(hue: colorHue + hue, saturation: colorSaturation + saturation, brightness: colorBrigthness + brightness, alpha: colorAlpha)
        }
        
        return self
    }
    
    @inlinable
    @available(iOS 10, *)
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { context in
            self.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
    }
}
