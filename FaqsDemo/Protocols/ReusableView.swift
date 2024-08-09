//
//  ReusableView.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 07/08/24.
//

import Foundation
import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

extension ReusableView where Self: UIView {
    static var identifier: String {
        return NSStringFromClass(self)
    }
}
