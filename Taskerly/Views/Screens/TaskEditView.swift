//
//  TaskEditView.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import SwiftUI

struct TaskEditView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: TaskEditViewModel
    @State private var showAlert = false
    @State private var errorMessage = ""

    init(task: TaskEntity) {
        _viewModel = StateObject(wrappedValue: TaskEditViewModel(task: task))
    }

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

                Section("Completed") {
                    Toggle("Mark as completed", isOn: $viewModel.isCompleted)
                }
            }
            .navigationTitle("Edit Task")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        do {
                            try viewModel.saveChanges()
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
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
    }
}
