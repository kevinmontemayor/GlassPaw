//
//  GlassContainer.swift
//  GlassPaw
//
//  Created by Kevin Montemayor on 6/13/25.
//

import SwiftUI

@available(iOS 26.0, *)
struct GlassContainer: View {
    // MARK: - Bindings for control via parent view
    @Binding var offsetX: CGFloat
    @Binding var offsetY: CGFloat
    @Binding var containerSpacing: CGFloat
    @Binding var showSecondPaw: Bool
    
    // MARK: - View Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Glass Effect Container")
                .font(.title3.bold())
                .foregroundStyle(.white)
            
            // MARK: - Control Sliders
            sliders
            
            // MARK: - Paw Layout in GlassEffectContainer
            HStack(spacing: 24) {
                Button("Show / Hide") {
                    withAnimation(.linear(duration: 0.7)) {
                        showSecondPaw.toggle()
                    }
                }
                .buttonStyle(.glass)
                .foregroundStyle(.white)
                .bold()
                
                GlassEffectContainer(spacing: containerSpacing) {
                    HStack(spacing: 8) {
                        pawImage()
                        if showSecondPaw {
                            pawImage()
                                .offset(x: offsetX, y: offsetY)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: - Paw Image View
    @ViewBuilder
    func pawImage() -> some View {
        Image(systemName: "pawprint.fill")
            .frame(width: 48, height: 48)
            .font(.system(size: 22))
            .foregroundStyle(.white)
            .glassEffect(.regular.tint(.green.opacity(0.25)), in: Capsule())
    }
    
    // MARK: - Slider Controls Group
    @ViewBuilder
    var sliders: some View {
        VStack(spacing: 12) {
            sliderRow(title: "Offset X", value: $offsetX, range: -60...0)
                .foregroundStyle(.white)
            sliderRow(title: "Offset Y", value: $offsetY, range: -20...20)
                .foregroundStyle(.white)
            sliderRow(title: "Container spacing", value: $containerSpacing, range: 0...100)
                .foregroundStyle(.white)
        }
        .font(.caption)
    }
    
    // MARK: - Single Slider Row Generator
    @ViewBuilder
    func sliderRow(title: String, value: Binding<CGFloat>, range: ClosedRange<CGFloat>) -> some View {
        GlassEffectContainer {
            HStack(spacing: 12) {
                Text(title)
                    .frame(width: 140, alignment: .leading)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                Slider(value: value, in: range, step: 10)
                    .tint(.green)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .glassEffect(.regular.interactive().tint(.green.opacity(0.2)), in: Capsule())
        }
    }
}

// MARK: - Preview
@available(iOS 26.0, *)
struct GlassContainer_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
            .previewDisplayName("Interactive GlassContainer")
    }
    
    struct PreviewWrapper: View {
        @State private var offsetX: CGFloat = -30
        @State private var offsetY: CGFloat = 0
        @State private var containerSpacing: CGFloat = 30
        @State private var showSecondPaw: Bool = true
        
        var body: some View {
            ZStack {
                Image("orion")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                GlassContainer(
                    offsetX: $offsetX,
                    offsetY: $offsetY,
                    containerSpacing: $containerSpacing,
                    showSecondPaw: $showSecondPaw
                )
                .padding(.horizontal, 100)
            }
        }
    }
}
