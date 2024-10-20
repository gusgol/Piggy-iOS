//
//  ExpensesService.swift
//  Piggy
//
//  Created by Gustavo Goldhardt on 08/10/24.
//

import Foundation

protocol ExpenseService {
    func getExpenses(start: Date, end: Date, completion: @escaping (Result<[Expense], Error>) -> Void) async
    func addExpense(_ expense: Expense, completion: @escaping (Result<Void, Error>) -> Void) async
}
