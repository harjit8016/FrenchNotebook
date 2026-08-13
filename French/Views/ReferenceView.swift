import SwiftUI

struct ReferenceView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    @StateObject private var speech = SpeechService.shared
    @State private var searchText: String = ""
    @State private var selectedFilterTag: String = "All"

    private let filterTags = ["All", "Pronouns", "Liaison", "Verbs", "Modals", "Cognates"]

    private let gridColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    // Hero Header with Stats
                    HeroHeaderView(
                        title: "Grammar & Rules",
                        subtitle: "Quick rules, liaisons & verb tables"
                    )

                    // Live Search Bar
                    SearchBarView(searchText: $searchText, placeholder: "Search rules, conjugations & hacks...")

                    // Category Filter Chips
                    FilterChipsView(tags: filterTags, selectedTag: $selectedFilterTag)

                    // 2-Column Grid Cards for Reference Categories
                    LazyVGrid(columns: gridColumns, spacing: 12) {
                        if matchesFilter("Pronouns") {
                            NavigationLink(destination: ReferenceCategoryDetailView(title: "Pronouns", iconName: "person.2.fill") {
                                RuleCardView(card: ReferenceData.pronounRule, speech: speech)
                            }) {
                                RefGridCard(title: "Subject Pronouns", subtitle: "je, tu, il, elle...", iconName: "person.2.fill", countText: "1 rule", color: CategoryColors.indigo)
                            }
                            .buttonStyle(.plain)
                        }

                        if matchesFilter("Liaison") {
                            NavigationLink(destination: ReferenceCategoryDetailView(title: "Liaison Rules", iconName: "link") {
                                ForEach(ReferenceData.liaisonRules) { card in
                                    RuleCardView(card: card, speech: speech)
                                }
                            }) {
                                RefGridCard(title: "Liaison Rules", subtitle: "Linking & silent H", iconName: "link", countText: "\(ReferenceData.liaisonRules.count) rules", color: CategoryColors.emerald)
                            }
                            .buttonStyle(.plain)
                        }

                        if matchesFilter("Verbs") {
                            NavigationLink(destination: ReferenceCategoryDetailView(title: "Verb Basics", iconName: "character.book.closed.fill") {
                                VerbCardView(card: ReferenceData.etreCard, speech: speech)
                                VerbCardView(card: ReferenceData.avoirCard, speech: speech)
                                VerbCardView(card: ReferenceData.allerCard, speech: speech)
                                VerbCardView(card: ReferenceData.faireCard, speech: speech)
                                VerbCardView(card: ReferenceData.erVerbCard, speech: speech)
                            }) {
                                RefGridCard(title: "Verb Basics", subtitle: "être, avoir, aller, faire...", iconName: "character.book.closed.fill", countText: "5 verbs", color: CategoryColors.rose)
                            }
                            .buttonStyle(.plain)
                        }

                        if matchesFilter("Modals") {
                            NavigationLink(destination: ReferenceCategoryDetailView(title: "Modals", iconName: "questionmark.circle") {
                                RuleCardView(card: ReferenceData.modalNote, speech: speech)
                            }) {
                                RefGridCard(title: "Modals (can/must)", subtitle: "pouvoir, devoir...", iconName: "questionmark.circle", countText: "1 note", color: CategoryColors.cyan)
                            }
                            .buttonStyle(.plain)
                        }

                        if matchesFilter("Cognates") {
                            NavigationLink(destination: ReferenceCategoryDetailView(title: "Cognate Hacks", iconName: "equal.circle") {
                                ForEach(ReferenceData.cognateHacks) { card in
                                    RuleCardView(card: card, speech: speech)
                                }
                            }) {
                                RefGridCard(title: "Cognate Hacks", subtitle: "-tion, -eur, -té...", iconName: "equal.circle", countText: "\(ReferenceData.cognateHacks.count) hacks", color: CategoryColors.amber)
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

    private func matchesFilter(_ tag: String) -> Bool {
        if selectedFilterTag == "All" { return true }
        return selectedFilterTag.lowercased() == tag.lowercased()
    }
}

// MARK: - 2-Column Grid Reference Category Card

private struct RefGridCard: View {
    let title: String
    let subtitle: String
    let iconName: String
    let countText: String
    var color: Color = CategoryColors.indigo
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: 40, height: 40)
                        .shadow(color: Color.black.opacity(0.12), radius: 3, x: 0, y: 2)

                    Image(systemName: iconName)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.white)
                }

                Spacer()

                Text(countText)
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundStyle(color)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(color.opacity(0.12))
                    .clipShape(Capsule())
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                    .lineLimit(1)

                Text(subtitle)
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

// MARK: - Dedicated Detail View (Screen 2)

