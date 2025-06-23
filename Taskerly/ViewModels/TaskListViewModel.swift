//
//  TaskListViewModel.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import Foundation
import CoreData
import Combine

final class TaskListViewModel: ObservableObject {
    @Published var tasks: [TaskEntity] = []
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.context) {
        self.context = context
        fetchTasks()
    }

    func fetchTasks() {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TaskEntity.dueDate, ascending: true)]
        tasks = (try? context.fetch(request)) ?? []
    }

    func addTask(title: String, desc: String?, dueDate: Date, priority: TaskPriority, isCompleted: Bool = false) {
        let task = TaskEntity(context: context)
        task.id = UUID()
        task.title = title
        task.desc = desc
        task.dueDate = dueDate
        task.priority = priority.rawValue
        task.isCompleted = isCompleted
        saveChanges()
    }

    func deleteTask(at offsets: IndexSet) {
        offsets.forEach { context.delete(tasks[$0]) }
        saveChanges()
    }

    func toggleCompletion(_ task: TaskEntity) {
        task.isCompleted.toggle()
        
        if task.isCompleted, let id = task.id?.uuidString {
            NotificationService.cancelNotification(id: id)
        }
        
        saveChanges()
    }

    private func saveChanges() {
        try? context.save()
        fetchTasks()
    }
}
