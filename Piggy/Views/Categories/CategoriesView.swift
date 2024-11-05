import Foundation
import SwiftUI

struct CategoriesView: View {
    @Environment(CategoryStore.self) private var categoryStore
    @State private var addCategory = false
    @State private var editCategory = false
    
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
                            .onTapGesture {
                                onCategorySelected(category)
                            }
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
            .sheet(isPresented: $editCategory) {
                EditCategoryView(isPresented: $editCategory)
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
    
    func onCategorySelected(_ category: Category) {
        categoryStore.selectedCategory = category
        editCategory = true
    }
}

#Preview {
    CategoriesView()
}


