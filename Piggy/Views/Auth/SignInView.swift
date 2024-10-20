import SwiftUI

struct SignInView: View {
    @Environment(AuthStore.self) private var authStore
    @State var email = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(.imgMascot)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("Welcome!")
                .font(.largeTitle)
                .padding(.top, 16)
            
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 32)
            
            Button(action: {
                signIn()
            }) {
                let buttonText: String = authStore.state == .loading ? "Signing in..." : "Sign in"
                let buttonColor: Color = authStore.state == .loading ? .gray : .primary
                Text(buttonText)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(buttonColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 32)
                    .disabled(authStore.state == .loading)
            }
            .padding(.top, 16)
            
            switch authStore.state {
            case .failure(let error):
                Text(error)
                    .foregroundColor(.red)
                    .padding(.top, 32)
                    .transition(.opacity)
            case .success:
                Text("Check your inbox.")
                    .foregroundColor(.green)
                    .padding(.top, 32)
                    .transition(.opacity)
            case .anon, .loading:
                EmptyView()
            }
            
            Spacer()
        }
        .animation(.default, value: authStore.state)
        .onOpenURL(perform: { url in
            Task {
                do {
                    try await supabase.auth.session(from: url)
                } catch {
                    print("Error on callback: \(error)")
                }
            }
        })
    }
    
    func signIn() {
        Task {
            await authStore.signIn(email: email)
        }
    }
}
