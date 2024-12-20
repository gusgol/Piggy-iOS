import Foundation

protocol CategoryService {
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) async
    func addCategory(_ category: Category, completion: @escaping (Result<Void, Error>) -> Void) async
    func softDelete(_ id: UUID, completion: @escaping (Result<Void, Error>) -> Void) async
    func editCategory(_ category: Category, completion: @escaping (Result<Void, Error>) -> Void) async
}
