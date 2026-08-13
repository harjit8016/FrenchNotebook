import SwiftUI

struct SettingsView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    @StateObject private var speech = SpeechService.shared

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {

                    // MARK: - 1. Color Themes Section (Roboto UI Font)
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Image(systemName: "paintpalette.fill")
                                .foregroundStyle(themeManager.currentTheme.accentColor)
                            Text("Reading Themes (5 Palettes)")
                                .font(themeManager.fontSizeScale.uiTitleFont)
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        }

                        Text("Choose the best visual background for comfortable reading and minimal eye strain.")
                            .font(themeManager.fontSizeScale.uiLabelFont)
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

                    // MARK: - 2. French Voice Options Section (Roboto UI Font)
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Image(systemName: "waveform.circle.fill")
                                .foregroundStyle(themeManager.currentTheme.accentColor)
                            Text("French Speaker Voice")
                                .font(themeManager.fontSizeScale.uiTitleFont)
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        }

                        Text("Select your preferred French speaker voice (Female / Male / Enhanced).")
                            .font(themeManager.fontSizeScale.uiLabelFont)
                            .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                        VStack(spacing: 10) {
                            ForEach(themeManager.availableFrenchVoices) { option in
                                Button {
                                    HapticManager.shared.tapWord()
                                    themeManager.selectedVoiceIdentifier = option.id
                                    speech.speak("Bonjour, comment allez-vous ?", rate: Float(themeManager.speechRate))
                                } label: {
                                    VoiceOptionRow(option: option, isSelected: themeManager.selectedVoiceIdentifier == option.id)
                                }
                                .buttonStyle(.plain)
                            }
                        }

                        Text("💡 Tip: Apple Personal Voice (iOS 17+) and additional high-quality voices can be enabled in iPhone Settings → Accessibility → Spoken Content → Voices.")
                            .font(themeManager.fontSizeScale.uiLabelFont)
                            .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                            .padding(.top, 4)
                    }
                    .padding(14)
                    .appNeumorphicCard(cornerRadius: 16)

                    // MARK: - 3. Font Size Section (Roboto UI Font)
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Image(systemName: "textformat.size")
                                .foregroundStyle(themeManager.currentTheme.accentColor)
                            Text("Text Font Size")
                                .font(themeManager.fontSizeScale.uiTitleFont)
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
                                .font(themeManager.fontSizeScale.uiLabelFont.bold())
                                .foregroundStyle(themeManager.currentTheme.accentColor)

                            // Reading content sample (SF Pro System Font)
                            Text("Bonjour ! Je m'appelle Harjit.")
                                .font(themeManager.fontSizeScale.contentTitleFont)
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                                .kindleTextFormatting(lineSpacing: 3)

                            Text("Hello! My name is Harjit.")
                                .font(themeManager.fontSizeScale.contentBodyFont)
                                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                                .kindleTextFormatting(lineSpacing: 3)

                            Text("Bon-zhoo-kh · ਬੋਂਜ਼ੂਖ਼")
                                .font(themeManager.fontSizeScale.contentPhoneticFont)
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

                    // MARK: - 4. Beginner Slow Audio Speed Section (Roboto UI Font)
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Image(systemName: "speaker.wave.2.fill")
                                .foregroundStyle(themeManager.currentTheme.accentColor)
                            Text("Pronunciation Speed (Beginner Friendly)")
                                .font(themeManager.fontSizeScale.uiTitleFont)
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        }

                        HStack {
                            Text("Very Slow (0.15x)")
                                .font(themeManager.fontSizeScale.uiLabelFont)
                                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                            Spacer()
                            Text("Beginner Slow (0.30x)")
                                .font(themeManager.fontSizeScale.uiLabelFont)
                                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                            Spacer()
                            Text("Normal (0.45x)")
                                .font(themeManager.fontSizeScale.uiLabelFont)
                                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                        }

                        Slider(value: $themeManager.speechRate, in: 0.15...0.45, step: 0.05)
                            .tint(themeManager.currentTheme.accentColor)

                        Button {
                            HapticManager.shared.tapWord()
                            speech.speak("Bonjour, enchanté de faire votre connaissance !", rate: Float(themeManager.speechRate))
                        } label: {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("Test Audio Speed")
                                    .font(themeManager.fontSizeScale.uiButtonFont)
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

// MARK: - Theme Swatch Row View (Roboto UI Font)

private struct ThemeSwatchRow: View {
    let theme: AppTheme
    let isSelected: Bool
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(theme.cardBackgroundColor)
                    .frame(width: 36, height: 36)

                Image(systemName: theme.iconName)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(theme.accentColor)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(theme.rawValue)
                    .font(themeManager.fontSizeScale.uiTitleFont)
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                Text(theme.isDark ? "Dark theme" : "Light theme")
                    .font(themeManager.fontSizeScale.uiLabelFont)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
            }

            Spacer()

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

// MARK: - Voice Option Row View (Roboto UI Font)

private struct VoiceOptionRow: View {
    let option: FrenchVoiceOption
    let isSelected: Bool
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(themeManager.currentTheme.cardBackgroundColor)
                    .frame(width: 36, height: 36)

                Image(systemName: option.genderName == "Female Voice" ? "person.wave.2.fill" : (option.genderName == "Male Voice" ? "person.fill" : "speaker.wave.2.fill"))
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(themeManager.currentTheme.accentColor)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(option.name)
                    .font(themeManager.fontSizeScale.uiTitleFont)
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                Text(option.genderName)
                    .font(themeManager.fontSizeScale.uiLabelFont)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
            }

            Spacer()

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
