//
//  EmptyStateView.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            EmptyStateAnimation()
            
            Text("No tasks yet")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Start by adding a task.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

#Preview {
    EmptyStateView()
}