struct ReferenceCategoryDetailView<Content: View>: View {
    let title: String
    let iconName: String
    @ViewBuilder let content: () -> Content
    @ObservedObject private var themeManager = ThemeManager.shared
    @StateObject private var speech = SpeechService.shared

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 14) {
                content()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .appBackground()
        .appNavigationStyle(title: title, displayMode: .inline)
    }
}

// MARK: - Rule Card (liaison / cognates / pronouns / modals)

struct RuleCardView: View {
    let card: RuleCard
    @ObservedObject var speech: SpeechService
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(card.title, systemImage: card.iconName)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(themeManager.currentTheme.accentColor)

            Text(card.explanation)
                .font(themeManager.fontSizeScale.bodyFont)
                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                .fixedSize(horizontal: false, vertical: true)

            VStack(spacing: 8) {
                ForEach(card.examples) { example in
                    ExampleRow(example: example, speech: speech)
                }
            }
        }
        .padding(14)
        .glassCard(cornerRadius: 16)
    }
}

// MARK: - Verb Conjugation Card

struct VerbCardView: View {
    let card: VerbCard
    @ObservedObject var speech: SpeechService
    @ObservedObject private var themeManager = ThemeManager.shared

    private var isVerbSpeaking: Bool {
        speech.currentlySpeakingItemID == card.id
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(card.infinitive)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                    Text(card.englishMeaning)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                }

                Spacer()

                Button {
                    HapticManager.shared.tapWord()
                    if isVerbSpeaking {
                        speech.stop()
                    } else {
                        speech.speak(card.infinitive, itemID: card.id, rate: Float(themeManager.speechRate))
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(isVerbSpeaking ? themeManager.currentTheme.accentColor : themeManager.currentTheme.accentColor.opacity(0.12))
                            .frame(width: 36, height: 36)

                        Image(systemName: isVerbSpeaking ? "stop.fill" : "speaker.wave.2.fill")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(isVerbSpeaking ? .white : themeManager.currentTheme.accentColor)
                    }
                }
                .buttonStyle(.plain)
            }

            Text(card.group)
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(themeManager.currentTheme.accentColor)
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .background(themeManager.currentTheme.accentColor.opacity(0.12))
                .clipShape(Capsule())

            // Compact Conjugation Grid Rows
            VStack(spacing: 6) {
                ForEach(card.rows) { row in
                    let isRowSpeaking = speech.currentlySpeakingItemID == row.id
                    Button {
                        HapticManager.shared.tapWord()
                        if isRowSpeaking {
                            speech.stop()
                        } else {
                            speech.speak(row.pronoun, itemID: row.id, rate: Float(themeManager.speechRate))
                        }
                    } label: {
                        HStack {
                            HighlightedTextView(
                                fullText: row.pronoun,
                                activeRange: isRowSpeaking ? speech.currentWordRange : nil,
                                font: .system(size: 15, weight: .bold),
                                normalColor: themeManager.currentTheme.primaryTextColor,
                                highlightColor: themeManager.currentTheme.accentColor
                            )

                            Spacer()

                            Text(row.punjabiSound)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                            Image(systemName: isRowSpeaking ? "stop.circle.fill" : "speaker.wave.2")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(themeManager.currentTheme.accentColor)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(themeManager.currentTheme.cardBackgroundColor.opacity(0.70))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)
                }
            }

            Text(card.note)
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                .padding(.top, 2)
        }
        .padding(14)
        .glassCard(cornerRadius: 18)
    }
}

// MARK: - Shared Example Row

private struct ExampleRow: View {
    let example: RuleExample
    @ObservedObject var speech: SpeechService
    @ObservedObject private var themeManager = ThemeManager.shared

    var isSpeakingThis: Bool {
        speech.currentlySpeakingItemID == example.id
    }

    var body: some View {
        Button {
            HapticManager.shared.tapWord()
            if isSpeakingThis {
                speech.stop()
            } else {
                speech.speak(example.french, itemID: example.id, rate: Float(themeManager.speechRate))
            }
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HighlightedTextView(
                        fullText: example.french,
                        activeRange: isSpeakingThis ? speech.currentWordRange : nil,
                        font: .system(size: 15, weight: .bold),
                        normalColor: themeManager.currentTheme.primaryTextColor,
                        highlightColor: themeManager.currentTheme.accentColor
                    )

                    Text(example.english)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                }

                Spacer()

                Text(example.punjabiSound)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(themeManager.currentTheme.accentColor)

                Image(systemName: isSpeakingThis ? "stop.circle.fill" : "speaker.wave.2")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(themeManager.currentTheme.accentColor)
            }
            .padding(10)
            .background(themeManager.currentTheme.cardBackgroundColor.opacity(0.70))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ReferenceView()
}
