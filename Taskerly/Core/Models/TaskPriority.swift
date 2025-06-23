//
//  TaskPriority.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import SwiftUI

enum TaskPriority: String, CaseIterable, Identifiable {
    case low, medium, high

    var id: String { self.rawValue }

    var color: Color {
        switch self {
        case .low: return .green
        case .medium: return .orange
        case .high: return .red
        }
    }

    var displayName: String {
        rawValue.capitalized
    }
}
