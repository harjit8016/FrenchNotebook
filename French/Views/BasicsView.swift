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
                                HStack(spacing: 6) {
                                    Text(group.emojiIcon)
                                        .font(.system(size: 16))
                                    Text(group.title)
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundStyle(themeManager.currentTheme.accentColor)
                                }
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

                Text(category.emojiIcon)
                    .font(.system(size: 20))
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
        ScrollView(.vertical, showsIndicators: false) {
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

                    Text(item.emojiIcon)
                        .font(.system(size: 22))
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
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 14) {
                Text(category.description)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                LazyVStack(spacing: 12) {
                    ForEach(category.items) { item in
                        BasicsItemCard(item: item, speech: speech)
                    }
                }

                if category.title.localizedCaseInsensitiveContains("Numbers") {
                    FullNumberGrid100View(speech: speech)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .appBackground()
        .appNavigationStyle(title: category.title, displayMode: .inline)
    }
}

// MARK: - 1 to 100 Mini Button Grid View

private struct FullNumberGrid100View: View {
    @ObservedObject var speech: SpeechService
    @ObservedObject private var themeManager = ThemeManager.shared

    @State private var selectedNumber: Int? = nil

    private let rows: [[Int]] = stride(from: 1, through: 100, by: 5).map { start in
        Array(start..<min(start + 5, 101))
    }

    private var activeRowIndex: Int? {
        guard let num = selectedNumber else { return nil }
        return (num - 1) / 5
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header Title
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("1 to 100 Full Counting Grid")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                    Spacer()

                    Text("100 Numbers")
                        .font(.system(size: 11, weight: .bold, design: .rounded))
                        .foregroundStyle(themeManager.currentTheme.accentColor)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(themeManager.currentTheme.accentColor.opacity(0.12))
                        .clipShape(Capsule())
                }

                Text("Tap any number button to hear its exact French pronunciation!")
                    .font(.system(size: 12.5, weight: .regular))
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
            }

            // 20 Rows of 5 Mini Buttons with Dynamic Inline Row Banner
            VStack(spacing: 8) {
                ForEach(Array(rows.enumerated()), id: \.offset) { rowIndex, rowNumbers in
                    VStack(spacing: 8) {
                        // Dynamic Inline Active Banner directly above this row!
                        if activeRowIndex == rowIndex, let num = selectedNumber {
                            HStack(spacing: 10) {
                                Text("\(num)")
                                    .font(.system(size: 22, weight: .heavy, design: .rounded))
                                    .foregroundStyle(themeManager.currentTheme.accentColor)

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(frenchSpokenNumber(num).capitalized)
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                                    Text("Spoken French Pronunciation")
                                        .font(.system(size: 11, weight: .medium))
                                        .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                                }

                                Spacer()

                                Button {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                        speech.stop()
                                        selectedNumber = nil
                                    }
                                } label: {
                                    Image(systemName: "stop.circle.fill")
                                        .font(.system(size: 24))
                                        .foregroundStyle(themeManager.currentTheme.accentColor)
                                }
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(themeManager.currentTheme.accentColor.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(themeManager.currentTheme.accentColor.opacity(0.30), lineWidth: 1)
                            )
                            .transition(.scale.combined(with: .opacity))
                        }

                        // 5 Mini Buttons for this row
                        HStack(spacing: 8) {
                            ForEach(rowNumbers, id: \.self) { num in
                                let isSelected = selectedNumber == num

                                Button {
                                    HapticManager.shared.tapWord()
                                    let frenchText = frenchSpokenNumber(num)
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                        selectedNumber = num
                                    }
                                    let speakID = UUID()
                                    speech.speak(frenchText, itemID: speakID, rate: Float(themeManager.speechRate))
                                } label: {
                                    VStack(spacing: 2) {
                                        Text("\(num)")
                                            .font(.system(size: 15, weight: .bold, design: .rounded))
                                            .foregroundStyle(isSelected ? .white : themeManager.currentTheme.primaryTextColor)

                                        Text(frenchSpokenNumber(num))
                                            .font(.system(size: 9.5, weight: .semibold))
                                            .foregroundStyle(isSelected ? .white.opacity(0.95) : themeManager.currentTheme.secondaryTextColor)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)
                                            .minimumScaleFactor(0.70)
                                            .padding(.horizontal, 4)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 58)
                                    .background(isSelected ? themeManager.currentTheme.accentColor : themeManager.currentTheme.cardBackgroundColor.opacity(0.80))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(isSelected ? themeManager.currentTheme.accentColor : themeManager.currentTheme.secondaryTextColor.opacity(0.15), lineWidth: 1)
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
            }
        }
        .padding(14)
        .glassCard(cornerRadius: 18)
        .padding(.top, 8)
    }
}

