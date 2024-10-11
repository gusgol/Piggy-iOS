import Foundation

struct Expense: Identifiable, Codable, Equatable {
    let id: UUID = UUID()
    let title: String
    let amount: Int
    let category: String
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case amount
        case category
        case createdAt = "created_at"
    }
}
