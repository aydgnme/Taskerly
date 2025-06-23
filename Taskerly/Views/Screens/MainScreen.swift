//
//  MainScreen.swift
//  Taskerly
//
//  Main entry screen with tab navigation for Tasks and Settings
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        TabView {
            TaskListView()
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Tasks")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    MainScreen()
} 