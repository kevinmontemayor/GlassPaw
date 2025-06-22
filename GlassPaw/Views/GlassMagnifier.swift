//
//  GlassMagnifier.swift
//  GlassPaw
//
//  Created by Kevin Montemayor on 6/21/25.
//

import SwiftUI

@available(iOS 26.0, *)
struct GlassMagnifier: View {
    // MARK: - State
    @State private var baseFontSize: CGFloat = 16
    @State private var magnification: CGFloat = 2.0
    @State private var lensPosition: CGPoint = .zero
    @State private var showLens = false
    
    // MARK: - Text
    private let lorem = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. \
    Phasellus imperdiet, nulla et dictum interdum, nisi lorem egestas odio.
    """
    
    // MARK: - View Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // MARK: - Title
            Text("Text Magnifier")
                .font(.title3.bold())
                .foregroundStyle(.white)
            
            // MARK: - Font Size Slider
            GlassEffectContainer {
                HStack {
                    Text("Adjust Size")
                        .font(.caption)
                        .foregroundStyle(.white)
                    Slider(value: $baseFontSize, in: 12...40, step: 1)
                        .tint(.green)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .glassEffect(
                    .regular.interactive().tint(.green.opacity(0.2)),
                    in: Capsule()
                )
            }
            
            // MARK: - Magnified Text Display
            GlassEffectContainer(spacing: 0) {
                ZStack {
                    Text(lorem)
                        .font(.system(size: baseFontSize))
                        .foregroundStyle(.white.opacity(0.9))
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                }
            }
            .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 12))
        }
        .padding()
    }
}

// MARK: - Preview
struct GlassMagnifier_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Image("orion")
                .resizable()
                .ignoresSafeArea()
            GlassMagnifier()
        }
    }
}
