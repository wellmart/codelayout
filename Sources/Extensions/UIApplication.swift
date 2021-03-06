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
    enum Environment {
        case debug
        case testFlight
        case appStore
    }
    
    @inlinable
    static func openSettings() {
        guard let url = URL(string: openSettingsURLString),
              shared.canOpenURL(url) else {
            return
        }
        
        shared.open(url)
    }
    
    @inlinable
    static func openShare(appId: String, message: String, viewController: UIViewController) {
        guard let url = URL(string: "https://apps.apple.com/app/\(appId)") else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [message, url], applicationActivities: nil).apply {
            $0.excludedActivityTypes = [
                .addToReadingList,
                .airDrop,
                .print,
                .saveToCameraRoll
            ]
        }
        
        viewController.present(activityViewController, animated: true)
    }
    
    var environment: Environment {
        #if DEBUG || targetEnvironment(simulator)
        return .debug
        #else
        if Bundle.main.path(forResource: "embedded", ofType: "mobileprovision") != nil {
            return .testFlight
        }
        
        guard let url = Bundle.main.appStoreReceiptURL else {
            return .debug
        }
        
        if url.lastPathComponent.lowercased() == "sandboxreceipt" {
            return .testFlight
        }
        
        if url.path.lowercased().contains("simulator") {
            return .debug
        }
        
        return .appStore
        #endif
    }
    
    @inlinable
    var leftToRightLayoutDirection: Bool {
        return userInterfaceLayoutDirection != .rightToLeft
    }
}
