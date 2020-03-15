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

public extension UICollectionView {
    @inlinable
    func dequeue<T: UICollectionViewCell & ViewReusable>(_ type: T.Type, for indexPath: IndexPath, with viewModel: T.T?) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as! T
        
        if let viewModel = viewModel {
            cell.prepare(viewModel: viewModel)
        }
        
        return cell
    }
    
    @inlinable
    func register<T: UICollectionViewCell & ViewReusable>(_ type: T.Type) {
        register(type, forCellWithReuseIdentifier: type.identifier)
    }
    
    @inlinable
    func resetData(animated: Bool = false, respectSafeAreaIfSupported respectSafeArea: Bool = false) {
        let y: CGFloat
        
        if #available(iOS 11, *), !respectSafeArea {
            y = -safeAreaInsets.top
        }
        else {
            y = 0
        }
        
        reloadData()
        setContentOffset(CGPoint(x: 0, y: y), animated: animated)
    }
}
