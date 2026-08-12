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

// MARK: - Exact Carved Inset Depth Box Modifier (Matching User Screenshot)

struct CarvedDepthBoxModifier: ViewModifier {
    var cornerRadius: CGFloat = 18
    var isPressed: Bool = false
    @ObservedObject private var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        let theme = themeManager.currentTheme
        let isDark = theme.isDark

        // Exact inset shadow parameters matching the screenshot depth well
        let darkInsetShadow = isDark ? Color.black.opacity(0.80) : Color(red: 0.60, green: 0.64, blue: 0.72).opacity(0.65)
        let lightInsetGlow  = isDark ? Color.white.opacity(0.14) : Color.white.opacity(0.95)

        return content
            .background(
                ZStack {
                    // 1. Carved Depth Well Surface Fill
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(theme.cardBackgroundColor)

                    // 2. Top-Left Carved Inner Dark Shadow
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(darkInsetShadow, lineWidth: isPressed ? 4.5 : 3.5)
                        .blur(radius: isPressed ? 3.5 : 2.5)
                        .offset(x: isPressed ? 3 : 2, y: isPressed ? 3 : 2)
                        .mask(
                            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [.black, .black.opacity(0.4), .clear],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )

                    // 3. Bottom-Right Carved Inner Light Glow
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(lightInsetGlow, lineWidth: isPressed ? 3.5 : 2.5)
                        .blur(radius: isPressed ? 3.5 : 2.5)
                        .offset(x: isPressed ? -3 : -2, y: isPressed ? -3 : -2)
                        .mask(
                            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [.clear, .black.opacity(0.4), .black],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )

                    // 4. Subtle Carved Bevel Rim Border
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .strokeBorder(
                            LinearGradient(
                                colors: [darkInsetShadow.opacity(0.4), lightInsetGlow.opacity(0.6)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.0
                        )
                }
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

    /// Applies Exact Carved Inset Depth Box styling matching the user's screenshot.
    func appNeumorphicCard(cornerRadius: CGFloat = 18, isPressed: Bool = false) -> some View {
        self.modifier(CarvedDepthBoxModifier(cornerRadius: cornerRadius, isPressed: isPressed))
    }

    /// Alias for explicit Carved Depth Box naming.
    func appCarvedDepthCard(cornerRadius: CGFloat = 18, isPressed: Bool = false) -> some View {
        self.modifier(CarvedDepthBoxModifier(cornerRadius: cornerRadius, isPressed: isPressed))
    }

    /// Helper for inner sunken wells.
    func appRecessedWell(cornerRadius: CGFloat = 12) -> some View {
        self.modifier(CarvedDepthBoxModifier(cornerRadius: cornerRadius, isPressed: false))
    }
}
