import SwiftUI

struct BasicsView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    @StateObject private var speech = SpeechService.shared

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    // Hero Header
                    HeroHeaderView(
                        title: "French Kaida (Basics)",
                        subtitle: "Alphabet, greetings, numbers, time & daily words"
                    )

                    // Alphabet Featured Card (L'Alphabet A-Z)
                    NavigationLink(destination: AlphabetDetailView(speech: speech)) {
                        AlphabetHeroBannerCard()
                    }
                    .buttonStyle(.plain)

                    // 5 Section Groups with 22 Categories
                    LazyVStack(spacing: 16) {
                        ForEach(Array(BasicsData.sections.enumerated()), id: \.element.id) { groupIndex, group in
                            VStack(alignment: .leading, spacing: 10) {
                                // Section Group Header Label
                                Label(group.title, systemImage: group.iconName)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundStyle(themeManager.currentTheme.accentColor)
                                    .padding(.horizontal, 4)

                                LazyVStack(spacing: 10) {
                                    ForEach(Array(group.categories.enumerated()), id: \.element.id) { categoryIndex, category in
                                        NavigationLink(destination: BasicsCategoryDetailView(category: category, speech: speech)) {
                                            BasicsCategoryListRow(category: category, colorIndex: groupIndex * 4 + categoryIndex)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            }
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

// MARK: - Featured Alphabet Banner Card

private struct AlphabetHeroBannerCard: View {
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(CategoryColors.indigo)
                    .frame(width: 48, height: 48)
                    .shadow(color: Color.black.opacity(0.12), radius: 3, x: 0, y: 2)

                Text("A B C")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text("L'Alphabet (A to Z Grid)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                Text("Interactive 26-letter grid with picture symbols & sound")
                    .font(.system(size: 12.5, weight: .regular))
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
            }

            Spacer(minLength: 4)

            VStack(alignment: .trailing, spacing: 6) {
                Text("26 letters")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(CategoryColors.indigo)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(CategoryColors.indigo.opacity(0.12))
                    .clipShape(Capsule())

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
            }
        }
        .padding(14)
        .glassCard(cornerRadius: 16)
    }
}

// MARK: - Category Row Item Card

private struct BasicsCategoryListRow: View {
    let category: BasicsCategory
    let colorIndex: Int
    @ObservedObject private var themeManager = ThemeManager.shared

    private var categoryColor: Color {
        CategoryColors.color(for: colorIndex)
    }

    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            ZStack {
                Circle()
                    .fill(categoryColor)
                    .frame(width: 44, height: 44)
                    .shadow(color: Color.black.opacity(0.10), radius: 3, x: 0, y: 2)

                Image(systemName: category.iconName)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(category.title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                    .fixedSize(horizontal: false, vertical: true)

                Text(category.description)
                    .font(.system(size: 12.5, weight: .regular))
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: 4)

            VStack(alignment: .trailing, spacing: 6) {
                Text("\(category.items.count) items")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(categoryColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(categoryColor.opacity(0.12))
                    .clipShape(Capsule())

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
            }
        }
        .padding(14)
        .glassCard(cornerRadius: 16)
    }
}

// MARK: - Alphabet Grid Detail View (26 Letters with Pictures & Sound)

struct AlphabetDetailView: View {
    @ObservedObject var speech: SpeechService
    @ObservedObject private var themeManager = ThemeManager.shared

    private let gridColumns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 14) {
                Text("Tap any letter to hear its French pronunciation and example word!")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                LazyVGrid(columns: gridColumns, spacing: 10) {
                    ForEach(BasicsData.alphabet) { item in
                        AlphabetCardItem(item: item, speech: speech)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .appBackground()
        .appNavigationStyle(title: "L'Alphabet (A to Z)", displayMode: .inline)
    }
}

private struct AlphabetCardItem: View {
    let item: AlphabetItem
    @ObservedObject var speech: SpeechService
    @ObservedObject private var themeManager = ThemeManager.shared

    private var isSpeaking: Bool {
        speech.currentlySpeakingItemID == item.id
    }

    var body: some View {
        Button {
            HapticManager.shared.tapWord()
            if isSpeaking {
                speech.stop()
            } else {
                speech.speak(item.frenchWord, itemID: item.id, rate: Float(themeManager.speechRate))
            }
        } label: {
            VStack(spacing: 8) {
                HStack {
                    Text(item.letter)
                        .font(.system(size: 26, weight: .heavy, design: .rounded))
                        .foregroundStyle(themeManager.currentTheme.accentColor)

                    Spacer()

                    Image(systemName: item.iconName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(themeManager.currentTheme.accentColor)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(item.frenchWord)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        .lineLimit(1)

                    Text(item.englishMeaning)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                        .lineLimit(1)

                    Text(item.punjabiSound)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(themeManager.currentTheme.accentColor)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(12)
            .glassCard(cornerRadius: 14, isPressed: isSpeaking)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Category Detail View for Basics Items

struct BasicsCategoryDetailView: View {
    let category: BasicsCategory
    @ObservedObject var speech: SpeechService
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 14) {
                Text(category.description)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                LazyVStack(spacing: 12) {
                    ForEach(category.items) { item in
                        BasicsItemCard(item: item, speech: speech)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .appBackground()
        .appNavigationStyle(title: category.title, displayMode: .inline)
    }
}

private struct BasicsItemCard: View {
    let item: BasicsItem
    @ObservedObject var speech: SpeechService
    @ObservedObject private var themeManager = ThemeManager.shared

    private var isSpeaking: Bool {
        speech.currentlySpeakingItemID == item.id
    }

    var body: some View {
        Button {
            HapticManager.shared.tapWord()
            if isSpeaking {
                speech.stop()
            } else {
                speech.speak(item.spokenText ?? item.french, itemID: item.id, rate: Float(themeManager.speechRate))
            }
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                // Header with Icon & French Word
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 8) {
                            Image(systemName: item.iconName)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(themeManager.currentTheme.accentColor)

                            Text(item.french)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        }

                        // Phonetic & Punjabi Sound Pill
                        HStack(spacing: 6) {
                            Text(item.phonetic)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(themeManager.currentTheme.accentColor)

                            Text("•")
                                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                            Text(item.punjabiSound)
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(themeManager.currentTheme.accentColor)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(themeManager.currentTheme.accentColor.opacity(0.12))
                        .clipShape(Capsule())
                    }

                    Spacer()

                    // Audio Play/Stop Indicator Circle
                    ZStack {
                        Circle()
                            .fill(isSpeaking ? themeManager.currentTheme.accentColor : themeManager.currentTheme.accentColor.opacity(0.12))
                            .frame(width: 36, height: 36)

                        Image(systemName: isSpeaking ? "stop.fill" : "speaker.wave.2.fill")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(isSpeaking ? .white : themeManager.currentTheme.accentColor)
                    }
                }

                // English Meaning
                Text(item.english)
                    .font(themeManager.fontSizeScale.contentBodyFont)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                // Grammar Note if present
                if let note = item.grammarNote {
                    HStack(alignment: .top, spacing: 6) {
                        Text("RULE")
                            .font(.system(size: 9, weight: .bold))
                            .foregroundStyle(themeManager.currentTheme.accentColor)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(themeManager.currentTheme.accentColor.opacity(0.14))
                            .clipShape(RoundedRectangle(cornerRadius: 4))

                        Text(note)
                            .font(.system(size: 12.5, weight: .regular))
                            .foregroundStyle(themeManager.currentTheme.primaryTextColor.opacity(0.82))
                    }
                    .padding(.top, 2)
                }
            }
            .padding(14)
            .glassCard(cornerRadius: 16, isPressed: isSpeaking)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    BasicsView()
}
