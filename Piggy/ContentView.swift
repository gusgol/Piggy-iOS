import SwiftUI

struct ContentView: View {
    @State private var expenseStore: ExpenseStore = ExpenseStore(service: SupabaseExpenseService())
    
    var body: some View {
        TabView {
            ExpensesView()
                .environment(expenseStore)
                .tabItem {
                    Image(systemName: "dollarsign")
                }
            CategoriesView()
                .tabItem {
                    Image(systemName: "archivebox")
                }
            Group {
                Text("Charts")
            }
                .tabItem {
                    Image(systemName: "chart.pie")
                }
        }
    }
}

#Preview {
    ContentView()
}
