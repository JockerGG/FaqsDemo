//
//  TextElement.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 07/08/24.
//

import Foundation
import UIKit

struct TextElement: Codable {
    var text: String?
    var bold: Bool?
    var italic: Bool?
    var underline: Bool?
    
    func buildTextElement() -> NSMutableAttributedString {
        guard let text = text else {
            return NSMutableAttributedString(string: "")
        }
        
        let attrString = NSMutableAttributedString(string: text)
        let baseFont = FontSingleton.shared.font
        let combinedFont = UIFont.combinedFont(baseFont: baseFont, bold: bold ?? false, italic: italic ?? false)
        var attr: [NSAttributedString.Key: Any] = [
            .font: combinedFont,
            .foregroundColor: UIColor.black
        ]
        
        if underline ?? false {
            attr[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }
        
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        
        return attrString
    }
}
