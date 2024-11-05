import SwiftUI

struct EditCategoryView: View {
    @Environment(CategoryStore.self) private var categoryStore: CategoryStore
    @Binding var isPresented: Bool
    
    @State private var categoryName: String = ""
    @State private var selectedIcon: String = "plus"
    @State private var selectedColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

    let icons = ["car", "house", "book", "gamecontroller", "cart", "creditcard", "heart", "airplane", "briefcase", "music.note"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter category name", text: $categoryName)
                    ColorPicker("Color", selection: $selectedColor)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5)) {
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding()
                                .background(selectedIcon == icon ? Color.gray.opacity(0.3) : Color.clear)
                                .cornerRadius(5)
                                .onTapGesture {
                                    selectedIcon = icon
                                }
                        }
                    }
                }
            }
            .navigationBarTitle("Edit Category", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                isPresented = false
            }, trailing: Button("Save") {
                saveCategory()
            })
        }
        .onAppear() {
            loadCategory()
        }
    }
    
    private func saveCategory() {
        Task {
            await categoryStore.edit(name: categoryName, icon: selectedIcon, color: selectedColor.toHex() ?? "#FFFFFF")
        }
        isPresented = false
    }
    
    private func loadCategory() {
        self.categoryName = categoryStore.selectedCategory?.name ?? ""
        self.selectedIcon = categoryStore.selectedCategory?.icon ?? "plus"
        self.selectedColor = Color(hex: categoryStore.selectedCategory?.color ?? "#FFFFFF")
    }
}
