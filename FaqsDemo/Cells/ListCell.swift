//
//  ListCell.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 07/08/24.
//

import Foundation
import UIKit

final class ListCell: UITableViewCell, ReusableView {
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
    
    func configure(with model: List) {
        let attributedString = buildAttrString(model)
        textView.attributedText = attributedString
    }
    
    private func buildAttrString(_ model: List) -> NSAttributedString {
        let children = model.children ?? []
        let attrString = NSMutableAttributedString(string: "")
        let font = model.type == "bulleted-list" ? UIFont.systemFont(ofSize: 20, weight: .bold) : UIFont.systemFont(ofSize: 14)
        let indicatorAttr: [NSAttributedString.Key: Any] = [.font: font]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.tabStops = [.init(textAlignment: .left, location: 0)]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.paragraphSpacing = 15
        paragraphStyle.headIndent = 30
        paragraphStyle.lineSpacing = 0
        
        for (index, element) in children.enumerated() {
            let indicator = model.type == "bulleted-list" ? "\t•\t" : "\t\(index + 1).\t"
            let listElement = NSMutableAttributedString(string: indicator)
            listElement.addAttributes(indicatorAttr, range: NSRange(location: 0, length: listElement.length))
            let lineBreak = NSMutableAttributedString(string: "\n")
            for value in element.children ?? [] {
                let listText = buildListElement(value)
                listElement.append(listText)
            }
            listElement.addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: listElement.length))
            attrString.append(listElement)
            attrString.append(lineBreak)
        }
                
        return attrString
    }
    
    private func buildListElement(_ element: CodableElement) -> NSMutableAttributedString {
        let listElement = NSMutableAttributedString(string: "")
        if case .text(let element) = element {
            let textString = element.buildTextElement()
            listElement.append(textString)
        }
        
        if case .link(let element) = element {
            let linkString = element.buildLinkElement()
            listElement.append(linkString)
        }
        
        return listElement
    }
}
