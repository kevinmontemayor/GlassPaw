//
//  GlassEffectID.swift
//  GlassPaw
//
//  Created by Kevin Montemayor on 6/19/25.
//

import SwiftUI

@available(iOS 26.0, *)
struct GlassEffectID: View {
    // MARK: - Bindings & Namespaces
    @Binding var showSecondPaw: Bool
    var namespace1: Namespace.ID
    var namespace2: Namespace.ID
    
    // MARK: - View Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // MARK: - Title
            Text("Glass Effect Identifiers")
                .font(.title3.bold())
                .foregroundStyle(.white)
            
            // MARK: - Controls & Comparison
            GlassEffectContainer(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    // Toggle button for showing/hiding second paw in namespace1
                    Button("Toggle Second Paw in Namespace 1") {
                        withAnimation(.linear(duration: 0.6)) {
                            showSecondPaw.toggle()
                        }
                    }
                    .buttonStyle(.glass)
                    .foregroundStyle(.white)
                    
                    // MARK: - Group 1: Shared Namespace (namespace1)
                    Text("Namespace 1")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.6))
                    
                    HStack(spacing: 16) {
                        pawImage()
                            .glassEffectID(1, in: namespace1)

                        if showSecondPaw {
                            pawImage()
                                .glassEffectID(2, in: namespace1)
                        }
                    }
                    
                    // MARK: - Group 2: Different Namespace (namespace2)
                    Text("Namespace 2")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.6))

                    HStack(spacing: 16) {
                        pawImage()
                            .glassEffectID(3, in: namespace2)
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 8)
            }
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: - Paw View with Optional Label
    @ViewBuilder
    private func pawImage() -> some View {
        ZStack(alignment: .bottomTrailing) {
            Image(systemName: "pawprint.fill")
                .frame(width: 48, height: 48)
                .font(.system(size: 22))
                .glassEffect(.regular.tint(.blue.opacity(0.25)), in: Capsule())
                .foregroundStyle(.white)
        }
    }
}

@available(iOS 26.0, *)
#Preview {
    struct GlassEffectIDPreview: View {
        @Namespace var ns1
        @Namespace var ns2
        @State private var showSecondPaw = true
        
        var body: some View {
            ZStack {
                Color.blue.opacity(1.2)
                Image("mountain-river")
                
                GlassEffectID(
                    showSecondPaw: $showSecondPaw,
                    namespace1: ns1,
                    namespace2: ns2
                )
                .padding()
            }
        }
    }
    
    return GlassEffectIDPreview()
}
