import Foundation

class SupabaseCategoryService: CategoryService {
    func getCategories(completion: @escaping (Result<[Category], any Error>) -> Void) async {
        do {
            let categories: [Category] = try await supabase
                .from("categories")
                .select()
                .order("name")
                .execute()
                .value
            completion(.success(categories))
        } catch {
            completion(.failure(error))
        }
    }
    
    func addCategory(_ category: Category, completion: @escaping (Result<Void, any Error>) -> Void) async {
        do {
            try await supabase
                .from("categories")
                .insert(category)
                .execute()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    func softDelete(_ id: UUID, completion: @escaping (Result<Void, any Error>) -> Void) async {
        do {
            try await supabase
              .from("categories")
              .update(["deleted": "TRUE"])
              .eq("id", value: id.uuidString)
              .execute()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func editCategory(_ category: Category, completion: @escaping (Result<Void, any Error>) -> Void) async {
        do {
            try await supabase
              .from("categories")
              .update(category)
              .eq("id", value: category.id?.uuidString)
              .execute()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
