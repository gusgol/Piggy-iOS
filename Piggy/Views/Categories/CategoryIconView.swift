import SwiftUI

struct CategoryIconView: View {
    let category: Category
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(hex: category.color))
                .frame(width: 40, height: 40)
            Image(systemName: category.icon)
                .foregroundColor(.white)
        }
    }
}
