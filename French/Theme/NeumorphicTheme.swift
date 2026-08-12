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

// MARK: - Sharp Razor-Clean Inset Depth Box Modifier

struct InsetDepthCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 16
    var isPressed: Bool = false
    @ObservedObject private var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        let theme = themeManager.currentTheme
        let isDark = theme.isDark

        // 1. Sharp Inset Shadow Colors
        let darkShadow     = isDark ? Color.black.opacity(0.90) : Color(red: 0.45, green: 0.49, blue: 0.58).opacity(0.75)
        let lightHighlight = isDark ? Color.white.opacity(0.22) : Color.white.opacity(0.95)
        
        // 2. Razor-Sharp Boundary Edge Line
        let sharpEdgeColor = isDark ? Color.white.opacity(0.14) : Color.black.opacity(0.14)

        return content
            .background(
                ZStack {
                    // Base Card Surface Fill
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(theme.cardBackgroundColor)

                    // Sharp Top-Left Dark Inset Shadow (Low 0.8pt blur for crisp precision)
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(darkShadow, lineWidth: isPressed ? 2.5 : 2.0)
                        .blur(radius: 0.8)
                        .offset(x: 1.5, y: 1.5)

                    // Sharp Bottom-Right Light Inset Highlight
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(lightHighlight, lineWidth: isPressed ? 2.0 : 1.5)
                        .blur(radius: 0.8)
                        .offset(x: -1.5, y: -1.5)

                    // Razor-Sharp Edge Boundary (Unblurred 1.0pt stroke border)
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .strokeBorder(sharpEdgeColor, lineWidth: 1.0)
                }
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            )
            .scaleEffect(isPressed ? 0.985 : 1.0)
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

    /// Applies Sharp Razor-Clean Inset Depth Card styling.
    func appNeumorphicCard(cornerRadius: CGFloat = 16, isPressed: Bool = false) -> some View {
        self.modifier(InsetDepthCardModifier(cornerRadius: cornerRadius, isPressed: isPressed))
    }

    /// Alias for explicit Inset Depth Card naming.
    func appCarvedDepthCard(cornerRadius: CGFloat = 16, isPressed: Bool = false) -> some View {
        self.modifier(InsetDepthCardModifier(cornerRadius: cornerRadius, isPressed: isPressed))
    }

    /// Helper for inner sunken wells.
    func appRecessedWell(cornerRadius: CGFloat = 12) -> some View {
        self.modifier(InsetDepthCardModifier(cornerRadius: cornerRadius, isPressed: false))
    }
}
