//
//  TextAligment.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 07/08/24.
//

import Foundation
import UIKit

enum TextAlignment: String, Codable {
    case center
    case justify
    case `left`
    case `right`
    
    var alignment: NSTextAlignment {
        switch self {
        case .center:
            return .center
        case .justify:
            return .justified
        case .left:
            return .left
        case .right:
            return .right
        }
    }
}
