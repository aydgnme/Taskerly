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
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            HStack(spacing: 10) {
                Label("Due: \(dueDate.formatted(date: .abbreviated, time: .shortened))", systemImage: "calendar")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                HStack(spacing: 4) {
                    Circle()
                        .fill(priority.color)
                        .frame(width: 10, height: 10)
                    Text(priority.displayName)
                        .font(.caption)
                        .foregroundColor(priority.color)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(priority.color.opacity(0.12))
                )
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color("AppCard", bundle: nil) ?? Color.white)
                .shadow(color: Color(.systemGray3).opacity(0.18), radius: 6, x: 0, y: 2)
        )
        .padding(.vertical, 2)
    }
}

#Preview {
    TaskCardView(title: "Buy milk", priority: .medium, dueDate: Date())
}
