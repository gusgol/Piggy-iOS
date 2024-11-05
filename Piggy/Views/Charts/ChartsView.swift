import SwiftUI
import Charts

struct ChartsView: View {
    @Environment(ExpenseStore.self) private var expenseStore
    @Environment(CategoryStore.self) private var categoryStore
    @State private var currentDate = MonthDate()
    
    var body: some View {
        NavigationStack {
            VStack {
                Section {
                    MonthSelectorView(currentDate: $currentDate)
                }
                let data = expenseStore.calculateCategorySums()
                Chart(data, id: \.0) { dataItem in
                    SectorMark(angle: .value("Category", dataItem.1),
                               innerRadius: .ratio(0.5),
                               angularInset: 1.5)
                    .cornerRadius(5)
                    .foregroundStyle(by: .value("Color", dataItem.0))
                }
                .chartLegend(.hidden) 
                .frame(height: 200)
                .chartLegend(.visible)
                .frame(height: 300)
                Spacer()
            }
            .navigationTitle("Charts")
        }
    }
    
    private func refresh() {
        Task {
            await expenseStore.getExpenses(start: currentDate.startOfMonth(), end: currentDate.endOfMonth())
        }
    }
    
}

#Preview {
    ChartsView()
}
