import SwiftUICore

struct ExpenseItemView: View {
    var expense: Expense

    var body: some View {
            HStack {
                HStack(alignment: .center) {
                    Text(expense.category)
                        .font(.caption)
                        .padding(4)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
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
