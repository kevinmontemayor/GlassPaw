//
//  GlassUsage.swift
//  GlassPaw
//
//  Created by Kevin Montemayor on 6/11/25.
//

import SwiftUI

@available(iOS 26.0, *)
struct GlassUsage: View {
    
    private var pawLabel: some View {
        Label("", systemImage: "pawprint.fill")
            .font(.title2.bold())
            .labelStyle(.iconOnly)
            .foregroundStyle(Color.white.opacity(0.4))
            .frame(width: 76, height: 48)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Glass Usage")
                .font(.title2.bold())
                .foregroundStyle(.white)
            
            HStack(spacing: 24) {
                VStack {
                    label("Default")
                        .foregroundStyle(.white)
                    pawLabel
                        .glassEffect()
                }
                VStack {
                    label("Shape")
                        .foregroundStyle(.white)
                    pawLabel
                        .glassEffect(
                            .regular,
                            in: RoundedRectangle(cornerRadius: 8)
                        )
                }
                VStack {
                    label("Tint")
                        .foregroundStyle(.white)
                    pawLabel
                        .glassEffect(
                            .regular
                                .tint(.blue.opacity(0.35)),
                            in: RoundedRectangle(cornerRadius: 8)
                        )
                }
                VStack {
                    label("Interactive")
                        .foregroundStyle(.white)
                    pawLabel
                        .glassEffect(
                            .regular
                                .interactive()
                        )
                }
            }
            
            VStack(alignment: .leading) {
                label("ButtonStyle")
                    .foregroundStyle(.white)
                Button(action: {}) {
                    pawLabel
                }
                .buttonStyle(.glass)
            }
        }
        .padding()
    }
    
    private func label(_ text: String) -> some View {
        Text(text)
            .font(.subheadline)
            .fixedSize()
    }
}

#Preview {
    ZStack {
        Color.blue.opacity(1.2)
        Image("mountain-river")
        GlassUsage()
    }
}
