//
//  ExpensesService.swift
//  Piggy
//
//  Created by Gustavo Goldhardt on 08/10/24.
//

protocol ExpenseService {
    func getExpenses(completion: @escaping (Result<[Expense], Error>) -> Void) async
    func addExpense(_ expense: Expense, completion: @escaping (Result<Void, Error>) -> Void) async
}
