//
//  ErrorAnimation.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import SwiftUI
import Lottie

struct ErrorAnimation: View {
    var body: some View {
        LottieView(name: "error-cross", loopMode: .playOnce)
            .frame(height: 180)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.5), value: true)
    }
}
