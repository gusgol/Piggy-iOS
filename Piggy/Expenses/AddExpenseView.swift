import SwiftUI

struct AddExpenseView: View {
    @Environment(ExpenseStore.self) private var expenseStore: ExpenseStore
    
    @Binding var isPresented: Bool
    @State private var title: String = ""
    @State private var amount: Decimal = 0
    @State private var category: String = ""
    @State private var selectedDate: Date = Date()
    @Environment(\.locale) private var locale
    
    var body: some View {
        NavigationView {
            Form {
                Section(header:
                            Text("Expense Details")
                    .padding()
                ) {
                    TextField("Title", text: $title)
                    TextField("Amount", value: $amount, format: .currency(code: locale.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                    TextField("Category", text: $category)
                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                    
                    Button(action: saveExpense) {
                        Label("Save", systemImage: "checkmark.circle")
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
    private func saveExpense() {
        let amountWithCents = NSDecimalNumber(decimal: amount).multiplying(by: 100).intValue
        let newExpense = Expense(title: title, amount: amountWithCents, category: category, createdAt: selectedDate)
        Task {
            await expenseStore.addExpense(expense: newExpense)
        }
        isPresented = false
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    @State static private var navigationPath = NavigationPath()
    @State static private var isPresented: Bool = false
    static var previews: some View {
        AddExpenseView(isPresented: $isPresented)
    }
}
