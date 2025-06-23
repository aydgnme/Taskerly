//
//  TaskListView.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//
import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskListViewModel()
    @State private var showAddTask = false
    @State private var selectedTask: TaskEntity?
    @State private var showSuccess = false
    @State private var showError = false
    @State private var isLoading = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                // Use app background color
                Color("AppBackground")
                    .ignoresSafeArea()
                if viewModel.tasks.isEmpty {
                    EmptyStateView()
                        .transition(.opacity)
                        .padding(.top, 80)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.tasks) { task in
                                NavigationLink(destination: TaskEditView(task: task)) {
                                    TaskRowView(task: task) {
                                        withAnimation {
                                            viewModel.toggleCompletion(task)
                                        }
                                    }
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        if let index = viewModel.tasks.firstIndex(of: task) {
                                            viewModel.deleteTask(at: IndexSet(integer: index))
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal)
                    }
                }

                // Floating Add Button
                Button {
                    showAddTask.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.accentColor))
                        .shadow(radius: 5)
                }
                .padding()
                .sheet(isPresented: $showAddTask) {
                    AddTaskView()
                }
                
                .sheet(item: $selectedTask) { task in
                    TaskEditView(task: task)
                }

                if isLoading {
                    LoadingAnimation()
                        .frame(width: 100, height: 100)
                        .zIndex(10)
                }
                if showSuccess {
                    SuccessAnimation()
                        .frame(width: 120, height: 120)
                        .zIndex(10)
                }
                if showError {
                    ErrorAnimation()
                        .frame(width: 120, height: 120)
                        .zIndex(10)
                }
            }
            .navigationTitle("My Tasks")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    TaskListView()
}
