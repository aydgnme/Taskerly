//
//  ModernFormComponents.swift
//  Taskerly
//
//  Shared modern form UI components for AddTaskView and TaskEditView
//

import SwiftUI

extension View {
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