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

public class UICollectionSimpleDataSource<T>: NSObject, UICollectionViewDataSource {
    public typealias CellProvider = (UICollectionView, IndexPath, T) -> UICollectionViewCell
    public typealias SupplementaryProvider = (UICollectionView, IndexPath, String) -> UICollectionReusableView?
    
    public var supplementaryProvider: SupplementaryProvider?
    
    private let cellProvider: CellProvider
    
    private var items: [T]?
    private weak var collectionView: UICollectionView?
    
    public init(cellProvider: @escaping CellProvider) {
        self.cellProvider = cellProvider
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.collectionView = collectionView
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = items?[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        return cellProvider(collectionView, indexPath, item)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return supplementaryProvider?(collectionView, indexPath, kind) ?? UICollectionReusableView()
    }
    
    public func apply(items: [T]?) {
        self.items = items
        collectionView?.reloadDataAndScrollTop()
    }
}
