import SwiftUI

struct NotebookView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    @StateObject private var speech = SpeechService.shared

    private let sections = NotebookData.allSections

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 14) {
                    ForEach(sections) { section in
                        NavigationLink(destination: NotebookSectionDetailView(section: section)) {
                            CategoryRowView(section: section)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .appBackground()
            .appNavigationStyle(title: "French Notebook", displayMode: .inline)
        }
    }
}

// MARK: - Category Row View (UI Navigation - Roboto / Sans-Serif)

private struct CategoryRowView: View {
    let section: NotebookSection
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(themeManager.currentTheme.cardBackgroundColor)
                    .frame(width: 44, height: 44)
                    .appNeumorphicCard(cornerRadius: 22)

                Image(systemName: section.iconName)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(themeManager.currentTheme.accentColor)
            }

            VStack(alignment: .leading, spacing: 3) {
                // UI Header Title (Roboto / Sans-Serif)
                Text(section.title)
                    .font(themeManager.fontSizeScale.uiTitleFont)
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                // UI Description Subtitle (Roboto / Sans-Serif)
                Text(section.description)
                    .font(themeManager.fontSizeScale.uiLabelFont)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("\(section.items.count) cards")
                    .font(themeManager.fontSizeScale.uiLabelFont.bold())
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                Image(systemName: "chevron.right")
                    .font(.caption.bold())
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .appNeumorphicCard(cornerRadius: 18)
    }
}

// MARK: - Dedicated Detail View (Screen 2)

struct NotebookSectionDetailView: View {
    let section: NotebookSection
    @ObservedObject private var themeManager = ThemeManager.shared
    @StateObject private var speech = SpeechService.shared

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 14) {
                // UI Category Header Subtitle (Roboto / Sans-Serif)
                Text(section.description)
                    .font(themeManager.fontSizeScale.uiLabelFont)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                    .padding(.horizontal, 16)
                    .padding(.top, 4)

                ForEach(section.items) { item in
                    NotebookItemCard(item: item, speech: speech)
                }
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 12)
        }
        .appBackground()
        .appNavigationStyle(title: section.title, displayMode: .inline)
    }
}

// MARK: - Real-time Word Highlighting Text View

private struct HighlightedTextView: View {
    let fullText: String
    let activeRange: NSRange?
    let font: Font
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        if let activeRange = activeRange,
           let swiftRange = Range(activeRange, in: fullText) {
            let prefix = String(fullText[..<swiftRange.lowerBound])
            let highlighted = String(fullText[swiftRange])
            let suffix = String(fullText[swiftRange.upperBound...])

            (
                Text(prefix)
                    .font(font) +
                Text(highlighted)
                    .font(font.bold())
                    .foregroundColor(themeManager.currentTheme.accentColor) +
                Text(suffix)
                    .font(font)
            )
        } else {
            Text(fullText)
                .font(font)
        }
    }
}

// MARK: - Notebook Item Card (Learning Reading Content - Kindle Book Serif)

private struct NotebookItemCard: View {
    let item: NotebookItem
    @ObservedObject var speech: SpeechService
    @ObservedObject private var themeManager = ThemeManager.shared

    private var activeRange: NSRange? {
        if speech.currentlySpeakingItemID == item.id {
            return speech.currentWordRange
        }
        return nil
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    // Header Title (Kindle Book Serif)
                    Text(item.french)
                        .font(themeManager.fontSizeScale.contentTitleFont)
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        .kindleTextFormatting(lineSpacing: 4)
                        .fixedSize(horizontal: false, vertical: true)

                    // Target Spoken Word Panel (Kindle Book Serif Content)
                    if item.audioText != nil {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Audio:")
                                .font(themeManager.fontSizeScale.uiLabelFont.bold())
                                .foregroundStyle(themeManager.currentTheme.accentColor)

                            HighlightedTextView(
                                fullText: item.spokenFrench,
                                activeRange: activeRange,
                                font: themeManager.fontSizeScale.contentBodyFont.bold()
                            )
                            .kindleTextFormatting(lineSpacing: 4)
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .appRecessedWell(cornerRadius: 10)
                    }

                    // English Meaning (Kindle Book Serif)
                    Text(item.english)
                        .font(themeManager.fontSizeScale.contentBodyFont)
                        .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                        .kindleTextFormatting(lineSpacing: 5)
                        .fixedSize(horizontal: false, vertical: true)

                    // Phonetic Guide (Kindle Book Serif)
                    HStack(alignment: .top, spacing: 4) {
                        Image(systemName: "text.phonetic")
                            .font(.caption2)
                            .padding(.top, 3)
                        Text(item.phonetic)
                            .font(themeManager.fontSizeScale.contentPhoneticFont)
                            .kindleTextFormatting(lineSpacing: 3)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .foregroundStyle(themeManager.currentTheme.accentColor)

                    // Optional Grammar Note (Kindle Book Serif)
                    if let note = item.grammarNote {
                        Text(note)
                            .font(themeManager.fontSizeScale.uiLabelFont)
                            .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                            .kindleTextFormatting(lineSpacing: 3)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 1)
                    }
                }

                Spacer()

                // Prominent Speaker Button (Roboto UI Button)
                Button {
                    speech.speak(item.spokenFrench, itemID: item.id, rate: Float(themeManager.speechRate))
                } label: {
                    ZStack {
                        Circle()
                            .fill(themeManager.currentTheme.cardBackgroundColor)
                            .frame(width: 44, height: 44)
                            .appNeumorphicCard(cornerRadius: 22, isPressed: speech.currentlySpeakingItemID == item.id)

                        Image(systemName: speech.currentlySpeakingItemID == item.id ? "speaker.wave.3.fill" : "speaker.wave.2.fill")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(speech.currentlySpeakingItemID == item.id ? themeManager.currentTheme.accentColor : themeManager.currentTheme.primaryTextColor)
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .appNeumorphicCard(cornerRadius: 18, isPressed: speech.currentlySpeakingItemID == item.id)
    }
}

#Preview {
    NotebookView()
}
