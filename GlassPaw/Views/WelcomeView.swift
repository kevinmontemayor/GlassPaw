//
//  WelcomeView.swift
//  GlassPaw
//
//  Created by Kevin Montemayor on 6/11/25.
//

import SwiftUI

@available(iOS 26.0, *)
struct WelcomeView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var hasStarted: Bool
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color.black.ignoresSafeArea()
                Image("GlassPawBackgroundDark")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                Color.white.ignoresSafeArea()
                Image("GlassPawBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            
            GlassEffectContainer {
                VStack(spacing: 24) {
                    Label("Glass Paw", systemImage: "pawprint.fill")
                        .font(.largeTitle.bold())
                        .foregroundStyle(Color.white.opacity(0.9))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .glassEffect(
                            .regular
                                .tint(.green.opacity(0.9)),
                            in: Capsule()
                        )
                        .glassEffect(
                            .regular
                                .interactive()
                        )
                    
                    Text("iOS26 Liquid Glass")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.teal.opacity(0.8))
                    
                    Button("Start") {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            hasStarted = true
                        }
                    }
                    .font(.largeTitle.bold())
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .buttonStyle(.glass)
                    .glassEffect(
                        .regular
                            .interactive()
                    )
                    .tint(.green)
                }
                .padding(32)
            }
            .padding()
        }
    }
}

#Preview {
    @Previewable @State var hasStarted: Bool = true
    ZStack {
        Color.blue.ignoresSafeArea()
        WelcomeView(hasStarted: $hasStarted)
    }
}
