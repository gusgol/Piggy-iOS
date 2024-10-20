import Foundation
import Supabase

class SupabaseExpenseService: ExpenseService {
    
    func getExpenses(start: Date, end: Date, completion: @escaping (Result<[Expense], any Error>) -> Void) async {
        do {
            let expenses: [Expense] = try await supabase
                .from("expenses")
                .select("*, category:categories(*)")
                .gte("created_at", value: start)
                .lte("created_at", value: end)
                .execute()
                .value
            completion(.success(expenses))
        } catch {
            completion(.failure(error))
        }
    }
    
    func addExpense(_ expense: Expense, completion: @escaping (Result<Void, any Error>) -> Void) async {
        do {
            let obj = ExpenseJSON.from(expense)
            
            if obj == nil {
                let error = NSError(domain: "me.gusgol.piggy.data", code: 1001, userInfo: [NSLocalizedDescriptionKey: "Unable to create JSON object from Expense (possibly because of category"])
                completion(.failure(error))
            }
            
            try await supabase
                .from("expenses")
                .insert(obj)
                .execute()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    /*
     Handles conversion of an Expense to the Supabase table (expenses).
     - `public.expenses` table contains a category_id (FK) column, and hence the conversion.
     */
    private struct ExpenseJSON: Codable {
        let title: String
        let amount: Int
        let createdAt: Date
        let categoryId: UUID
        
        enum CodingKeys: String, CodingKey {
            case title
            case amount
            case createdAt = "created_at"
            case categoryId = "category_id"
        }
        
        static func from(_ expense: Expense) -> ExpenseJSON? {
            guard let categoryId = expense.category?.id else {
                return nil
            }
            return ExpenseJSON(title: expense.title, amount: expense.amount, createdAt: expense.createdAt, categoryId: categoryId)
        }
    }
}
