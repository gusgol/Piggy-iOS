import Foundation

class SupabaseAuthService: AuthService {
    static let redirectUrl = "me.gusgol.piggy://login-callback"
    
    func isAuthenticated(onChange: @escaping (Bool) -> Void) async {
        for await state in supabase.auth.authStateChanges {
            if [.initialSession, .signedIn, .signedOut].contains(state.event) {
                let isAuthenticated = state.session != nil
                onChange(isAuthenticated)
            }
        }
    }
    
    func signIn(with email: String, completion: @escaping (Result<Void, any Error>) -> Void) async {
        do {
            try await supabase.auth.signInWithOTP(
                email: email,
                redirectTo: URL(string: SupabaseAuthService.redirectUrl),
                shouldCreateUser: true
            )
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
