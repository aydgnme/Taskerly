//
//  LoadingAnimation.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import SwiftUI
import Lottie

struct LoadingAnimation: View {
    var body: some View {
        LottieView(name: "loading-spinner", loopMode: .loop)
            .frame(height: 120)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.5), value: true)
    }
}
