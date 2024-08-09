//
//  ColumnFlowLayout.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 08/08/24.
//

import Foundation
import UIKit

final class ColumnFlowLayout: UICollectionViewFlowLayout {
    private let cellsPerRow: Int
    
    init(cellsPerRow: Int, minimumInteritemSpacing: CGFloat = 0,
         minimunLineSpacing: CFloat = 0,
         sectionInset: UIEdgeInsets = .zero) {
        self.cellsPerRow = cellsPerRow
        super.init()
        
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView else { return }
        let marginAndInsets = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width) / CGFloat(cellsPerRow).rounded(.down))
        itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let context = super.invalidationContext(forBoundsChange: newBounds) as? UICollectionViewFlowLayoutInvalidationContext
        context?.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        
        return true
    }
}
