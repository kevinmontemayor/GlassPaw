//
//  GlassPawApp.swift
//  GlassPaw
//
//  Created by Kevin Montemayor on 6/11/25.
//

import SwiftUI

@main
@available(iOS 26.0, *)
struct GlassPawApp: App {
    @State private var showLaunchScreen = true
    @State private var hasStarted = false

    var body: some Scene {
        WindowGroup {
            ZStack {
                if hasStarted {
                    LiquidGlassPaw()
                        .transition(.opacity)
                } else if showLaunchScreen {
                    LaunchScreenView()
                        .transition(.opacity)
                } else {
                    WelcomeView(hasStarted: $hasStarted)
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.6), value: showLaunchScreen)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        showLaunchScreen = false
                    }
                }
            }
        }
    }
}
