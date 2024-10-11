import Foundation
import Supabase

class SupabaseExpenseService: ExpenseService {
    
    func getExpenses(completion: @escaping (Result<[Expense], any Error>) -> Void) async {
        do {
            let expenses: [Expense] = try await supabase
                .from("expenses")
                .select()
                .execute()
                .value
            completion(.success(expenses))
        } catch {
            completion(.failure(error))
        }
    }
    
    func addExpense(_ expense: Expense, completion: @escaping (Result<Void, any Error>) -> Void) async {
        do {
            try await supabase
                .from("expenses")
                .insert(expense)
                .execute()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
