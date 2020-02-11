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

public protocol SimplePageChildControllerProtocol: UIViewController {
    init()
    
    func prepare(for index: Int)
}

open class UISimplePageController<T: SimplePageChildControllerProtocol>: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    private var currentIndex = 0
    private lazy var indexes = [T: Int](reserveCapacity: 3)
    
    public init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = indexes[viewController as! T] else {
            return nil
        }
        
        return prepareViewController(for: index - 1)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = indexes[viewController as! T] else {
            return nil
        }
        
        return prepareViewController(for: index + 1)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard finished && completed, let viewController = pageViewController.viewControllers?.first, let index = indexes[viewController as! T] else {
            return
        }
        
        currentIndex = index
    }
    
    open func load(childController: T) {
    }
    
    public func reset(currentIndex: Int = 0) {
        let direction: NavigationDirection = currentIndex > self.currentIndex ? .forward : .reverse
        
        self.currentIndex = currentIndex
        
        if let viewController = prepareViewController(for: currentIndex) {
            setViewControllers([viewController], direction: direction, animated: true)
        }
        
        prepareViewController(for: currentIndex + 1)
        prepareViewController(for: currentIndex - 1)
    }
    
    private func commonInit() {
        dataSource = self
        delegate = self
    }
    
    @discardableResult
    private func prepareViewController(for index: Int) -> UIViewController? {
        if let viewController = indexes.first(where: { $0.value == index })?.key {
            return viewController
        }
        
        let viewController = indexes.first(where: { $0.value < currentIndex - 1 || $0.value > currentIndex + 1 })?.key ?? T().apply {
            load(childController: $0)
        }
        
        viewController.prepare(for: index)
        indexes[viewController] = index
        
        return viewController
    }
}
