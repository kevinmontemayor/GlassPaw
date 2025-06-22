//
//  PawTapTrail.swift
//  GlassPaw
//
//  Created by Kevin Montemayor on 6/18/25.
//

import SwiftUI

@available(iOS 26.0, *)
struct PawTapTrail: View {
    let position: CGPoint
    let duration: Double = 1.2
    @State private var opacity: Double = 1.0

    var body: some View {
        Canvas { context, size in
            let paw = Image(systemName: "pawprint.fill")
            let resolved = context.resolve(paw)

            for i in 0..<4 {
                let verticalOffset = CGFloat(i) * -24.0

                // Alternate step direction: left, right, left...
                let stepDirection: CGFloat = i.isMultiple(of: 2) ? -16 : 16
                let jitterX = CGFloat.random(in: -4...4)

                let drawPoint = CGPoint(
                    x: position.x + stepDirection + jitterX,
                    y: position.y + verticalOffset + CGFloat.random(in: -4...4)
                )

                context.opacity = opacity * (1.0 - Double(i) * 0.15)
                context.draw(resolved, at: drawPoint)
            }
        }
        .foregroundStyle(.black)
        .glassEffectTransition(.identity)
        .allowsHitTesting(false)
        .onAppear {
            withAnimation(.easeOut(duration: duration)) {
                opacity = 0.0
            }
        }
    }
}

@available(iOS 26.0, *)
struct PawTapTrailPreviewInteractive: View {
    @State private var position: CGPoint = .zero
    @State private var showTrail = false
    
    var body: some View {
        ZStack {
            Color.green.opacity(0.6).ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                
                if showTrail {
                    PawTapTrail(position: position)
                        .transition(.opacity)
                }
                
                Spacer()
                
                Button("Paws") {
                    position = CGPoint(x: 200, y: 300)
                    showTrail = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        showTrail = false
                    }
                }
                .buttonStyle(.glass)
                .padding(.bottom)
            }
        }
    }
}

@available(iOS 26.0, *)
#Preview("Interactive PawTapTrail") {
    PawTapTrailPreviewInteractive()
        .frame(width: 400, height: 600)
}
