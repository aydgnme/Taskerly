//
//  AddTaskView.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import SwiftUI
import CoreData

struct AddTaskView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = AddTaskViewModel()
    @State private var showAlert = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("Enter task title", text: $viewModel.title)
                }
                Section("Description") {
                    TextField("Optional description", text: $viewModel.desc)
                }
                Section("Due Date") {
                    DatePicker("Select date", selection: $viewModel.dueDate, displayedComponents: [.date, .hourAndMinute])
                }
                Section("Priority") {
                    Picker("Priority", selection: $viewModel.priority) {
                        ForEach(TaskPriority.allCases) { priority in
                            Text(priority.displayName).tag(priority)
                        }
                    }.pickerStyle(.segmented)
                }
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        do {
                            let task = TaskEntity(context: context)
                            let uuid = UUID()
                            task.id = uuid
                            NotificationService.scheduleNotification(
                                id: uuid.uuidString,
                                title: viewModel.title,
                                date: viewModel.dueDate
                            )
                            task.title = viewModel.title
                            task.desc = viewModel.desc.isEmpty ? nil : viewModel.desc
                            task.dueDate = viewModel.dueDate
                            task.priority = viewModel.priority.rawValue
                            task.isCompleted = false

                            try context.save()
                            dismiss()
                        } catch {
                            errorMessage = error.localizedDescription
                            showAlert = true
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
    }
}

#Preview {
    AddTaskView()
}
