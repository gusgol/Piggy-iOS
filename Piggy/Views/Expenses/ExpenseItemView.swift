import SwiftUICore

struct ExpenseItemView: View {
    @Environment(CategoryStore.self) private var categoryStore
    var expense: Expense
    
    var body: some View {
        let category = expense.category ?? categoryStore.getDefaultCategory()
        HStack {
            CategoryIconView(category: category)
            VStack(alignment: .leading) {
                Text(category.name)
                    .font(.caption)
                Text(expense.title)
                    .font(.headline)
            }
            Spacer()
            Text(expense.amount.toFormattedAmount() ?? "-")
                .font(.headline)
        }
        .padding(.vertical, 8)
    }
}
