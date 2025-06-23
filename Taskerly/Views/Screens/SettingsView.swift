//
//  SettingsView.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    // MARK: - Properties
    @AppStorage("hideCompleted") private var hideCompleted: Bool = false
    @State private var notificationsEnabled = false
    @Environment(\.colorScheme) private var colorScheme
    @State private var animateGradient = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                // Use app background color
                Color("AppBackground")
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 32) {
                        heroSection
                        preferencesSection
                        systemSection
                        aboutSection
                        Spacer(minLength: 80)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .onAppear(perform: checkNotificationStatus)
        }
    }
}

// MARK: - View Components
private extension SettingsView {
    
    var heroSection: some View {
        VStack(spacing: 24) {
            // Animated hero icon
            ZStack {
                Circle()
                    .fill(Color.accentColor.opacity(0.15))
                    .frame(width: 140, height: 140)
                    .blur(radius: 16)
                Circle()
                    .fill(Color.white)
                    .frame(width: 110, height: 110)
                    .shadow(color: Color(.systemGray3), radius: 12, x: 0, y: 4)
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.accentColor)
            }
            .accessibilityLabel("Settings icon")
            
            VStack(spacing: 8) {
                Text("Settings")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                Text("Customize your Taskerly experience")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.top, 20)
    }
    
    var preferencesSection: some View {
        modernSettingsSection(title: "Preferences", icon: "slider.horizontal.3") {
            VStack(spacing: 16) {
                modernToggleRow(
                    title: "Hide Completed Tasks",
                    subtitle: "Keep your task list clean",
                    icon: "checkmark.circle.fill",
                    isOn: $hideCompleted,
                    iconColor: .blue
                )
            }
        }
    }
    
    var systemSection: some View {
        modernSettingsSection(title: "System", icon: "gearshape.2") {
            VStack(spacing: 16) {
                modernInfoRow(
                    title: "Dark Mode",
                    subtitle: colorScheme == .dark ? "Currently enabled" : "Currently disabled",
                    icon: colorScheme == .dark ? "moon.fill" : "sun.max.fill",
                    status: colorScheme == .dark ? .enabled : .disabled,
                    iconColor: .yellow
                )
                modernInfoRow(
                    title: "Notifications",
                    subtitle: notificationsEnabled ? "Push notifications active" : "Notifications disabled",
                    icon: "bell.fill",
                    status: notificationsEnabled ? .enabled : .disabled,
                    iconColor: .orange
                )
            }
        }
    }
    
    var aboutSection: some View {
        modernSettingsSection(title: "About", icon: "info.circle") {
            VStack(spacing: 16) {
                modernInfoRow(
                    title: "Version",
                    subtitle: "Current release",
                    icon: "tag.fill",
                    status: .info,
                    iconColor: .accentColor,
                    trailingText: "1.0"
                )
                modernInfoRow(
                    title: "Developer",
                    subtitle: "Mert Aydogan",
                    icon: "person.fill",
                    status: .info,
                    iconColor: .accentColor
                )
            }
        }
    }
}

// MARK: - Modern Components
private extension SettingsView {
    @ViewBuilder
    func modernSettingsSection<Content: View>(
        title: String,
        icon: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.accentColor)
                    .frame(width: 24, height: 24)
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Spacer()
            }
            .accessibilityAddTraits(.isHeader)
            VStack(spacing: 0) {
                content()
            }
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: Color(.systemGray3).opacity(0.25), radius: 8, x: 0, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
            )
        }
    }
    
    func modernToggleRow(
        title: String,
        subtitle: String,
        icon: String,
        isOn: Binding<Bool>,
        iconColor: Color
    ) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
                .background(
                    Circle()
                        .fill(iconColor)
                )
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Toggle("", isOn: isOn)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                .labelsHidden()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(subtitle)")
        .accessibilityHint("Toggle to \(isOn.wrappedValue ? "disable" : "enable") this setting")
    }
    
    func modernInfoRow(
        title: String,
        subtitle: String,
        icon: String,
        status: RowStatus,
        iconColor: Color,
        trailingText: String? = nil
    ) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
                .background(
                    Circle()
                        .fill(iconColor)
                )
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if let trailingText = trailingText {
                Text(trailingText)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color(.systemGray5))
                    )
            } else {
                Image(systemName: status.statusIcon)
                    .font(.caption)
                    .foregroundColor(status.statusColor)
                    .frame(width: 20, height: 20)
                    .background(
                        Circle()
                            .fill(status.statusColor.opacity(0.15))
                    )
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(subtitle)")
    }
}

// MARK: - Helper Types
private enum RowStatus {
    case enabled, disabled, info
    
    var statusIcon: String {
        switch self {
        case .enabled: return "checkmark.circle.fill"
        case .disabled: return "xmark.circle.fill"
        case .info: return "info.circle.fill"
        }
    }
    
    var statusColor: Color {
        switch self {
        case .enabled: return .green
        case .disabled: return .red
        case .info: return .blue
        }
    }
}

// MARK: - Helper Methods
private extension SettingsView {
    func checkNotificationStatus() {
        Task {
            let settings = await UNUserNotificationCenter.current().notificationSettings()
            await MainActor.run {
                notificationsEnabled = settings.authorizationStatus == .authorized
            }
        }
    }
}

// MARK: - Preview
#Preview {
    SettingsView()
}
