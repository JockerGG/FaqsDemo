//
//  LinkElement.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 07/08/24.
//

import Foundation

struct LinkElement: Codable {
    var href: String?
    var children: [TextElement]?
    
    func buildLinkElement() -> NSAttributedString {
        let linkString = NSMutableAttributedString(string: "")
        let childrens = children ?? []
        for linkElement in childrens {
            let linkText = linkElement.buildTextElement()
            linkString.append(linkText)
        }
        
        if let href,
            linkString.string.contains(href) {
            let nsString = linkString.string as NSString
            let range = nsString.range(of: href)
            linkString.addAttribute(.link, value: href, range: range)
        } else {
            linkString.addAttribute(.link, value: linkString.string, range: NSRange(location: 0, length: linkString.length))
        }
        
        return linkString
    }
}
