import SwiftUI

struct ContentView: View {
    @State private var expenseStore: ExpenseStore = ExpenseStore(service: SupabaseExpenseService())
    @State private var categoryStore: CategoryStore = CategoryStore(service: SupabaseCategoryService())
    @State private var authStore: AuthStore = AuthStore(service: SupabaseAuthService())
    
    var body: some View {
        if (!authStore.isAuthenticated) {
            SignInView()
                .environment(authStore)
        } else {
            TabView {
                ExpensesView()
                    .environment(expenseStore)
                    .environment(categoryStore)
                    .tabItem {
                        Image(systemName: "dollarsign")
                    }
                CategoriesView()
                    .environment(categoryStore)
                    .tabItem {
                        Image(systemName: "archivebox")
                    }
                ChartsView()
                    .environment(expenseStore)
                    .environment(categoryStore)
                    .tabItem {
                        Image(systemName: "chart.pie")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
