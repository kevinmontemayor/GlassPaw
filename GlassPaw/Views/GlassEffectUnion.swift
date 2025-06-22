//
//  GlassEffectUnion.swift
//  GlassPaw
//
//  Created by Kevin Montemayor on 6/13/25.
//

import SwiftUI

@available(iOS 26.0, *)
struct GlassEffectUnion: View {
    var namespace: Namespace.ID
    
    @State private var group0Offset: CGFloat = 0
    @State private var group1Offset: CGFloat = 0
    @State private var showGroup1 = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Glass Effect Union")
                .font(.title3.bold())
                .foregroundStyle(.white)
            
            sliders
            
            GlassEffectContainer(spacing: 40) {
                HStack(spacing: 24) {
                    ForEach(0..<2) { i in
                        pawImage(tint: .green)
                            .offset(x: CGFloat(i) * group0Offset)
                            .glassEffectUnion(id: 0, namespace: namespace)
                            .background(.clear)
                    }
                    
                    if showGroup1 {
                        ForEach(2..<4) { i in
                            pawImage(tint: .yellow)
                                .offset(x: CGFloat(i - 2) * group1Offset)
                                .glassEffectUnion(id: 1, namespace: namespace)
                        }
                    }
                }
            }
            .id(showGroup1 ? "merged" : "split")
            
            Button(showGroup1 ? "Hide Group 1" : "Show Group 1") {
                withAnimation(.linear(duration: 0.7)) {
                    showGroup1.toggle()
                }
            }
            .buttonStyle(.glass)
            .foregroundStyle(.white)
            .tint(.green)
            .bold()
            .padding(.top, 12)
        }
        .padding(.horizontal, 16)
    }

    // MARK: - Sliders
    
    @ViewBuilder
    var sliders: some View {
        VStack(spacing: 12) {
            sliderRow(title: "Group 0 Spacing", value: $group0Offset, range: -40...40)
            sliderRow(title: "Group 1 Spacing", value: $group1Offset, range: -40...40)
        }
    }
    
    @ViewBuilder
    func sliderRow(title: String, value: Binding<CGFloat>, range: ClosedRange<CGFloat>) -> some View {
        GlassEffectContainer {
            HStack(spacing: 12) {
                Text(title)
                    .frame(width: 140, alignment: .leading)
                    .foregroundStyle(.white)
                    .font(.caption)
                Slider(value: value, in: range)
                    .tint(.green)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .glassEffect(.regular.interactive().tint(.green.opacity(0.2)), in: Capsule())
        }
    }
    
    // MARK: - Paws with label overlays
    
    @ViewBuilder
    func pawImage(tint: Color) -> some View {
        ZStack(alignment: .bottomTrailing) {
            Image(systemName: "pawprint.fill")
                .frame(width: 52, height: 52)
                .font(.system(size: 24))
                .foregroundStyle(.white)
                .glassEffect(.regular.tint(tint.opacity(0.25)), in: Capsule())
        }
    }
}

// MARK: - Preview
@available(iOS 26.0, *)
#Preview {
    @Previewable @Namespace var demoNS
    ZStack {
        Color.blue.opacity(1.2)
        Image("mountain-river")
        GlassEffectUnion(namespace: demoNS)
            .padding(.horizontal, 300)
    }
}
