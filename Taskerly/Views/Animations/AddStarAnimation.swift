//
//  AddStarAnimation.swift .swift
//  Taskerly
//
//  Created by Mert Aydogan on 23.06.2025.
//

import SwiftUI

import SwiftUI
import Lottie

struct AddStarAnimation: View {
    var body: some View {
        LottieView(name: "add-star", loopMode: .playOnce)
            .frame(height: 180)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.5), value: true)
    }
}
