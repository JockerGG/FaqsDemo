//
//  List.swift
//  FaqsDemo
//
//  Created by Eduardo Garcia Gonzalez on 07/08/24.
//

import Foundation

struct List: Codable {
    var type: String?
    var children: [ListItem]?
}
