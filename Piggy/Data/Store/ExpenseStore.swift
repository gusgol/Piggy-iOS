import Foundation

@Observable
class ExpenseStore {
    enum State: Equatable {
        case stale
        case loading
        case success
        case failure
    }
    var state: State = .stale
    var groupedExpenses: [String: [Expense]] = [:]
    
    private let service: ExpenseService
    
    init(service: ExpenseService) {
        self.service = service
    }
    
    func addExpense(expense: Expense) async {
        await service.addExpense(expense) { result in
            switch result {
            case .success():
                self.state = .stale
            case .failure(let error):
                print("Failed to add expense: \(error)")
            }
        }
    }
    
    func getExpenses(start: Date, end: Date) async {
        state = .loading
        await service.getExpenses(start: start, end: end) { result in
            switch result {
            case .success(let expenses):
                let groupedExpenses = Dictionary(grouping: expenses) { expense in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    return dateFormatter.string(from: expense.createdAt)
                }
                self.groupedExpenses = groupedExpenses
                self.state = .success
            case .failure(let error):
                print("Failed to get expenses: \(error)")
                self.state = .failure
            }
        }
    }
}
