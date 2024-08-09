//
//  UIFont+Extension.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 07/08/24.
//

import Foundation
import UIKit

extension UIFont {
    
    static func combinedFont(baseFont: UIFont, bold: Bool, italic: Bool) -> UIFont {
        var traits: UIFontDescriptor.SymbolicTraits = []
        
        if bold {
            traits.insert(.traitBold)
        }
        
        if italic {
            traits.insert(.traitItalic)
        }
        
        if let descriptor = baseFont.fontDescriptor.withSymbolicTraits(traits) {
            return UIFont(descriptor: descriptor, size: baseFont.pointSize)
        } else {
            return baseFont
        }
    }
}
