import Foundation

@Observable
class CategoryStore {
    enum State: Equatable {
        case stale
        case loading
        case success
        case failure
    }
    var state: State = .stale
    
    var categories: [Category] = []
    
    private var service: CategoryService
    
    init(service: CategoryService) {
        self.service = service
    }
    
    func getCategories() async {
        self.state = .loading
        await service.getCategories { result in
            switch result {
            case .success(let categories):
                self.categories = categories
                self.state = .success
            case .failure(let error):
                print("Failed to get expenses: \(error)")
                self.state = .failure
            }
        }
    }
    
    func add(category: Category) async {
        await service.addCategory(category) { result in
            switch result {
            case .success():
                self.state = .stale
            case .failure(let error):
                print("Failed to add expense: \(error)")
            }
        }
    }
    
    func getDefaultCategory() -> Category {
        return Category(name: "Undefined", color: "#c73041", icon: "questionmark")
    }
}

