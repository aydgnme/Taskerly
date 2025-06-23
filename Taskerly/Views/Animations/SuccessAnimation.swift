//
//  SuccessAnimation.swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import SwiftUI
import Lottie

struct SuccessAnimation: View {
    var body: some View {
        LottieView(name: "success-check", loopMode: .playOnce)
            .frame(height: 180)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.5), value: true)
    }
}
