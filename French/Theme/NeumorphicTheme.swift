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

// MARK: - Carved Shelf Depth Box Modifier (Crisp Unblended Boundaries)

struct CarvedShelfBoxModifier: ViewModifier {
    var cornerRadius: CGFloat = 18
    var isPressed: Bool = false
    @ObservedObject private var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        let theme = themeManager.currentTheme
        let isDark = theme.isDark

        // 1. Deep Inset Wall Shadows
        let innerShadowDark  = isDark ? Color.black.opacity(0.88) : Color(red: 0.48, green: 0.52, blue: 0.62).opacity(0.70)
        let innerGlowLight   = isDark ? Color.white.opacity(0.20) : Color.white.opacity(0.85)

        // 2. Crisp Outer Carved Rim (Prevents right/bottom blending with outer background view)
        let outerRimColor    = isDark ? Color.black.opacity(0.85) : Color(red: 0.40, green: 0.44, blue: 0.53).opacity(0.38)
        let bottomHighlight  = isDark ? Color.white.opacity(0.12) : Color.white.opacity(0.65)

        return content
            .background(
                ZStack {
                    // Step A: Carved Shelf Base Floor Fill
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(theme.cardBackgroundColor)

                    // Step B: Top-Left Deep Carved Inner Shadow (Top & Left Walls)
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(innerShadowDark, lineWidth: isPressed ? 4.0 : 3.0)
                        .blur(radius: 2.5)
                        .offset(x: 1.5, y: 1.5)
                        .mask(
                            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [.black, .black.opacity(0.5), .clear],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )

                    // Step C: Bottom-Right Crisp Shelf Wall Highlight (Inner Floor Edge)
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(innerGlowLight, lineWidth: 1.5)
                        .blur(radius: 1.5)
                        .offset(x: -1.0, y: -1.0)
                        .mask(
                            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [.clear, .black.opacity(0.5), .black],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )

                    // Step D: Crisp Distinct Outer Carved Wall Rim (Defines exact right/bottom boundary without blending)
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .strokeBorder(
                            LinearGradient(
                                colors: [outerRimColor, outerRimColor.opacity(0.6), bottomHighlight],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.2
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

    /// Applies Carved Shelf Depth Box styling with crisp unblended outer boundaries.
    func appNeumorphicCard(cornerRadius: CGFloat = 18, isPressed: Bool = false) -> some View {
        self.modifier(CarvedShelfBoxModifier(cornerRadius: cornerRadius, isPressed: isPressed))
    }

    /// Alias for explicit Carved Shelf Depth Box naming.
    func appCarvedDepthCard(cornerRadius: CGFloat = 18, isPressed: Bool = false) -> some View {
        self.modifier(CarvedShelfBoxModifier(cornerRadius: cornerRadius, isPressed: isPressed))
    }

    /// Helper for inner sunken wells.
    func appRecessedWell(cornerRadius: CGFloat = 12) -> some View {
        self.modifier(CarvedShelfBoxModifier(cornerRadius: cornerRadius, isPressed: false))
    }
}
