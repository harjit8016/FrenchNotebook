import SwiftUI

struct NotebookView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    @StateObject private var speech = SpeechService.shared
    @State private var searchText: String = ""
    @State private var selectedFilterTag: String = "All"

    private let sections = NotebookData.allSections
    private let filterTags = ["All", "Accents", "Gender", "Cognates", "Verbs", "Conversation", "Bistro", "Directions", "Emergency"]

    private var filteredSections: [NotebookSection] {
        var result = sections

        // 1. Tag Filtering
        if selectedFilterTag != "All" {
            result = result.filter { sec in
                sec.title.localizedCaseInsensitiveContains(selectedFilterTag) ||
                sec.description.localizedCaseInsensitiveContains(selectedFilterTag)
            }
        }

        // 2. Search Text Filtering
        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let query = searchText.lowercased()
            result = result.compactMap { sec in
                let matchingItems = sec.items.filter { item in
                    item.french.lowercased().contains(query) ||
                    item.english.lowercased().contains(query) ||
                    item.phonetic.lowercased().contains(query) ||
                    (item.grammarNote?.lowercased().contains(query) ?? false)
                }
                if !matchingItems.isEmpty || sec.title.lowercased().contains(query) || sec.description.lowercased().contains(query) {
                    return NotebookSection(
                        id: sec.id,
                        title: sec.title,
                        iconName: sec.iconName,
                        description: sec.description,
                        items: matchingItems.isEmpty ? sec.items : matchingItems
                    )
                }
                return nil
            }
        }
        return result
    }

    private let gridColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    // Hero Header with Streak & XP Stats
                    HeroHeaderView(
                        title: "French Notebook",
                        subtitle: "Master grammar, sounds & hacks"
                    )

                    // Live Search & Filter Bar
                    SearchBarView(searchText: $searchText, placeholder: "Search French, English, Punjabi...")

                    // Category Filter Chips
                    FilterChipsView(tags: filterTags, selectedTag: $selectedFilterTag)

                    // 2-Column Compact Category Grid
                    LazyVGrid(columns: gridColumns, spacing: 12) {
                        ForEach(Array(filteredSections.enumerated()), id: \.element.id) { index, section in
                            NavigationLink(destination: NotebookSectionDetailView(section: section)) {
                                GridCategoryCard(section: section, gradientIndex: index)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.top, 4)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .appBackground()
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

// MARK: - 2-Column Modern Grid Category Card

private struct GridCategoryCard: View {
    let section: NotebookSection
    let gradientIndex: Int
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                ZStack {
                    Circle()
                        .fill(themeManager.currentTheme.accentColor.opacity(0.12))
                        .frame(width: 40, height: 40)

                    Image(systemName: section.iconName)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(themeManager.currentTheme.accentColor)
                }

                Spacer()

                Text("\(section.items.count)")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(themeManager.currentTheme.accentColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(themeManager.currentTheme.accentColor.opacity(0.12))
                    .clipShape(Capsule())
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(section.title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                    .lineLimit(1)

                Text(section.description)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(14)
        .glassCard(cornerRadius: 16)
    }
}

// MARK: - Dedicated Detail View (Screen 2: Modern Compact Card List)

struct NotebookSectionDetailView: View {
    let section: NotebookSection
    @ObservedObject private var themeManager = ThemeManager.shared
    @StateObject private var speech = SpeechService.shared
    @State private var searchText: String = ""

    private var filteredItems: [NotebookItem] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return section.items
        }
        let query = searchText.lowercased()
        return section.items.filter { item in
            item.french.lowercased().contains(query) ||
            item.english.lowercased().contains(query) ||
            item.phonetic.lowercased().contains(query) ||
            (item.grammarNote?.lowercased().contains(query) ?? false)
        }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 14) {
                SearchBarView(searchText: $searchText, placeholder: "Search inside \(section.title)...")
                    .padding(.top, 6)

                Text(section.description)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                    .padding(.horizontal, 4)

                LazyVStack(spacing: 12) {
                    ForEach(filteredItems) { item in
                        ModernNotebookItemCard(item: item, speech: speech)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .appBackground()
        .appNavigationStyle(title: section.title, displayMode: .inline)
    }
}

// MARK: - Modern Notebook Item Card

private struct ModernNotebookItemCard: View {
    let item: NotebookItem
    @ObservedObject var speech: SpeechService
    @ObservedObject private var themeManager = ThemeManager.shared

    private var isSpeaking: Bool {
        speech.currentlySpeakingItemID == item.id
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header Title
            HStack(alignment: .top, spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.french)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        .kindleTextFormatting(lineSpacing: 3)

                    // Phonetic Chip Pill
                    HStack(spacing: 4) {
                        Image(systemName: "waveform")
                            .font(.system(size: 10, weight: .bold))
                        Text(item.phonetic)
                            .font(.system(size: 12, weight: .medium))
                    }
                    .foregroundStyle(themeManager.currentTheme.accentColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(themeManager.currentTheme.accentColor.opacity(0.12))
                    .clipShape(Capsule())
                }

                Spacer()
            }

            // MARK: - Actionable Spoken Audio Pill Card with Real-Time Word Highlighting & Inline Stop Toggle
            Button {
                HapticManager.shared.tapWord()
                if isSpeaking {
                    speech.stop()
                } else {
                    speech.speak(item.spokenFrench, itemID: item.id, rate: Float(themeManager.speechRate))
                }
            } label: {
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(isSpeaking ? themeManager.currentTheme.accentColor : themeManager.currentTheme.accentColor.opacity(0.12))
                            .frame(width: 34, height: 34)

                        Image(systemName: isSpeaking ? "stop.fill" : "speaker.wave.2.fill")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(isSpeaking ? .white : themeManager.currentTheme.accentColor)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        if item.audioText != nil {
                            Text("SPOKEN FRENCH")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundStyle(themeManager.currentTheme.accentColor)
                        }

                        HighlightedTextView(
                            fullText: item.spokenFrench,
                            activeRange: isSpeaking ? speech.currentWordRange : nil,
                            font: themeManager.fontSizeScale.contentBodyFont.bold(),
                            normalColor: themeManager.currentTheme.primaryTextColor,
                            highlightColor: themeManager.currentTheme.accentColor
                        )
                        .kindleTextFormatting(lineSpacing: 3)
                    }

                    Spacer(minLength: 0)

                    Image(systemName: isSpeaking ? "stop.circle.fill" : "play.circle.fill")
                        .font(.system(size: 19, weight: .semibold))
                        .foregroundStyle(themeManager.currentTheme.accentColor)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(themeManager.currentTheme.cardBackgroundColor.opacity(0.85))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(isSpeaking ? themeManager.currentTheme.accentColor : themeManager.currentTheme.secondaryTextColor.opacity(0.12), lineWidth: 1)
                )
            }
            .buttonStyle(.plain)

            // English Meaning
            Text(item.english)
                .font(themeManager.fontSizeScale.contentBodyFont)
                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                .kindleTextFormatting(lineSpacing: 3)

            if let note = item.grammarNote {
                HStack(alignment: .top, spacing: 6) {
                    Text("HACK")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(themeManager.currentTheme.accentColor)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(themeManager.currentTheme.accentColor.opacity(0.14))
                        .clipShape(RoundedRectangle(cornerRadius: 4))

                    Text(note)
                        .font(.system(size: 12.5, weight: .regular))
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor.opacity(0.82))
                        .kindleTextFormatting(lineSpacing: 2)
                }
                .padding(.top, 2)
            }
        }
        .padding(14)
        .glassCard(cornerRadius: 16, isPressed: isSpeaking)
    }
}

#Preview {
    NotebookView()
}
