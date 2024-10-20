//
//  EmtpyView.swift
//  Piggy
//
//  Created by Gustavo Goldhardt on 11/10/24.
//

import SwiftUI

struct EmptyContentView: View {
    var body: some View {
        VStack {
            Image(.imgEmpty)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(32)
            Text("You have no expenses yet!")
                .multilineTextAlignment(.center)
                .bold()
                .font(.largeTitle)
        }
        .padding(32)

    }
}

#Preview {
    EmptyContentView()
}
