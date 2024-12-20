import Foundation
import SwiftUI
import SwiftUICore
import UIKit

struct ExpensesView: View {
    @Environment(ExpenseStore.self) private var expenseStore
    @Environment(CategoryStore.self) private var categoryStore
    @State private var addExpense = false
    @State private var currentDate = MonthDate()
    
    var body: some View {
        NavigationStack {
            VStack {
                Section {
                    MonthSelectorView(currentDate: $currentDate)
                }
                Group {
                    switch expenseStore.state {
                    case .stale, .loading:
                        ProgressView()
                            .frame(width: 100, height: 100)
                    case .success:
                        let groupedExpenses = expenseStore.groupedExpenses
                        if groupedExpenses.isEmpty {
                            EmptyContentView()
                        } else {
                            List {
                                ForEach(groupedExpenses.keys.sorted(by: >), id: \.self) { date in
                                    Section(header: Text(formattedDate(date))) {
                                        ForEach(groupedExpenses[date] ?? [], id: \.id) { expense in
                                            ExpenseItemView(expense: expense)
                                        }
                                    }
                                }
                            }
                        }
                    case .failure:
                        VStack {
                            Image(systemName: "exclamationmark.octagon")
                            Text("Failed to load expenses.")
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Expenses")
            .toolbar {
                Button(action: {
                    addExpense = true
                }) {
                    Label("Add", systemImage: "plus")
                }
            }
            .sheet(isPresented: $addExpense) {
                AddExpenseView(isPresented: $addExpense)
            }
            .onChange(of: currentDate, initial: true) {
                refresh()
            }
            .onChange(of: expenseStore.state, initial: true) { _, state in
                if state == .stale {
                    refresh()
                }
            }
            .onChange(of: categoryStore.state, initial: true) { _, state in
                if state == .stale {
                    Task {
                        await categoryStore.getCategories()
                    }
                }
            }
        }
    }
    
    private func refresh() {
        Task {
            await expenseStore.getExpenses(start: currentDate.startOfMonth(), end: currentDate.endOfMonth())
        }
    }
    
    private func formattedDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let dateObj = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "MMMM d, yyyy"
            return dateFormatter.string(from: dateObj)
        }
        return date
    }
}
