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
                        modernSectionHeader(title: "Completed", systemImage: "checkmark.circle")
                        modernToggle(isOn: $viewModel.isCompleted, label: "Mark as completed")
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
                            try viewModel.saveChanges()
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
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.blue, Color.accentColor],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .shadow(color: Color.blue.opacity(0.18), radius: 6, x: 0, y: 3)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .scaleEffect(showAlert ? 1.05 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: showAlert)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
                .background(
                    Color(.systemGray6)
                        .ignoresSafeArea(edges: .bottom)
                        .opacity(0.98)
                )
            }
            .navigationTitle("Edit Task")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { errorMessage = "" }
            } message: {
                Text(errorMessage)
            }
        }
    }
}

// MARK: - Modern Components
private extension TaskEditView {
    @ViewBuilder
    func modernSectionHeader(title: String, systemImage: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
                .foregroundColor(.accentColor)
                .font(.headline)
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(.bottom, 2)
    }

    func modernTextField(text: Binding<String>, placeholder: String) -> some View {
        TextField(placeholder, text: text)
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white)
                    .shadow(color: Color(.systemGray3).opacity(0.10), radius: 4, x: 0, y: 2)
            )
    }

    func modernDatePicker(date: Binding<Date>) -> some View {
        HStack {
            DatePicker("", selection: date, displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()
                .datePickerStyle(.compact)
            Spacer()
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
                .shadow(color: Color(.systemGray3).opacity(0.10), radius: 4, x: 0, y: 2)
        )
    }

    func modernPriorityPicker(selection: Binding<TaskPriority>) -> some View {
        HStack(spacing: 0) {
            ForEach(TaskPriority.allCases) { priority in
                let isSelected = selection.wrappedValue == priority
                Button(action: { selection.wrappedValue = priority }) {
                    HStack(spacing: 6) {
                        Image(systemName: "flag.fill")
                            .foregroundColor(isSelected ? .white : priority.color)
                        Text(priority.displayName)
                            .fontWeight(isSelected ? .semibold : .regular)
                            .foregroundColor(isSelected ? .white : .black)
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 14)
                    .background(
                        Group {
                            if isSelected {
                                priority.color.opacity(0.85)
                            }
                        }
                    )
                    .clipShape(Capsule())
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
                .shadow(color: Color(.systemGray3).opacity(0.10), radius: 4, x: 0, y: 2)
        )
    }

    func modernToggle(isOn: Binding<Bool>, label: String) -> some View {
        Toggle(isOn: isOn) {
            HStack(spacing: 8) {
                Image(systemName: isOn.wrappedValue ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isOn.wrappedValue ? .green : .gray)
                Text(label)
            }
        }
        .toggleStyle(SwitchToggleStyle(tint: .green))
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
                .shadow(color: Color(.systemGray3).opacity(0.10), radius: 4, x: 0, y: 2)
        )
    }
}
