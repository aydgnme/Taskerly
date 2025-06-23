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
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(spacing: 28) {
                        modernSectionHeader(title: "Title", systemImage: "textformat")
                        modernTextField(text: $viewModel.title, placeholder: "Enter task title")
                        modernSectionHeader(title: "Description", systemImage: "text.alignleft")
                        modernTextField(text: $viewModel.desc, placeholder: "Optional description")
                        modernSectionHeader(title: "Due Date", systemImage: "calendar")
                        modernDatePicker(date: $viewModel.dueDate)
                        modernSectionHeader(title: "Priority", systemImage: "flag.fill")
                        modernPriorityPicker(selection: $viewModel.priority)
                        if !errorMessage.isEmpty {
                            HStack(spacing: 8) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.red)
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.red.opacity(0.08))
                            )
                            .transition(.opacity)
                        }
                        Spacer(minLength: 80)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 24)
                    .padding(.bottom, 40)
                }
                .background(Color("AppBackground").ignoresSafeArea())
                // Fixed bottom bar with Cancel and Save buttons
                VStack(spacing: 12) {
                    Button(action: { dismiss() }) {
                        Text("Cancel")
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                Capsule()
                                    .fill(Color(.systemGray5))
                                    .shadow(color: Color(.systemGray3).opacity(0.18), radius: 4, x: 0, y: 2)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    Button(action: {
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
                            withAnimation { errorMessage = error.localizedDescription }
                            showAlert = true
                        }
                    }) {
                        Text("Save")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                Capsule()
                                    .fill(Color.accentColor)
                            )
                            .shadow(color: Color.blue.opacity(0.18), radius: 6, x: 0, y: 3)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
                .background(
                    Color(.systemGray6)
                        .ignoresSafeArea(edges: .bottom)
                        .opacity(0.98)
                )
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { errorMessage = "" }
            } message: {
                Text(errorMessage)
            }
        }
    }
}

#Preview {
    AddTaskView()
}
