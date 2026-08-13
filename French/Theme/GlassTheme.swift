import SwiftUI

// MARK: - Contemporary Glassmorphism & Gradient Theme System

struct GlassCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 20
    var isPressed: Bool = false
    @ObservedObject private var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        let isDark = themeManager.currentTheme.isDark

        let cardFill = isDark ?
            Color(red: 0.12, green: 0.14, blue: 0.19).opacity(0.85) :
            Color.white.opacity(0.92)

        let strokeGradient = LinearGradient(
            colors: isDark ?
                [Color.white.opacity(0.20), Color.white.opacity(0.04)] :
                [Color.white, Color.black.opacity(0.08)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

        let shadowColor = isDark ?
            Color.black.opacity(0.40) :
            Color(red: 0.20, green: 0.25, blue: 0.35).opacity(0.08)

        return content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(cardFill)
                    .shadow(color: shadowColor, radius: isPressed ? 3 : 10, x: 0, y: isPressed ? 2 : 5)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(strokeGradient, lineWidth: 1.2)
            )
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.26, dampingFraction: 0.66), value: isPressed)
    }
}

struct GradientHeroModifier: ViewModifier {
    let gradient: LinearGradient
    var cornerRadius: CGFloat = 22
    var isPressed: Bool = false

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(gradient)
                    .shadow(color: Color.black.opacity(0.18), radius: isPressed ? 4 : 12, x: 0, y: isPressed ? 2 : 6)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(LinearGradient(colors: [Color.white.opacity(0.35), Color.white.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.2)
            )
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.26, dampingFraction: 0.66), value: isPressed)
    }
}

// MARK: - Reusable App Gradients

enum AppGradients {
    static let indigoViolet = LinearGradient(colors: [Color(red: 0.32, green: 0.35, blue: 0.92), Color(red: 0.55, green: 0.32, blue: 0.92)], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let emeraldTeal  = LinearGradient(colors: [Color(red: 0.05, green: 0.65, blue: 0.52), Color(red: 0.10, green: 0.55, blue: 0.72)], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let sunsetRose   = LinearGradient(colors: [Color(red: 0.95, green: 0.35, blue: 0.45), Color(red: 0.90, green: 0.25, blue: 0.65)], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let oceanCyan    = LinearGradient(colors: [Color(red: 0.00, green: 0.52, blue: 0.90), Color(red: 0.00, green: 0.72, blue: 0.85)], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let amberGold    = LinearGradient(colors: [Color(red: 0.92, green: 0.55, blue: 0.10), Color(red: 0.88, green: 0.40, blue: 0.15)], startPoint: .topLeading, endPoint: .bottomTrailing)
}

extension View {
    /// Modern glassmorphic card container with spring touch physics.
    func glassCard(cornerRadius: CGFloat = 20, isPressed: Bool = false) -> some View {
        self.modifier(GlassCardModifier(cornerRadius: cornerRadius, isPressed: isPressed))
    }

    /// Vibrant gradient hero card background for banners and featured items.
    func gradientHeroCard(_ gradient: LinearGradient = AppGradients.indigoViolet, cornerRadius: CGFloat = 22, isPressed: Bool = false) -> some View {
        self.modifier(GradientHeroModifier(gradient: gradient, cornerRadius: cornerRadius, isPressed: isPressed))
    }
}
