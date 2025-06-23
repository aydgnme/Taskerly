//
//  EmptyStateView.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import SwiftUI
import Lottie

struct EmptyStateAnimation: View {
    var body: some View {
        LottieView(name: "empty-box", loopMode: .loop)
            .frame(height: 240)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.5), value: true)
    }
}
