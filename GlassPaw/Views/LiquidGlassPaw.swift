//
//  LiquidGlassPaw.swift
//  GlassPaw
//
//  Created by Kevin Montemayor on 6/11/25.
//

import SwiftUI

@available(iOS 26.0, *)
struct LiquidGlassPaw: View {
    @Environment(\.colorScheme) private var colorScheme

    // MARK: - State for various UI interactions
    @State private var selectedSection: Section?
    @State private var offsetX: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    @State private var containerSpacing: CGFloat = 30.0
    @State private var showSecondPaw: Bool = true
    @State private var tapLocation: CGPoint = .zero
    @State private var showTrail = false
    @State private var isToolbarVisible = false
    
    // MARK: - Matched geometry namespace for Liquid Glass effects
    @Namespace private var glassNamespace1
    @Namespace private var glassNamespace2
    @Namespace private var toolbarNamespace
    
    // MARK: - Enum for active content section
    enum Section: String, CaseIterable {
        case basic = "Basic"
        case container = "Container"
        case magnifier = "Magnifier"
        case id = "Effect ID"
        case union = "Union"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Background: gradient or images based on color scheme
                GeometryReader { geo in
                    ZStack(alignment: .top) {
                        if colorScheme == .light {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.blue.opacity(0.8),
                                    Color.white.opacity(0.0)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            .ignoresSafeArea()
                        }

                        if colorScheme == .dark {
                            Image("orion")
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: geo.size.width,
                                    height: geo.size.height * 0.6,
                                    alignment: .bottom
                                )
                                .ignoresSafeArea(edges: .top)
                                .transition(.opacity)
                                .zIndex(0)
                        }
                        
                        Image("mountain-river")
                            .resizable()
                            .scaledToFill()
                            .padding(.top, 500.0)
                            .frame(
                                width: geo.size.width,
                                height: geo.size.height * 1.0,
                                alignment: .bottom
                            )
                            .ignoresSafeArea()
                            .zIndex(1)
                    }
                    .frame(width: geo.size.width, height: geo.size.height)
                }
                .ignoresSafeArea()
                .zIndex(0)
                
                // MARK: - Foreground scrollable content
                ScrollView {
                    VStack(spacing: 0) {
                        ZStack {
                            Color.clear.frame(height: 0)
                            sectionView()
                        }
                        .animation(.easeInOut(duration: 0.4), value: selectedSection)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .zIndex(1)
                
                // MARK: - Toolbar (GlassEffect toggle and section controls)
                toolbarOverlay
                    .zIndex(3)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        // MARK: - Gesture: tap to trigger paw trail
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onEnded { value in
                    tapLocation = value.location
                    showTrail = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        showTrail = false
                    }
                }
        )
    }
    
    // MARK: - Section Switching Logic
    @ViewBuilder
    private func sectionView() -> some View {
        switch selectedSection {
        case .basic:
            GlassUsage()
                .frame(maxWidth: .infinity)
                .transition(.move(edge: .bottom))
        case .container:
            GlassContainer(
                offsetX: $offsetX,
                offsetY: $offsetY,
                containerSpacing: $containerSpacing,
                showSecondPaw: $showSecondPaw
            )
            .frame(maxWidth: .infinity)
            .transition(.move(edge: .bottom))
        case .magnifier:
            GlassMagnifier()
        case .id:
            GlassEffectID(
                showSecondPaw: $showSecondPaw,
                namespace1: glassNamespace1,
                namespace2: glassNamespace2
            )
            .frame(maxWidth: .infinity)
            .transition(.move(edge: .bottom))
        case .union:
            GlassEffectUnion(namespace: glassNamespace1)
                .frame(maxWidth: .infinity)
                .transition(.move(edge: .bottom))
        case .none:
            EmptyView()
        }
    }
    
    // MARK: - Toolbar UI with Liquid Glass toggle
    private var toolbarOverlay: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottomLeading) {
                if isToolbarVisible {
                    GlassEffectContainer(spacing: 8) {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(Section.allCases, id: \.self) { section in
                                Button {
                                    withAnimation(.spring(duration: 0.5)) {
                                        selectedSection = section
                                    }
                                } label: {
                                    HStack(spacing: 6) {
                                        Image(systemName: symbol(for: section))
                                        Text(section.rawValue)
                                            .font(.caption2)
                                    }
                                    .padding(8)
                                }
                                .buttonStyle(.glass)
                                .tint(
                                    selectedSection == section
                                        ? .green.opacity(0.8)
                                        : Color.primary.opacity(0.8)
                                )
                                .glassEffectID(section, in: toolbarNamespace)
                            }
                        }
                        .padding(12)
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .padding(.leading, 16)
                    .padding(.bottom, 70)
                }
                
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isToolbarVisible.toggle()
                    }
                } label: {
                    Image(systemName: "pawprint.fill")
                        .rotationEffect(.degrees(isToolbarVisible ? 180 : 0))
                        .scaleEffect(isToolbarVisible ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: isToolbarVisible)
                }
                .buttonStyle(.glass)
                .glassEffectID("toolbarToggle", in: toolbarNamespace)
                .padding(.leading, 16)
                .padding(.bottom, 16)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .bottomLeading)
        }
        .ignoresSafeArea()
        .glassEffectTransition(.matchedGeometry(properties: [.frame]))
    }
    
    // MARK: - Symbol mapping per section
    private func symbol(for section: Section) -> String {
        switch section {
        case .basic:
            return "pawprint"
        case .container:
            return "square.grid.2x2"
        case .magnifier:
            return "magnifyingglass"
        case .id:
            return "number"
        case .union:
            return "link"
        }
    }
}

@available(iOS 26.0, *)
#Preview {
    LiquidGlassPaw()
}
