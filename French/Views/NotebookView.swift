import SwiftUI

struct NotebookView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    @StateObject private var speech = SpeechService.shared

    private let sections = NotebookData.allSections

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 12) {
                    ForEach(sections) { section in
                        NavigationLink(destination: NotebookSectionDetailView(section: section)) {
                            CategoryRowView(section: section)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
            .appBackground()
            .appNavigationStyle(title: "French Notebook", displayMode: .inline)
        }
    }
}

// MARK: - Category Row View (Screen 1)

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
                    .font(themeManager.fontSizeScale.bodyFont.bold())
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                Text(section.description)
                    .font(themeManager.fontSizeScale.captionFont)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("\(section.items.count) cards")
                    .font(.caption2.bold())
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                Image(systemName: "chevron.right")
                    .font(.caption.bold())
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .appNeumorphicCard(cornerRadius: 14)
    }
}

// MARK: - Dedicated Detail View (Screen 2)

struct NotebookSectionDetailView: View {
    let section: NotebookSection
    @ObservedObject private var themeManager = ThemeManager.shared
    @StateObject private var speech = SpeechService.shared

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 12) {
                Text(section.description)
                    .font(themeManager.fontSizeScale.captionFont)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                    .padding(.horizontal)
                    .padding(.top, 4)

                ForEach(section.items) { item in
                    NotebookItemCard(item: item, speech: speech)
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 10)
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

// MARK: - Notebook Item Card (Clean & Focused)

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
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .center, spacing: 12) {
                VStack(alignment: .leading, spacing: 5) {
                    // Header Title
                    Text(item.french)
                        .font(themeManager.fontSizeScale.titleFont)
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        .fixedSize(horizontal: false, vertical: true)

                    // Target Spoken Word Pill
                    if item.audioText != nil {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Audio:")
                                .font(.caption.bold())
                                .foregroundStyle(themeManager.currentTheme.accentColor)

                            HighlightedTextView(
                                fullText: item.spokenFrench,
                                activeRange: activeRange,
                                font: themeManager.fontSizeScale.bodyFont.bold()
                            )
                            .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(themeManager.currentTheme.accentColor.opacity(speech.currentlySpeakingItemID == item.id ? 0.18 : 0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }

                    // English Meaning
                    Text(item.english)
                        .font(themeManager.fontSizeScale.bodyFont)
                        .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                        .fixedSize(horizontal: false, vertical: true)

                    // Phonetic Guide
                    HStack(alignment: .top, spacing: 4) {
                        Image(systemName: "text.phonetic")
                            .font(.caption2)
                            .padding(.top, 2)
                        Text(item.phonetic)
                            .font(themeManager.fontSizeScale.captionFont)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .foregroundStyle(themeManager.currentTheme.accentColor)

                    // Optional Grammar Note
                    if let note = item.grammarNote {
                        Text(note)
                            .font(themeManager.fontSizeScale.captionFont)
                            .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 1)
                    }
                }

                Spacer()

                // Prominent Speaker Button
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
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .appNeumorphicCard(cornerRadius: 14, isPressed: speech.currentlySpeakingItemID == item.id)
        .animation(.easeInOut(duration: 0.2), value: speech.currentlySpeakingItemID)
    }
}

#Preview {
    NotebookView()
}
