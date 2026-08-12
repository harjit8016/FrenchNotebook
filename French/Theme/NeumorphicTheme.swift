import SwiftUI

// MARK: - Single Source of Truth Skeuomorphic & Theme System Modifiers

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

// MARK: - Rich Skeuomorphic Depth Card & Button Surface Modifier

struct SkeuomorphicCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 14
    var isPressed: Bool = false
    @ObservedObject private var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        let theme = themeManager.currentTheme
        let isDark = theme.isDark

        // 1. Subtle Skeuomorphic Bevel Surface Gradient
        let surfaceGradient = LinearGradient(
            colors: isPressed ? [
                theme.cardBackgroundColor.opacity(0.88),
                theme.cardBackgroundColor
            ] : [
                theme.cardBackgroundColor,
                theme.cardBackgroundColor.opacity(isDark ? 0.82 : 0.93)
            ],
            startPoint: .top,
            endPoint: .bottom
        )

        // 2. Bevel Border Stroke Colors (Top Specular Highlight Rim & Bottom Base Rim)
        let topRimColor = isDark ? Color.white.opacity(0.22) : Color.white.opacity(0.85)
        let bottomRimColor = isDark ? Color.black.opacity(0.65) : Color.black.opacity(0.18)

        // 3. Multi-layer Skeuomorphic 3D Drop Shadows
        let shadowColor = isDark ? Color.black.opacity(0.70) : Color(red: 0.18, green: 0.22, blue: 0.32).opacity(0.22)
        let ambientShadow = isDark ? Color.black.opacity(0.40) : Color.black.opacity(0.08)

        return content
            .background(
                ZStack {
                    // Tactile Surface Fill with Bevel Gradient
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(surfaceGradient)

                    // Top Specular Highlight Rim & Bottom Bevel Edge
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .strokeBorder(
                            LinearGradient(
                                colors: isPressed ? [bottomRimColor, topRimColor] : [topRimColor, bottomRimColor],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 1.2
                        )
                }
                .shadow(
                    color: shadowColor,
                    radius: isPressed ? 2 : 7,
                    x: 0,
                    y: isPressed ? 1 : 4
                )
                .shadow(
                    color: ambientShadow,
                    radius: isPressed ? 1 : 2,
                    x: 0,
                    y: isPressed ? 1 : 1
                )
            )
            .offset(y: isPressed ? 2 : 0) // Physical tactile button depression on touch!
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

    /// Applies Rich Skeuomorphic Depth Card & Button Surface styling.
    func appNeumorphicCard(cornerRadius: CGFloat = 14, isPressed: Bool = false) -> some View {
        self.modifier(SkeuomorphicCardModifier(cornerRadius: cornerRadius, isPressed: isPressed))
    }

    /// Alias for explicit Skeuomorphic card naming.
    func appSkeuomorphicCard(cornerRadius: CGFloat = 14, isPressed: Bool = false) -> some View {
        self.modifier(SkeuomorphicCardModifier(cornerRadius: cornerRadius, isPressed: isPressed))
    }
}
