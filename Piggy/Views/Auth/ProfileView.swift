import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()

                Text("More features here soon...")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 20)

                Button(action: {
                    Task {
                        try? await supabase.auth.signOut()
                    }
                }) {
                    Text("Sign out")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
                Spacer()
            }
            .navigationTitle("Profile")
        }
    }
}
