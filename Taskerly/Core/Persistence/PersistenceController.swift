//
//  PersistenceController.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let task = TaskEntity(context: viewContext)
            task.id = UUID()
            task.title = "Sample Task \(i + 1)"
            task.desc = "Preview task"
            task.dueDate = Date().addingTimeInterval(Double(i * 3600))
            task.priority = "medium"
            task.isCompleted = false
        }
        try? viewContext.save()
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Taskerly")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("❌ \(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }
}
