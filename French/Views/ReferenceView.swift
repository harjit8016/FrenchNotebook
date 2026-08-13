import SwiftUI

struct ReferenceView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    @StateObject private var speech = SpeechService.shared

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    NavigationLink(destination: ReferenceCategoryDetailView(title: "Pronouns", iconName: "person.2.fill") {
                        RuleCardView(card: ReferenceData.pronounRule, speech: speech)
                    }) {
                        ReferenceCategoryRow(title: "Subject Pronouns", subtitle: "je, tu, il, elle, nous, vous, ils, elles", iconName: "person.2.fill", countText: "1 rule")
                    }
                    .buttonStyle(.plain)

                    NavigationLink(destination: ReferenceCategoryDetailView(title: "Liaison Rules", iconName: "link") {
                        ForEach(ReferenceData.liaisonRules) { card in
                            RuleCardView(card: card, speech: speech)
                        }
                    }) {
                        ReferenceCategoryRow(title: "Liaison Rules", subtitle: "Word linking & silent H rules", iconName: "link", countText: "\(ReferenceData.liaisonRules.count) rules")
                    }
                    .buttonStyle(.plain)

                    NavigationLink(destination: ReferenceCategoryDetailView(title: "Verb Basics", iconName: "character.book.closed.fill") {
                        VerbCardView(card: ReferenceData.etreCard, speech: speech)
                        VerbCardView(card: ReferenceData.avoirCard, speech: speech)
                        VerbCardView(card: ReferenceData.allerCard, speech: speech)
                        VerbCardView(card: ReferenceData.faireCard, speech: speech)
                        VerbCardView(card: ReferenceData.erVerbCard, speech: speech)
                    }) {
                        ReferenceCategoryRow(title: "Verb Basics & Conjugations", subtitle: "être, avoir, aller, faire, parler (-ER pattern)", iconName: "character.book.closed.fill", countText: "5 verbs")
                    }
                    .buttonStyle(.plain)

                    NavigationLink(destination: ReferenceCategoryDetailView(title: "Modals (can/must/will)", iconName: "questionmark.circle") {
                        RuleCardView(card: ReferenceData.modalNote, speech: speech)
                    }) {
                        ReferenceCategoryRow(title: "Modals (can / must / will)", subtitle: "pouvoir, devoir, near future", iconName: "questionmark.circle", countText: "1 note")
                    }
                    .buttonStyle(.plain)

                    NavigationLink(destination: ReferenceCategoryDetailView(title: "Cognate Hacks", iconName: "equal.circle") {
                        ForEach(ReferenceData.cognateHacks) { card in
                            RuleCardView(card: card, speech: speech)
                        }
                    }) {
                        ReferenceCategoryRow(title: "Word Ending Hacks (Cognates)", subtitle: "-tion, -eur, -té, -ique, -eux, -able", iconName: "equal.circle", countText: "\(ReferenceData.cognateHacks.count) hacks")
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
            .appBackground()
            .appNavigationStyle(title: "Grammar Reference", displayMode: .inline)
        }
    }
}

// MARK: - Reference Category Row (Screen 1)

private struct ReferenceCategoryRow: View {
    let title: String
    let subtitle: String
    let iconName: String
    let countText: String
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(themeManager.currentTheme.cardBackgroundColor)
                    .frame(width: 44, height: 44)
                    .appNeumorphicCard(cornerRadius: 22)

                Image(systemName: iconName)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(themeManager.currentTheme.accentColor)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(themeManager.fontSizeScale.bodyFont.bold())
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                Text(subtitle)
                    .font(themeManager.fontSizeScale.captionFont)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(countText)
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

// MARK: - Reference Category Detail View (Screen 2)

struct ReferenceCategoryDetailView<Content: View>: View {
    let title: String
    let iconName: String
    @ViewBuilder let content: () -> Content
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 14) {
                content()
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .appBackground()
        .appNavigationStyle(title: title, displayMode: .inline)
    }
}

