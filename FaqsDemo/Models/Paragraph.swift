//
//  Paragraph.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 07/08/24.
//

import Foundation

struct Paragraph: Codable {
    var type: String?
    var children: [CodableElement]?
    var align: TextAlignment?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
        self.children = try container.decode([CodableElement].self, forKey: .children)
        self.align = try container.decodeIfPresent(TextAlignment.self, forKey: .align)
    }
}
