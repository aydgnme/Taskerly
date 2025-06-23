//
//  TaskRowView.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import SwiftUI

struct TaskRowView: View {
    let task: TaskEntity
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Button(action: onToggle) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
                    .font(.title2)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(task.isCompleted ? Color.green.opacity(0.15) : Color(.systemGray5))
                    )
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(task.title ?? "Untitled")
                    .strikethrough(task.isCompleted)
                    .foregroundColor(task.isCompleted ? .gray : .primary)
                    .font(.headline)
                HStack(spacing: 8) {
                    if let date = task.dueDate {
                        Label(date.formatted(date: .abbreviated, time: .shortened), systemImage: "calendar")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    if let priorityRaw = task.priority, let priority = TaskPriority(rawValue: priorityRaw) {
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
