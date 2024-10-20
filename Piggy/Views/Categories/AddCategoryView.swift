//
//  AddCategoryView.swift
//  Piggy
//
//  Created by Gustavo Goldhardt on 11/10/24.
//

import SwiftUI

struct AddCategoryView: View {
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
            .navigationBarTitle("Add Category", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                isPresented = false
            }, trailing: Button("Save") {
                let newCategory = Category(name: categoryName, color: selectedColor.toHex() ?? "#FFFFFF", icon: selectedIcon)
                Task {
                    await categoryStore.add(category: newCategory)
                }
                isPresented = false
            })
        }
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    @State static private var isPresented: Bool = false
    static var previews: some View {
        AddCategoryView(isPresented: $isPresented)
    }
}
