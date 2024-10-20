//
//  Category.swift
//  Piggy
//
//  Created by Gustavo Goldhardt on 11/10/24.
//

import Foundation

struct Category: Identifiable, Codable, Equatable, Hashable {
    let id: UUID?
    let name: String
    let color: String
    let icon: String
    
    init(id: UUID? = nil, name: String, color: String, icon: String) {
        self.id = id
        self.name = name
        self.color = color
        self.icon = icon
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case color
        case icon
    }
}