// MARK: - French Number Pronunciation Helper (1 to 100)

private func frenchSpokenNumber(_ n: Int) -> String {
    let units = ["", "un", "deux", "trois", "quatre", "cinq", "six", "sept", "huit", "neuf", "dix", "onze", "douze", "treize", "quatorze", "quinze", "seize", "dix-sept", "dix-huit", "dix-neuf"]
    if n <= 19 {
        return units[n]
    }
    if n == 100 {
        return "cent"
    }

    let tens = n / 10
    let remainder = n % 10

    switch tens {
    case 2: // 20-29
        if remainder == 0 { return "vingt" }
        if remainder == 1 { return "vingt et un" }
        return "vingt-" + units[remainder]
    case 3: // 30-39
        if remainder == 0 { return "trente" }
        if remainder == 1 { return "trente et un" }
        return "trente-" + units[remainder]
    case 4: // 40-49
        if remainder == 0 { return "quarante" }
        if remainder == 1 { return "quarante et un" }
        return "quarante-" + units[remainder]
    case 5: // 50-59
        if remainder == 0 { return "cinquante" }
        if remainder == 1 { return "cinquante et un" }
        return "cinquante-" + units[remainder]
    case 6: // 60-69
        if remainder == 0 { return "soixante" }
        if remainder == 1 { return "soixante et un" }
        return "soixante-" + units[remainder]
    case 7: // 70-79
        if remainder == 0 { return "soixante-dix" }
        if remainder == 1 { return "soixante et onze" }
        return "soixante-" + units[10 + remainder]
    case 8: // 80-89
        if remainder == 0 { return "quatre-vingts" }
        return "quatre-vingt-" + units[remainder]
    case 9: // 90-99
        if remainder == 0 { return "quatre-vingt-dix" }
        return "quatre-vingt-" + units[10 + remainder]
    default:
        return "\(n)"
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
                            if let hex = item.colorHex {
                                Circle()
                                    .fill(Color(hex: hex))
                                    .frame(width: 18, height: 18)
                                    .overlay(
                                        Circle()
                                            .strokeBorder(Color.primary.opacity(0.20), lineWidth: 1)
                                    )
                                    .shadow(color: Color.black.opacity(0.10), radius: 2, x: 0, y: 1)
                            } else {
                                Text(item.emojiIcon)
                                    .font(.system(size: 18))
                            }

                            Text(item.french)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                            if let gender = item.genderTag {
                                GenderTagBadge(gender: gender)
                            }
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

// MARK: - Gender Tag Badge Helper

private struct GenderTagBadge: View {
    let gender: String

    private var badgeColor: Color {
        switch gender.uppercased() {
        case "MASC":
            return .blue
        case "FEM":
            return .pink
        default:
            return .purple
        }
    }

    var body: some View {
        Text(gender)
            .font(.system(size: 9, weight: .bold, design: .rounded))
            .foregroundStyle(badgeColor)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(badgeColor.opacity(0.14))
            .clipShape(Capsule())
    }
}

// MARK: - Color Hex Extension Helper

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: // RGB
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    BasicsView()
}
