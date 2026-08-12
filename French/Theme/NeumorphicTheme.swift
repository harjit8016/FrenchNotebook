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

// MARK: - Soft Depth Box Modifier (Inspired by HTML Soft Depth Box Design)

struct SoftDepthBoxModifier: ViewModifier {
    var cornerRadius: CGFloat = 18
    var isPressed: Bool = false
    var isRecessed: Bool = false
    @ObservedObject private var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        let theme = themeManager.currentTheme
        let isDark = theme.isDark

        let highlightColor = isDark ? Color.white.opacity(0.09) : Color.white.opacity(0.95)
        let shadowColor    = isDark ? Color.black.opacity(0.65) : Color(red: 0.65, green: 0.69, blue: 0.77).opacity(0.55)

        return content
            .background(
                ZStack {
                    if isRecessed || isPressed {
                        // Recessed/Sunken Depth Well (like .code-panel inset box)
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(theme.cardBackgroundColor)
                            .overlay(
                                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                    .stroke(shadowColor, lineWidth: 1.5)
                                    .blur(radius: 2)
                                    .offset(x: 2, y: 2)
                                    .mask(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                    .stroke(highlightColor, lineWidth: 1.5)
                                    .blur(radius: 2)
                                    .offset(x: -2, y: -2)
                                    .mask(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                            )
                    } else {
                        // Soft Extruded Elevated Depth Box (like .row-card outer box)
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(theme.cardBackgroundColor)
                            .shadow(
                                color: highlightColor,
                                radius: 7,
                                x: -6,
                                y: -6
                            )
                            .shadow(
                                color: shadowColor,
                                radius: 7,
                                x: 6,
                                y: 6
                            )
                    }
                }
            )
            .animation(.easeInOut(duration: 0.15), value: isPressed)
    }
}

// MARK: - Reusable View Extensions (DRY Principle)

extension View {
    /// Applies the SSOT app background color to safe area boundaries.
    func appBackground() -> some View {
        self.modifier(AppBackgroundModifier())
    }

    /// Sets up navigation bar title, background, and color scheme in one DRY call.
    func appNavigationStyle(title: String, displayMode: NavigationBarItem.TitleDisplayMode = .inline) -> some View {
        self.modifier(AppNavigationModifier(title: title, displayMode: displayMode))
    }

    /// Applies Soft Extruded / Recessed Depth Box styling matching swift-vs-kotlin-neumorphic depth box design.
    func appNeumorphicCard(cornerRadius: CGFloat = 18, isPressed: Bool = false) -> some View {
        self.modifier(SoftDepthBoxModifier(cornerRadius: cornerRadius, isPressed: isPressed, isRecessed: false))
    }

    /// Explicit helper for sunken/recessed depth wells (like code/audio panels).
    func appRecessedWell(cornerRadius: CGFloat = 12) -> some View {
        self.modifier(SoftDepthBoxModifier(cornerRadius: cornerRadius, isPressed: false, isRecessed: true))
    }
}
