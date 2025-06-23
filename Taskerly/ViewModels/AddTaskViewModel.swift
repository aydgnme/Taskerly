//
//  AddTaskViewModel.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import Foundation
import SwiftUI
import CoreData
import Combine

@MainActor
final class AddTaskViewModel: ObservableObject {
    @Published var title = ""
    @Published var desc = ""
    @Published var dueDate = Date()
    @Published var priority: TaskPriority = .medium

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.context) {
        self.context = context
    }

    func saveTask() throws {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw ValidationError.emptyTitle
        }

        let task = TaskEntity(context: context)
        task.id = UUID()
        task.title = title
        task.desc = desc.isEmpty ? nil : desc
        task.dueDate = dueDate
        task.priority = priority.rawValue
        task.isCompleted = false

        try context.save()
    }

    enum ValidationError: LocalizedError {
        case emptyTitle
        var errorDescription: String? { "The task title cannot be empty." }
    }
}
