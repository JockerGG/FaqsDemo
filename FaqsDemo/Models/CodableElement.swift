//
//  CodableElement.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 07/08/24.
//

import Foundation

enum CodableElement: Codable {
    case text(element: TextElement)
    case link(element: LinkElement)
    case image(element: ImageElement)
    case paragraph(element: Paragraph)
    case listItem(element: ListItem)
    case list(element: List)
    case tableCell(element: TableCell)
    case tableRow(element: TableRow)
    case table(element: Table)
    
    private enum CodingKeys: String, CodingKey {
        case type
    }
    
    private enum ElementType: String, Codable {
        case text
        case link
        case image
        case paragraph
        case listItem
        case bulletedList = "bulleted-list"
        case numberList = "numbered-list"
        case tableCell
        case tableRow
        case table
    }
    
    init(from decoder: Decoder) throws {
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        let type = try containter.decodeIfPresent(ElementType.self, forKey: .type) ?? .text
        
        switch type {
        case .text:
            self = .text(element: try TextElement(from: decoder))
        case .link:
            self = .link(element: try LinkElement(from: decoder))
        case .image:
            self = .image(element: try ImageElement(from: decoder))
        case .paragraph:
            self = .paragraph(element: try Paragraph(from: decoder))
        case .listItem:
            self = .listItem(element: try ListItem(from: decoder))
        case .bulletedList,
                .numberList:
            self = .list(element: try List(from: decoder))
        case .tableCell:
            self = .tableCell(element: try TableCell(from: decoder))
        case .tableRow:
            self = .tableRow(element: try TableRow(from: decoder))
        case .table:
            self = .table(element: try Table(from: decoder))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        switch self {
        case .text(let value):
            try value.encode(to: encoder)
        case .link(let value):
            try value.encode(to: encoder)
        case .image(let value):
            try value.encode(to: encoder)
        case .paragraph(let value):
            try value.encode(to: encoder)
        case .listItem(let value):
            try value.encode(to: encoder)
        case .list(let value):
            try value.encode(to: encoder)
        case .tableCell(let value):
            try value.encode(to: encoder)
        case .tableRow(let value):
            try value.encode(to: encoder)
        case .table(let value):
            try value.encode(to: encoder)
        }
    }
}
