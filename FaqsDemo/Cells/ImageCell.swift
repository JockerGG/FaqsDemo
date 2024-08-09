//
//  ImageCell.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 08/08/24.
//

import Foundation
import UIKit
import Combine

final class ImageCell: UITableViewCell, ReusableView {
    private var cancellable: AnyCancellable?
    
    private lazy var editorImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.delegate = self
        
        return textView
    }()
    
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
    
    
    private func addViews() {
        contentView.addSubview(editorImage)
        contentView.addSubview(textView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            editorImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            editorImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            editorImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            editorImage.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            textView.topAnchor.constraint(equalTo: editorImage.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: 4)
        ])
    }
    
    func configure(with model: ImageElement) {
        let attributedString = buildAttrString(model)
        textView.attributedText = attributedString
        
        if let url = URL(string: model.url ?? "") {
            cancellable = loadImage(url).receive(on: DispatchQueue.main)
                .sink { [weak self] image in
                    self?.editorImage.image = image
                }
        }
    }
    
    private func loadImage(_ url: URL) -> AnyPublisher<UIImage?, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { data, _ in
                UIImage(data: data)
            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
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
