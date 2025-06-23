//
//  TaskEditViewModel.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import Foundation
import SwiftUI
import CoreData
import Combine

@MainActor
final class TaskEditViewModel: ObservableObject {
    @Published var title: String
    @Published var desc: String
    @Published var dueDate: Date
    @Published var priority: TaskPriority
    @Published var isCompleted: Bool

    private let context: NSManagedObjectContext
    private let task: TaskEntity

    init(task: TaskEntity, context: NSManagedObjectContext = PersistenceController.shared.context) {
        self.task = task
        self.context = context
        self.title = task.title ?? ""
        self.desc = task.desc ?? ""
        self.dueDate = task.dueDate ?? Date()
        self.priority = TaskPriority(rawValue: task.priority ?? "medium") ?? .medium
        self.isCompleted = task.isCompleted
    }

    func saveChanges() throws {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw ValidationError.emptyTitle
        }

        task.title = title
        task.desc = desc.isEmpty ? nil : desc
        task.dueDate = dueDate
        task.priority = priority.rawValue
        task.isCompleted = isCompleted

        try context.save()
    }

    enum ValidationError: LocalizedError {
        case emptyTitle
        var errorDescription: String? { "The task title cannot be empty." }
    }
}
