//
//  TableTVCell.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 08/08/24.
//

import Foundation
import UIKit

final class TableTVCell: UITableViewCell, ReusableView {
    private var model: Table?
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        return layout
    }()
    
    private lazy var collectionView: DynamicHeightCollectionView = {
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private var heightConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setConstraints()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
        setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.invalidateIntrinsicContentSize()
    }
    
    private func addViews() {
        contentView.addSubview(collectionView)
        collectionView.register(TableRowCell.self, forCellWithReuseIdentifier: TableRowCell.identifier)
    }
    
    private func setConstraints() {
        let heightConstraint = collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 1)
        heightConstraint.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            heightConstraint
        ])
        
        self.heightConstraint = heightConstraint
        collectionView.heightDelegate = self
    }
    
    func configure(with model: Table) {
        self.model = model
        collectionView.reloadData()
    }
    
    private func buildAttrString(_ model: ImageElement) -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0.2
        let childrens = model.children ?? []
        for element in childrens {
            attrString.append(element.buildTextElement())
        }
        
        attrString.addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attrString.length))
        
        return attrString
    }
}

extension TableTVCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let sections = model?.children else { return 0 }
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = model?.children, let childs = sections[section].children else { return 0 }
        return childs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sections = model?.children, let childs = sections[indexPath.section].children else { return UICollectionViewCell() }
        let model = childs[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableRowCell.identifier, for: indexPath) as? TableRowCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let sections = model?.children, let childs = sections[indexPath.section].children else { return .zero }
        let model = childs[indexPath.row]
        let cell = TableRowCell()
        cell.configure(with: model)
        let itemWidth = (collectionView.frame.width - 16) / CGFloat(childs.count)
        let height = cell.calculateHeight(width: itemWidth)
        
        return CGSize(width: itemWidth, height: height)
    }
}

extension TableTVCell: DynamicHeightCollectionViewDelegate {
    func contentSizeUpdated(_ contentSize: CGSize) {
        heightConstraint?.constant = contentSize.height
    }
}
