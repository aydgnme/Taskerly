//
//  TaskCardView.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import SwiftUI

struct TaskCardView: View {
    let title: String
    let priority: TaskPriority
    let dueDate: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            
            HStack {
                Label("Due: \(dueDate.formatted(date: .abbreviated, time: .shortened))", systemImage: "calendar")
                Spacer()
                Circle()
                    .fill(priority.color)
                    .frame(width: 12, height: 12)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(radius: 2)
    }
}

#Preview {
    TaskCardView(title: "Buy milk", priority: .medium, dueDate: Date())
}