// MARK: - Rule Card (liaison / cognates / pronouns / modals)

private struct RuleCardView: View {
    let card: RuleCard
    @ObservedObject var speech: SpeechService
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(card.title, systemImage: card.iconName)
                .font(themeManager.fontSizeScale.bodyFont.bold())
                .foregroundStyle(themeManager.currentTheme.accentColor)

            Text(card.explanation)
                .font(themeManager.fontSizeScale.bodyFont)
                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                .fixedSize(horizontal: false, vertical: true)

            VStack(spacing: 8) {
                ForEach(card.examples) { example in
                    ExampleRow(
                        example: example,
                        speech: speech
                    )
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .appNeumorphicCard(cornerRadius: 14)
    }
}

// MARK: - Verb Conjugation Card

private struct VerbCardView: View {
    let card: VerbCard
    @ObservedObject var speech: SpeechService
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(card.infinitive)
                        .font(themeManager.fontSizeScale.titleFont)
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                    Button {
                        HapticManager.shared.tapWord()
                        speech.speak(card.infinitive, rate: Float(themeManager.speechRate))
                    } label: {
                        Image(systemName: "speaker.wave.2.fill")
                            .foregroundStyle(themeManager.currentTheme.accentColor)
                    }
                }
                Text(card.englishMeaning)
                    .font(themeManager.fontSizeScale.bodyFont)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                Text(card.group)
                    .font(.caption.bold())
                    .foregroundStyle(themeManager.currentTheme.accentColor)
            }

            VStack(spacing: 6) {
                ForEach(card.rows) { row in
                    Button {
                        HapticManager.shared.tapWord()
                        speech.speak(row.pronoun, itemID: row.id, rate: Float(themeManager.speechRate))
                    } label: {
                        HStack {
                            Text(row.pronoun)
                                .font(themeManager.fontSizeScale.bodyFont.bold())
                                .foregroundStyle(speech.currentlySpeakingItemID == row.id ? themeManager.currentTheme.accentColor : themeManager.currentTheme.primaryTextColor)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            Text(row.punjabiSound)
                                .font(themeManager.fontSizeScale.captionFont)
                                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                                .fixedSize(horizontal: false, vertical: true)
                            Image(systemName: speech.currentlySpeakingItemID == row.id ? "speaker.wave.3.fill" : "speaker.wave.2")
                                .font(.caption)
                                .foregroundStyle(themeManager.currentTheme.accentColor)
                        }
                        .padding(.vertical, 7)
                        .padding(.horizontal, 10)
                        .appNeumorphicCard(cornerRadius: 10, isPressed: speech.currentlySpeakingItemID == row.id)
                    }
                    .buttonStyle(.plain)
                }
            }

            Text(card.note)
                .font(themeManager.fontSizeScale.captionFont)
                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 2)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .appNeumorphicCard(cornerRadius: 14)
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
            speech.speak(example.french, itemID: example.id, rate: Float(themeManager.speechRate))
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(example.french)
                        .font(themeManager.fontSizeScale.bodyFont.bold())
                        .foregroundStyle(isSpeakingThis ? themeManager.currentTheme.accentColor : themeManager.currentTheme.primaryTextColor)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(example.english)
                        .font(themeManager.fontSizeScale.captionFont)
                        .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
                Text(example.punjabiSound)
                    .font(themeManager.fontSizeScale.captionFont)
                    .foregroundStyle(themeManager.currentTheme.accentColor)
                    .fixedSize(horizontal: false, vertical: true)
                Image(systemName: isSpeakingThis ? "speaker.wave.3.fill" : "speaker.wave.2")
                    .font(.caption)
                    .foregroundStyle(themeManager.currentTheme.accentColor)
            }
            .padding(10)
            .appNeumorphicCard(cornerRadius: 10, isPressed: isSpeakingThis)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ReferenceView()
}
