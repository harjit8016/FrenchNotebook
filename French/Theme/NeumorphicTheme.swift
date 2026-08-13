import SwiftUI

// MARK: - Single Source of Truth Theme System Modifiers

struct AppBackgroundModifier: ViewModifier {
    @ObservedObject private var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        ZStack {
            themeManager.currentTheme.backgroundColor
                .ignoresSafeArea()
            content
        }
    }
}

struct AppNavigationModifier: ViewModifier {
    let title: String
    let displayMode: NavigationBarItem.TitleDisplayMode
    @ObservedObject private var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(displayMode)
            .toolbarBackground(themeManager.currentTheme.backgroundColor, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(themeManager.currentTheme.isDark ? .dark : .light, for: .navigationBar)
    }
}

// MARK: - Contemporary Neumorphic & Soft Depth Modifiers

struct ModernNeumorphicCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 16
    var isPressed: Bool = false
    @ObservedObject private var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        let theme = themeManager.currentTheme
        let isDark = theme.isDark

        let lightHighlight = isDark ? Color.white.opacity(0.12) : Color.white.opacity(0.85)
        let darkShadow     = isDark ? Color.black.opacity(0.50) : Color(red: 0.35, green: 0.40, blue: 0.50).opacity(0.16)
        let subtleBorder   = isDark ? Color.white.opacity(0.10) : Color.black.opacity(0.06)

        return content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(theme.cardBackgroundColor)
                    .shadow(color: lightHighlight, radius: isPressed ? 2 : 6, x: isPressed ? -1.5 : -4, y: isPressed ? -1.5 : -4)
                    .shadow(color: darkShadow, radius: isPressed ? 2 : 7, x: isPressed ? 1.5 : 4, y: isPressed ? 1.5 : 5)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(subtleBorder, lineWidth: 1.0)
            )
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.28, dampingFraction: 0.68), value: isPressed)
    }
}

struct FloatingCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 20
    @ObservedObject private var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        let theme = themeManager.currentTheme
        let isDark = theme.isDark

        return content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(theme.cardBackgroundColor.opacity(0.94))
                    .shadow(color: Color.black.opacity(isDark ? 0.45 : 0.12), radius: 12, x: 0, y: 6)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(isDark ? Color.white.opacity(0.14) : Color.black.opacity(0.08), lineWidth: 1.0)
            )
    }
}

struct KindleReaderTextModifier: ViewModifier {
    var lineSpacing: CGFloat = 7.5
    var tracking: CGFloat = 0.2

    func body(content: Content) -> some View {
        content
            .lineSpacing(lineSpacing)
            .tracking(tracking)
    }
}

// MARK: - Reusable View Extensions (DRY & Clean Architecture)

extension View {
    /// Applies the SSOT app background color to safe area boundaries.
    func appBackground() -> some View {
        self.modifier(AppBackgroundModifier())
    }

    /// Sets up navigation bar title, background, and color scheme in one DRY call.
    func appNavigationStyle(title: String, displayMode: NavigationBarItem.TitleDisplayMode = .inline) -> some View {
        self.modifier(AppNavigationModifier(title: title, displayMode: displayMode))
    }

    /// Applies Modern Soft-Elevation Neumorphic Card styling with spring touch physics.
    func appNeumorphicCard(cornerRadius: CGFloat = 16, isPressed: Bool = false) -> some View {
        self.modifier(ModernNeumorphicCardModifier(cornerRadius: cornerRadius, isPressed: isPressed))
    }

    /// Floating glassmorphic card container for floating bars & sticky controllers.
    func appFloatingCard(cornerRadius: CGFloat = 20) -> some View {
        self.modifier(FloatingCardModifier(cornerRadius: cornerRadius))
    }

    /// Applies Kindle E-Reader line height (7.5pt spacing) and relaxed character tracking (+0.2pt).
    func kindleTextFormatting(lineSpacing: CGFloat = 7.5, tracking: CGFloat = 0.2) -> some View {
        self.modifier(KindleReaderTextModifier(lineSpacing: lineSpacing, tracking: tracking))
    }
}
