import SwiftUI

struct SettingsView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    @StateObject private var speech = SpeechService.shared

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        // Hero Header
                        HeroHeaderView(
                            title: "App Settings",
                            subtitle: "Themes, voice options & pronunciation"
                        )

                        // 1. Color Themes Section
                        VStack(alignment: .leading, spacing: 12) {
                            Label("Reading Themes (5 Palettes)", systemImage: "paintpalette.fill")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                            Text("Choose your preferred background color scheme for zero eye strain.")
                                .font(.system(size: 12.5, weight: .regular))
                                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                            VStack(spacing: 8) {
                                ForEach(AppTheme.allCases) { theme in
                                    Button {
                                        HapticManager.shared.tapWord()
                                        themeManager.currentTheme = theme
                                    } label: {
                                        ModernThemeSwatchRow(theme: theme, isSelected: themeManager.currentTheme == theme)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding(14)
                        .glassCard(cornerRadius: 18)

                        // 2. French Speaker Voice Section
                        VStack(alignment: .leading, spacing: 12) {
                            Label("French Speaker Voice", systemImage: "waveform.circle.fill")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                            Text("Select your preferred voice for authentic native French speech.")
                                .font(.system(size: 12.5, weight: .regular))
                                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                            VStack(spacing: 8) {
                                ForEach(themeManager.availableFrenchVoices) { option in
                                    Button {
                                        HapticManager.shared.tapWord()
                                        themeManager.selectedVoiceIdentifier = option.id
                                        speech.speak("Bonjour, comment allez-vous ?", rate: Float(themeManager.speechRate))
                                    } label: {
                                        ModernVoiceOptionRow(option: option, isSelected: themeManager.selectedVoiceIdentifier == option.id)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding(14)
                        .glassCard(cornerRadius: 18)

                        // 3. Typography & Font Size Section
                        VStack(alignment: .leading, spacing: 12) {
                            Label("Typography & Font Size", systemImage: "textformat.size")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                            Picker("Font Size", selection: $themeManager.fontSizeScale) {
                                ForEach(FontSizeScale.allCases) { scale in
                                    Text(scale.rawValue).tag(scale)
                                }
                            }
                            .pickerStyle(.segmented)

                            // Live Preview Box
                            VStack(alignment: .leading, spacing: 6) {
                                Text("LIVE PREVIEW")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundStyle(themeManager.currentTheme.accentColor)

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
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(themeManager.currentTheme.backgroundColor.opacity(0.85))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(14)
                        .glassCard(cornerRadius: 18)

                        // 4. Pronunciation Speed Section
                        VStack(alignment: .leading, spacing: 12) {
                            Label("Pronunciation Speed", systemImage: "speaker.wave.2.fill")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                            HStack {
                                Text("Very Slow (0.15x)")
                                    .font(.system(size: 11, weight: .regular))
                                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                                Spacer()
                                Text("Beginner Slow (0.30x)")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundStyle(themeManager.currentTheme.accentColor)
                                Spacer()
                                Text("Normal (0.45x)")
                                    .font(.system(size: 11, weight: .regular))
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
                                    Text("Test Speech Pace")
                                        .font(.system(size: 14, weight: .bold))
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 9)
                                .foregroundStyle(.white)
                                .background(AppGradients.indigoViolet)
                                .clipShape(Capsule())
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(14)
                        .glassCard(cornerRadius: 18)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .padding(.bottom, speech.isSpeaking ? 75 : 12)
                }

                FloatingAudioBar(speech: speech)
            }
            .appBackground()
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

// MARK: - Modern Theme Swatch Row

private struct ModernThemeSwatchRow: View {
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
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(theme.accentColor)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(theme.rawValue)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                Text(theme.isDark ? "Dark Mode" : "Light Mode")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
            }

            Spacer()

            HStack(spacing: 4) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(theme.backgroundColor)
                    .frame(width: 14, height: 14)
                RoundedRectangle(cornerRadius: 4)
                    .fill(theme.cardBackgroundColor)
                    .frame(width: 14, height: 14)
                RoundedRectangle(cornerRadius: 4)
                    .fill(theme.accentColor)
                    .frame(width: 14, height: 14)
            }

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(themeManager.currentTheme.accentColor)
            }
        }
        .padding(10)
        .background(themeManager.currentTheme.cardBackgroundColor.opacity(isSelected ? 0.90 : 0.40))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? themeManager.currentTheme.accentColor : Color.clear, lineWidth: 1.2)
        )
    }
}

// MARK: - Modern Voice Option Row

private struct ModernVoiceOptionRow: View {
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
                    .font(.system(size: 14.5, weight: .bold))
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                Text(option.genderName)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
            }

            Spacer()

            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(themeManager.currentTheme.accentColor)
            }
        }
        .padding(10)
        .background(themeManager.currentTheme.cardBackgroundColor.opacity(isSelected ? 0.90 : 0.40))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? themeManager.currentTheme.accentColor : Color.clear, lineWidth: 1.2)
        )
    }
}

#Preview {
    SettingsView()
}
