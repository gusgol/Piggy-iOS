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
    let deleted: Bool
    
    init(id: UUID? = nil, name: String, color: String, icon: String, deleted: Bool = false) {
        self.id = id
        self.name = name
        self.color = color
        self.icon = icon
        self.deleted = false
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case color
        case icon
        case deleted
    }
}
