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

// MARK: - Inset Depth Card Modifier (Strictly Clipped Bounds - Zero Spill)

struct InsetDepthCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 16
    var isPressed: Bool = false
    @ObservedObject private var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        let theme = themeManager.currentTheme
        let isDark = theme.isDark

        // 1. Dark Inset Shadow (Top & Left carved wall)
        let darkShadow = isDark ? Color.black.opacity(0.85) : Color(red: 0.60, green: 0.64, blue: 0.72).opacity(0.65)
        
        // 2. Light Inset Highlight (Bottom & Right carved wall)
        let lightHighlight = isDark ? Color.white.opacity(0.12) : Color.white.opacity(0.85)

        return content
            .background(
                ZStack {
                    // Base Card Surface Fill
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(theme.cardBackgroundColor)

                    // Top-Left Dark Inset Shadow
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(darkShadow, lineWidth: isPressed ? 4.0 : 3.0)
                        .blur(radius: 2.5)
                        .offset(x: 2, y: 2)

                    // Bottom-Right Light Inset Highlight
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(lightHighlight, lineWidth: isPressed ? 3.0 : 2.0)
                        .blur(radius: 2.0)
                        .offset(x: -2, y: -2)
                }
                // Strictly clip all inner shadows and glows inside the exact card shape so nothing spills out to the right side!
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

    /// Applies Inset Depth Card styling with strictly clipped boundaries (Zero spill on right side).
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
