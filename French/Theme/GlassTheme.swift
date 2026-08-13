import SwiftUI

// MARK: - Refined Apple HIG Clean & Modern Card System

struct ModernCleanCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 16
    var isPressed: Bool = false
    @ObservedObject private var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        let theme = themeManager.currentTheme
        let isDark = theme.isDark

        let cardBg = theme.cardBackgroundColor
        let borderStroke = isDark ?
            Color.white.opacity(0.12) :
            Color.black.opacity(0.08)

        let shadow = isDark ?
            Color.black.opacity(0.35) :
            Color.black.opacity(0.05)

        return content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(cardBg)
                    .shadow(color: shadow, radius: isPressed ? 2 : 6, x: 0, y: isPressed ? 1 : 3)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(borderStroke, lineWidth: 1.0)
            )
            .scaleEffect(isPressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.70), value: isPressed)
    }
}

extension View {
    /// Refined, distraction-free Apple HIG card styling with tactile touch physics.
    func glassCard(cornerRadius: CGFloat = 16, isPressed: Bool = false) -> some View {
        self.modifier(ModernCleanCardModifier(cornerRadius: cornerRadius, isPressed: isPressed))
    }
}
