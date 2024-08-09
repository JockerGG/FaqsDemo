//
//  TableRowCell.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 08/08/24.
//

import Foundation
import UIKit
import Combine

class TableRowCell: UICollectionViewCell, ReusableView {
    private var cancellable: AnyCancellable?
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
        setConstraints()
    }
    
    private func addViews() {
        contentView.addSubview(stackView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8)
        ])
    }
    
    func configure(with model: TableCell) {
        guard let children = model.children else { return }
        stackView.subviews.forEach { $0.removeFromSuperview() }
        let attrString = NSMutableAttributedString(string: "")
        for element in children {
            if case .text(let textElement) = element {
                attrString.append(textElement.buildTextElement())
            }
            
            if case .image(let element) = element {
                guard let url = URL(string: element.url ?? "") else { return }
                let imageView = buildImageView()
                stackView.addArrangedSubview(imageView)
                cancellable = loadImage(url).receive(on: DispatchQueue.main)
                    .sink { image in
                        imageView.image = image
                    }
            }
            
            if case .link(let element) = element {
                attrString.append(element.buildLinkElement())
            }
        }
        
        if !attrString.string.isEmpty {
            stackView.addArrangedSubview(buildTextView(attrString))
        }
    }
    
    func calculateHeight(width: CGFloat) -> CGFloat {
        let targetSize = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
        var calculatedHeigth: CGFloat = 0
        stackView.arrangedSubviews.forEach { view in
            if let textView = view as? UITextView {
                calculatedHeigth += textView.attributedText?.height(containerWidth: width) ?? 0
            } else {
                let calculatedSize = view.systemLayoutSizeFitting(targetSize,
                                                                       withHorizontalFittingPriority: .required,
                                                                       verticalFittingPriority: .fittingSizeLevel)
                calculatedHeigth += calculatedSize.height
            }
        }
        
        return calculatedHeigth + 24
    }
    
    private func buildTextView(_ text: NSAttributedString) -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.attributedText = text
        textView.isEditable = false
        textView.sizeToFit()

        return textView
    }
    
    private func buildImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        return imageView
    }
    
    private func loadImage(_ url: URL) -> AnyPublisher<UIImage?, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { data, _ in
                UIImage(data: data)
            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
