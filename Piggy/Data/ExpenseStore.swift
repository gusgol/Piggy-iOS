//
//  ExpenseStore.swift
//  Piggy
//
//  Created by Gustavo Goldhardt on 09/10/24.
//

import Foundation

@Observable
class ExpenseStore {
    enum State: Equatable {
        case stale
        case loading
        case success([String: [Expense]])
        case failure
    }
    var state: State = .stale
    
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
    
    func getExpenses() async {
        state = .loading
        await service.getExpenses { result in
            switch result {
            case .success(let expenses):
                let groupedExpenses = Dictionary(grouping: expenses) { expense in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    return dateFormatter.string(from: expense.createdAt)
                }
                self.state = .success(groupedExpenses)
            case .failure(let error):
                print("Failed to get expenses: \(error)")
                self.state = .failure
            }
        }
    }
}
