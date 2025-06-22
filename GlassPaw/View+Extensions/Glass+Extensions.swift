//
//  Glass+Extensions.swift
//  GlassPaw
//
//  Created by Kevin Montemayor on 6/20/25.
//

import SwiftUI

public extension View {
    /// Applies a customizable glass/frosted effect to the view
    /// - Parameters:
    ///   - displayMode: Controls when the effect is displayed (.always or .automatic)
    ///   - radius: Corner radius of the glass effect
    ///   - color: Base color for the effect's gradient and highlights
    ///   - material: The material style to use for the glass effect
    ///   - materialOpacity: Opacity level for the material overlay
    ///   - gradientOpacity: Opacity level for the gradient overlay
    ///   - gradientStyle: Direction style of the gradient (.normal or .reverted)
    ///   - strokeWidth: Width of the border stroke
    ///   - shadowColor: Color of the drop shadow
    ///   - shadowOpacity: Opacity level for the shadow
    ///   - shadowRadius: Blur radius for the shadow (defaults to corner radius if nil)
    ///   - shadowX: Horizontal offset of the shadow
    ///   - shadowY: Vertical offset of the shadow
    /// - Returns: A view with the glass effect applied
    func glass(
        displayMode: LiquidGlassBackgroundModifier.GlassBackgroundDisplayMode = .always,
        radius: CGFloat = 32,
        color: Color = .white,
        material: Material = .ultraThinMaterial,
        materialOpacity: Double = 0.5,
        gradientOpacity: Double = 0.5,
        gradientStyle: LiquidGlassBackgroundModifier.GradientStyle = .normal,
        strokeWidth: CGFloat = 1.5,
        shadowColor: Color = .white,
        shadowOpacity: Double = 0.5,
        shadowRadius: CGFloat? = nil,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 5
    ) -> some View {
#if os(visionOS)
        return self.glassBackgroundEffect()
#else
        return modifier(LiquidGlassBackgroundModifier(
            displayMode: displayMode,
            radius: radius,
            color: color,
            material: material,
            materialOpacity: materialOpacity, gradientOpacity: gradientOpacity,
            gradientStyle: gradientStyle,
            strokeWidth: strokeWidth,
            shadowColor: shadowColor,
            shadowOpacity: shadowOpacity,
            shadowRadius: shadowRadius,
            shadowX: shadowX,
            shadowY: shadowY
        ))
#endif
    }
}
