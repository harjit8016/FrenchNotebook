import SwiftUI

struct SettingsView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    @StateObject private var speech = SpeechService.shared

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    // MARK: - 1. Color Themes Section
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Image(systemName: "paintpalette.fill")
                                .foregroundStyle(themeManager.currentTheme.accentColor)
                            Text("Reading Themes (5 Palettes)")
                                .font(themeManager.fontSizeScale.bodyFont.bold())
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        }

                        Text("Choose the best visual background for comfortable reading and minimal eye strain.")
                            .font(themeManager.fontSizeScale.captionFont)
                            .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                        VStack(spacing: 10) {
                            ForEach(AppTheme.allCases) { theme in
                                Button {
                                    HapticManager.shared.tapWord()
                                    themeManager.currentTheme = theme
                                } label: {
                                    ThemeSwatchRow(theme: theme, isSelected: themeManager.currentTheme == theme)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(14)
                    .appNeumorphicCard(cornerRadius: 16)

                    // MARK: - 2. Font Size Section
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Image(systemName: "textformat.size")
                                .foregroundStyle(themeManager.currentTheme.accentColor)
                            Text("Text Font Size")
                                .font(themeManager.fontSizeScale.bodyFont.bold())
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        }

                        Picker("Font Size", selection: $themeManager.fontSizeScale) {
                            ForEach(FontSizeScale.allCases) { scale in
                                Text(scale.rawValue).tag(scale)
                            }
                        }
                        .pickerStyle(.segmented)

                        // Live Preview Card
                        VStack(alignment: .leading, spacing: 6) {
                            Text("LIVE PREVIEW")
                                .font(.caption2.bold())
                                .foregroundStyle(themeManager.currentTheme.accentColor)

                            Text("Bonjour ! Je m'appelle Harjit.")
                                .font(themeManager.fontSizeScale.titleFont)
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                            Text("Hello! My name is Harjit.")
                                .font(themeManager.fontSizeScale.bodyFont)
                                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                            Text("Bon-zhoo-kh · ਬੋਂਜ਼ੂਖ਼")
                                .font(themeManager.fontSizeScale.captionFont)
                                .foregroundStyle(themeManager.currentTheme.accentColor)
                        }
                        .padding(14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(themeManager.currentTheme.backgroundColor)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(themeManager.currentTheme.secondaryTextColor.opacity(0.2), lineWidth: 1)
                        )
                    }
                    .padding(14)
                    .appNeumorphicCard(cornerRadius: 16)

                    // MARK: - 3. Speech Audio Speed
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Image(systemName: "speaker.wave.2.fill")
                                .foregroundStyle(themeManager.currentTheme.accentColor)
                            Text("Pronunciation Audio Speed")
                                .font(themeManager.fontSizeScale.bodyFont.bold())
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        }

                        HStack {
                            Text("Slow (0.35x)")
                                .font(themeManager.fontSizeScale.captionFont)
                                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                            Spacer()
                            Text("Normal (0.45x)")
                                .font(themeManager.fontSizeScale.captionFont)
                                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                            Spacer()
                            Text("Fast (0.55x)")
                                .font(themeManager.fontSizeScale.captionFont)
                                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                        }

                        Slider(value: $themeManager.speechRate, in: 0.35...0.55, step: 0.05)
                            .tint(themeManager.currentTheme.accentColor)

                        Button {
                            HapticManager.shared.tapWord()
                            speech.speak("Bonjour, enchanté de faire votre connaissance !", rate: Float(themeManager.speechRate))
                        } label: {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("Test Audio Speed")
                                    .font(themeManager.fontSizeScale.bodyFont.bold())
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .foregroundStyle(.white)
                            .background(themeManager.currentTheme.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(14)
                    .appNeumorphicCard(cornerRadius: 16)
                }
                .padding()
            }
            .appBackground()
            .appNavigationStyle(title: "Settings", displayMode: .inline)
        }
    }
}

// MARK: - Theme Swatch Row View

private struct ThemeSwatchRow: View {
    let theme: AppTheme
    let isSelected: Bool
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        HStack(spacing: 12) {
            // Theme Icon Badge
            ZStack {
                Circle()
                    .fill(theme.cardBackgroundColor)
                    .frame(width: 36, height: 36)

                Image(systemName: theme.iconName)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(theme.accentColor)
            }

            // Theme Name
            VStack(alignment: .leading, spacing: 2) {
                Text(theme.rawValue)
                    .font(themeManager.fontSizeScale.bodyFont.bold())
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                Text(theme.isDark ? "Dark theme" : "Light theme")
                    .font(themeManager.fontSizeScale.captionFont)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
            }

            Spacer()

            // Swatch Color Preview Pill with border outline
            HStack(spacing: 3) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(theme.backgroundColor)
                    .frame(width: 14, height: 14)
                RoundedRectangle(cornerRadius: 3)
                    .fill(theme.cardBackgroundColor)
                    .frame(width: 14, height: 14)
                RoundedRectangle(cornerRadius: 3)
                    .fill(theme.accentColor)
                    .frame(width: 14, height: 14)
            }
            .padding(4)
            .background(Color.black.opacity(0.06))
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.black.opacity(0.12), lineWidth: 1)
            )

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title3)
                    .foregroundStyle(themeManager.currentTheme.accentColor)
            }
        }
        .padding(10)
        .appNeumorphicCard(cornerRadius: 12, isPressed: isSelected)
    }
}

#Preview {
    SettingsView()
}
