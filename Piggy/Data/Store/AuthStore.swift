import Foundation

@Observable
class AuthStore {
    enum SignInState: Equatable {
        case anon
        case loading
        case success
        case failure(String)
    }
    var state: SignInState = .anon
    var isAuthenticated: Bool = false
    
    private let service: AuthService
    
    init(service: AuthService) {
        self.service = service
        Task {
            await service.isAuthenticated { isAuthenticated in
                self.isAuthenticated = isAuthenticated
            }
        }
    }
    
    func signIn(email: String) async {
        self.state = .loading
        await service.signIn(with: email) { result in
            switch result {
            case .success():
                self.state = .success
            case .failure(let error):
                self.state = .failure(error.localizedDescription)
            }
        }
    }
}
