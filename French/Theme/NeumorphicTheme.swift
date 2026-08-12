import SwiftUI

// MARK: - Single Source of Truth Design System Modifiers

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

struct NeumorphicCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 14
    var isPressed: Bool = false
    @ObservedObject private var themeManager = ThemeManager.shared

    func body(content: Content) -> some View {
        let theme = themeManager.currentTheme
        let isDark = theme.isDark

        let highlightColor = isDark ? Color.white.opacity(0.08) : Color.white.opacity(0.85)
        let shadowColor    = isDark ? Color.black.opacity(0.55) : Color(red: 0.68, green: 0.72, blue: 0.80).opacity(0.45)

        return content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(theme.cardBackgroundColor)
                    .shadow(
                        color: highlightColor,
                        radius: isPressed ? 2 : 5,
                        x: isPressed ? -2 : -4,
                        y: isPressed ? -2 : -4
                    )
                    .shadow(
                        color: shadowColor,
                        radius: isPressed ? 2 : 5,
                        x: isPressed ? 2 : 4,
                        y: isPressed ? 2 : 4
                    )
            )
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

    /// Applies Neumorphic Soft UI surface elevation.
    func appNeumorphicCard(cornerRadius: CGFloat = 14, isPressed: Bool = false) -> some View {
        self.modifier(NeumorphicCardModifier(cornerRadius: cornerRadius, isPressed: isPressed))
    }
}

// MARK: - Reusable Search Bar Component (DRY)

struct AppSearchBarView: View {
    @Binding var searchText: String
    let placeholder: String
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
            
            TextField(placeholder, text: $searchText)
                .font(themeManager.fontSizeScale.bodyFont)
                .foregroundStyle(themeManager.currentTheme.primaryTextColor)
            
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .appNeumorphicCard(cornerRadius: 14)
        .padding(.horizontal)
        .padding(.top, 8)
        .padding(.bottom, 10)
    }
}
