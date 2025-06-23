//
//  HeaderView.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("Taskerly")
                .font(.largeTitle.bold())
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview {
    HeaderView()
}
