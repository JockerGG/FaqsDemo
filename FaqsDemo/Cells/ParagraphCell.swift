//
//  ParagraphCell.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 07/08/24.
//

import Foundation
import UIKit

final class ParagraphCell: UITableViewCell, ReusableView {
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        
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
        selectionStyle = .none
    }
    
    
    private func addViews() {
        contentView.addSubview(textView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with model: Paragraph) {
        let attributedString = buildAttrString(model)
        textView.attributedText = attributedString
        textView.textAlignment = model.align?.alignment ?? .left
    }
    
    private func buildAttrString(_ model: Paragraph) -> NSAttributedString {
        let children = model.children ?? []
        let attrString = NSMutableAttributedString(string: "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0.2
        let lineBreak = NSAttributedString(string: "\n")
        for element in children {
            if case .text(let element) = element {
                attrString.append(element.buildTextElement())
            }
            
            if case .link(let element) = element {
                attrString.append(element.buildLinkElement())
            }
        }
        
        attrString.append(lineBreak)
        attrString.addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attrString.length))
        return attrString
    }
}
