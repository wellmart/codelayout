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

public extension UIWindow {
    private struct Appearance {
        static var `default`: UIWindowAppearance?
    }

    static var appearance: UIWindowAppearance? {
        get { return Appearance.default }
        set { Appearance.default = newValue }
    }
}

public extension UIWindow {
    @inlinable
    convenience init(rootViewController: UIViewController) {
        self.init(frame: UIScreen.main.bounds)

        UIWindow.appearance?.apply(on: self)

        self.rootViewController = rootViewController
        self.makeKeyAndVisible()

        DispatchQueue.main.async {
            self.preloadKeyboard()
        }
    }
    
    func preloadKeyboard() {
        let textField = UITextField().apply {
            addSubview($0)
        }
        
        textField.becomeFirstResponder()
        textField.resignFirstResponder()
        
        textField.removeFromSuperview()
    }
}
