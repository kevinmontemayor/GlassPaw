//
//  LiquidGlassBackgroundModifier.swift
//  GlassPaw
//
//  Created by Kevin Montemayor on 6/13/25.
//

import SwiftUI

@available(iOS 15.0, macOS 14.0, watchOS 10.0, tvOS 15.0, visionOS 1.0, *)
public struct LiquidGlassBackgroundModifier: ViewModifier {
    
    public enum GlassBackgroundDisplayMode {
        case always
        case automatic
    }
    
    public enum GradientStyle {
        case normal
        case reverted
    }
    
    let displayMode: GlassBackgroundDisplayMode
    let radius: CGFloat
    let color: Color
    let material: Material
    let materialOpacity: Double
    let gradientOpacity: Double
    let gradientStyle: GradientStyle
    let strokeWidth: CGFloat
    let shadowColor: Color
    let shadowOpacity: Double
    let shadowRadius: CGFloat
    let shadowX: CGFloat
    let shadowY: CGFloat
    
    public init(
        displayMode: GlassBackgroundDisplayMode,
        radius: CGFloat,
        color: Color,
        material: Material = .ultraThinMaterial,
        materialOpacity: Double = 0.7,
        gradientOpacity: Double = 0.5,
        gradientStyle: GradientStyle = .normal,
        strokeWidth: CGFloat = 1.5,
        shadowColor: Color = .white,
        shadowOpacity: Double = 0.5,
        shadowRadius: CGFloat? = nil,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 5
    ) {
        self.displayMode = displayMode
        self.radius = radius
        self.color = color
        self.material = material
        self.materialOpacity = materialOpacity
        self.gradientOpacity = gradientOpacity
        self.gradientStyle = gradientStyle
        self.strokeWidth = strokeWidth
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowRadius ?? radius
        self.shadowX = shadowX
        self.shadowY = shadowY
    }
    
    public func body(content: Content) -> some View {
        content
            .background(material.opacity(materialOpacity))
            .cornerRadius(radius)
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: gradientColors()),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: strokeWidth
                    )
            )
            .shadow(color: shadowColor.opacity(shadowOpacity), radius: shadowRadius, x: shadowX, y: shadowY)
    }
    
    private func gradientColors() -> [Color] {
        switch gradientStyle {
        case .normal:
            return [
                color.opacity(gradientOpacity),
                .clear,
                .clear,
                color.opacity(gradientOpacity)
            ]
        case .reverted:
            return [
                .clear,
                color.opacity(gradientOpacity),
                color.opacity(gradientOpacity),
                .clear
            ]
        }
    }
}

extension View {
    func liquidGlassBackground(
        radius: CGFloat = 0,
        color: Color = .clear,
        displayMode: LiquidGlassBackgroundModifier.GlassBackgroundDisplayMode = .always
    ) -> some View {
        self.modifier(
            LiquidGlassBackgroundModifier(
                displayMode: displayMode,
                radius: radius,
                color: color
            )
        )
    }
}
