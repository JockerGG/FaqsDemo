//
//  FontSingleton.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 08/08/24.
//

import Foundation
import UIKit

class FontSingleton {
    var selectedFont: Fonts = Fonts.RedHatDisplayRegular
    var font: UIFont = Fonts.RedHatDisplayRegular.getFont(withSize: 14)
    
    static let shared = FontSingleton()
}
