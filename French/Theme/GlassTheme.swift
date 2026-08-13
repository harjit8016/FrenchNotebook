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

// MARK: - Solid Distinct Category Colors for Easy Visual Memory & Mapping

enum CategoryColors {
    static let indigo  = Color(red: 0.38, green: 0.40, blue: 0.95)
    static let emerald = Color(red: 0.05, green: 0.68, blue: 0.52)
    static let rose    = Color(red: 0.92, green: 0.30, blue: 0.45)
    static let cyan    = Color(red: 0.00, green: 0.62, blue: 0.88)
    static let amber   = Color(red: 0.95, green: 0.55, blue: 0.10)
    static let purple  = Color(red: 0.62, green: 0.35, blue: 0.95)
    static let teal    = Color(red: 0.10, green: 0.65, blue: 0.65)
    static let orange  = Color(red: 0.95, green: 0.42, blue: 0.12)

    static func color(for index: Int) -> Color {
        let palette = [indigo, emerald, rose, cyan, amber, purple, teal, orange]
        return palette[index % palette.count]
    }
}

extension View {
    /// Refined, distraction-free Apple HIG card styling with tactile touch physics.
    func glassCard(cornerRadius: CGFloat = 16, isPressed: Bool = false) -> some View {
        self.modifier(ModernCleanCardModifier(cornerRadius: cornerRadius, isPressed: isPressed))
    }
}
