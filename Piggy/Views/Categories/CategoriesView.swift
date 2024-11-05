import Foundation
import SwiftUI

struct CategoriesView: View {
    @Environment(CategoryStore.self) private var categoryStore
    @State private var addCategory = false
    
    var body: some View {
        NavigationStack {
            Group {
                switch categoryStore.state {
                case .stale, .loading:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .success:
                    List() {
                        ForEach(categoryStore.categories) { category in
                            HStack {
                                CategoryIconView(category: category)
                                Text(category.name)
                                    .font(.headline)
                                    .padding(.leading, 8)
                            }
                            .padding(.vertical, 8)
                        }
                        .onDelete(perform: deleteItems)

                    }
                case .failure:
                    VStack {
                        Image(systemName: "exclamationmark.octagon")
                        Text("Failed to load expenses.")
                    }
                }
            }
            .navigationTitle("Categories")
            .toolbar {
                Button(action: {
                    addCategory = true
                }) {
                    Label("Add", systemImage: "plus")
                }
            }
            .sheet(isPresented: $addCategory) {
                AddCategoryView(isPresented: $addCategory)
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
    
    func deleteItems(at offsets: IndexSet) {
        print(offsets)
        guard let firstIndex = offsets.first else { return }
        Task {
            await categoryStore.delete(index: firstIndex)
        }
    }
}

#Preview {
    CategoriesView()
}


