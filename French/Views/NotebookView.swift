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

// MARK: - Category Row View (Screen 1 - Untouched)

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
                Text(section.title)
                    .font(themeManager.fontSizeScale.uiTitleFont)
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)

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

// MARK: - Dedicated Detail View (Screen 2 - Full-Width Edge-to-Edge Separator Layout)

struct NotebookSectionDetailView: View {
    let section: NotebookSection
    @ObservedObject private var themeManager = ThemeManager.shared
    @StateObject private var speech = SpeechService.shared

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                // UI Category Header Subtitle
                Text(section.description)
                    .font(themeManager.fontSizeScale.uiLabelFont)
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor.opacity(0.85))
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 12)

                ForEach(Array(section.items.enumerated()), id: \.element.id) { index, item in
                    VStack(spacing: 0) {
                        // Full-Width Separator Line (Very left to very right)
                        Rectangle()
                            .fill(themeManager.currentTheme.secondaryTextColor.opacity(0.18))
                            .frame(height: 1)

                        // Item Content Cell (Full Screen Width with 16pt Content Padding)
                        NotebookItemRow(item: item, speech: speech)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                    }
                }

                // Bottom closing separator line
                Rectangle()
                    .fill(themeManager.currentTheme.secondaryTextColor.opacity(0.18))
                    .frame(height: 1)
            }
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

// MARK: - Notebook Item Row (Screen 2: Clean, Actionable Audio Button, High-Contrast Dark Reading Text)

private struct NotebookItemRow: View {
    let item: NotebookItem
    @ObservedObject var speech: SpeechService
    @ObservedObject private var themeManager = ThemeManager.shared

    private var isSpeaking: Bool {
        speech.currentlySpeakingItemID == item.id
    }

    private var activeRange: NSRange? {
        if isSpeaking {
            return speech.currentWordRange
        }
        return nil
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header Title (Kindle Book Serif - High Contrast Primary Dark Text)
            Text(item.french)
                .font(themeManager.fontSizeScale.contentTitleFont)
                .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                .kindleTextFormatting(lineSpacing: 4)
                .fixedSize(horizontal: false, vertical: true)

            // MARK: - Actionable Audio Button Section (Tappable Content Pill)
            Button {
                HapticManager.shared.tapWord()
                speech.speak(item.spokenFrench, itemID: item.id, rate: Float(themeManager.speechRate))
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: isSpeaking ? "speaker.wave.3.fill" : "speaker.wave.2.fill")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(themeManager.currentTheme.accentColor)

                    HighlightedTextView(
                        fullText: item.spokenFrench,
                        activeRange: activeRange,
                        font: themeManager.fontSizeScale.contentBodyFont.bold()
                    )
                    .kindleTextFormatting(lineSpacing: 4)
                    .fixedSize(horizontal: false, vertical: true)

                    Spacer(minLength: 0)

                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(themeManager.currentTheme.accentColor.opacity(0.85))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .appNeumorphicCard(cornerRadius: 12, isPressed: isSpeaking)
            }
            .buttonStyle(.plain)

            // English Meaning (Kindle Book Serif - High Contrast Dark Text for Zero Eye Strain!)
            Text(item.english)
                .font(themeManager.fontSizeScale.contentBodyFont)
                .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                .kindleTextFormatting(lineSpacing: 5)
                .fixedSize(horizontal: false, vertical: true)

            // Phonetic Guide (Kindle Book Serif - Sharp Readable Text)
            HStack(alignment: .top, spacing: 4) {
                Image(systemName: "text.phonetic")
                    .font(.caption2)
                    .padding(.top, 3)
                Text(item.phonetic)
                    .font(themeManager.fontSizeScale.contentPhoneticFont)
                    .kindleTextFormatting(lineSpacing: 3)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .foregroundStyle(themeManager.currentTheme.primaryTextColor.opacity(0.88))

            // Optional Grammar Note (High Contrast Readable Text)
            if let note = item.grammarNote {
                Text(note)
                    .font(themeManager.fontSizeScale.uiLabelFont)
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor.opacity(0.80))
                    .kindleTextFormatting(lineSpacing: 3)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NotebookView()
}
