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
        HStack {
            Button(action: onToggle) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
            VStack(alignment: .leading) {
                Text(task.title ?? "Untitled")
                    .strikethrough(task.isCompleted)
                    .foregroundStyle(task.isCompleted ? .gray : .primary)
                HStack {
                    Text(task.dueDate?.formatted(date: .abbreviated, time: .shortened) ?? "")
                    Spacer()
                    Text(task.priority?.capitalized ?? "")
                        .foregroundColor(TaskPriority(rawValue: task.priority ?? "medium")?.color ?? .gray)
                        .font(.caption)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
