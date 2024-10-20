protocol AuthService {
    func isAuthenticated(onChange: @escaping (Bool) -> Void) async
    func signIn(with email: String, completion: @escaping (Result<Void, Error>) -> Void) async
}
