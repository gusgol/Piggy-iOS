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
                    List(categoryStore.categories) { category in
                        HStack {
                            CategoryIconView(category: category)
                            Text(category.name)
                                .font(.headline)
                                .padding(.leading, 8)
                        }
                        .padding(.vertical, 8)
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
}

#Preview {
    CategoriesView()
}


