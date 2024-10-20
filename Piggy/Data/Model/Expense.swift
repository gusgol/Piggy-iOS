import Foundation

struct Expense: Identifiable, Codable {
    let id: UUID?
    let title: String
    let amount: Int
    let createdAt: Date
    let category: Category?
    
    init(id: UUID? = nil, title: String, amount: Int, createdAt: Date, category: Category?) {
        self.id = id
        self.title = title
        self.amount = amount
        self.createdAt = createdAt
        self.category = category
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case amount
        case createdAt = "created_at"
        case category
    }
}
