//
//  DynamicHeightCollectionView.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 08/08/24.
//

import Foundation
import UIKit

protocol DynamicHeightCollectionViewDelegate: AnyObject {
    func contentSizeUpdated(_ contentSize: CGSize)
}

final class DynamicHeightCollectionView: UICollectionView {
    weak var heightDelegate: DynamicHeightCollectionViewDelegate?
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
            super.init(frame: frame, collectionViewLayout: layout)
            commonInit()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }

        private func commonInit() {
            isScrollEnabled = false
            setContentHuggingPriority(.required, for: .vertical)
        }

        override var contentSize: CGSize {
            didSet {
                invalidateIntrinsicContentSize()
                setNeedsLayout()
                layoutIfNeeded()
            }
        }

        override func reloadData() {
            super.reloadData()
            invalidateIntrinsicContentSize()
            setNeedsLayout()
            layoutIfNeeded()
        }

        override var intrinsicContentSize: CGSize {
            return contentSize
        }
}
