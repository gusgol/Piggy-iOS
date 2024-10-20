import SwiftUI

struct AddExpenseView: View {
    @Environment(ExpenseStore.self) private var expenseStore: ExpenseStore
    @Environment(CategoryStore.self) private var categoryStore: CategoryStore

    @Binding var isPresented: Bool
    @State private var title: String = ""
    @State private var amount: Decimal = 0
    @State private var category: Category? = nil
    @State private var selectedDate: Date = Date()
    @Environment(\.locale) private var locale

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Amount", value: $amount, format: .currency(code: locale.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                    Picker("Category", selection: $category) {
                        ForEach(categoryStore.categories) { category in
                            Text(category.name).tag(category)
                        }
                    }
                    DatePicker("Date", selection: $selectedDate, displayedComponents: .date)
                }
            }
            .navigationBarTitle("Add Expense", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                isPresented = false
            }, trailing: Button("Save") {
                saveExpense()
            })
        }
        .onAppear() {
            category = categoryStore.categories.first
        }
    }
    
    private func saveExpense() {
        guard !title.isEmpty, let category = category else {
            return
        }
        let amountWithCents = NSDecimalNumber(decimal: amount).multiplying(by: 100).intValue
        let newExpense = Expense(title: title, amount: amountWithCents, createdAt: selectedDate, category: category)
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
