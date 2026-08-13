import Foundation

// MARK: - Alphabet Item Model

struct AlphabetItem: Identifiable {
    let id = UUID()
    let letter: String
    let frenchWord: String
    let englishMeaning: String
    let phonetic: String
    let punjabiSound: String
    let emojiIcon: String
}

// MARK: - Basics Item Model

struct BasicsItem: Identifiable {
    let id = UUID()
    let french: String
    let english: String
    let phonetic: String
    let punjabiSound: String
    let emojiIcon: String
    var grammarNote: String? = nil
    var spokenText: String? = nil
    var colorHex: String? = nil
    var genderTag: String? = nil // "MASC", "FEM", "MASC & FEM"
}

// MARK: - Basics Category Model

struct BasicsCategory: Identifiable {
    let id = UUID()
    let title: String
    let emojiIcon: String
    let description: String
    let items: [BasicsItem]
}

// MARK: - Basics Section Group Model

struct BasicsSectionGroup: Identifiable {
    let id = UUID()
    let title: String
    let emojiIcon: String
    let categories: [BasicsCategory]
}

// MARK: - Basics Dataset (French Kaida)

enum BasicsData {

    // MARK: - 1. Alphabet (A to Z) - 100% Accurate Emojis for Kids
    static let alphabet: [AlphabetItem] = [
        AlphabetItem(letter: "A", frenchWord: "Arbre", englishMeaning: "Tree", phonetic: "ah · ahr-brə", punjabiSound: "ਆ · ਆਰਬ੍ਰ", emojiIcon: "🌳"),
        AlphabetItem(letter: "B", frenchWord: "Bateau", englishMeaning: "Boat", phonetic: "beh · bah-toh", punjabiSound: "ਬੇ · ਬਾਤੋ", emojiIcon: "⛵"),
        AlphabetItem(letter: "C", frenchWord: "Chat", englishMeaning: "Cat", phonetic: "seh · shah", punjabiSound: "ਸੇ · ਸ਼ਾ", emojiIcon: "🐱"),
        AlphabetItem(letter: "D", frenchWord: "Dauphin", englishMeaning: "Dolphin", phonetic: "deh · doh-fahn", punjabiSound: "ਦੇ · ਦੋਫਾਂ", emojiIcon: "🐬"),
        AlphabetItem(letter: "E", frenchWord: "Éléphant", englishMeaning: "Elephant", phonetic: "uh · eh-lay-fahn", punjabiSound: "ਉ · ਏਲੇਫਾਂ", emojiIcon: "🐘"),
        AlphabetItem(letter: "F", frenchWord: "Fleur", englishMeaning: "Flower", phonetic: "eff · fluhr", punjabiSound: "ਐਫ · ਫਲੂਖ਼", emojiIcon: "🌸"),
        AlphabetItem(letter: "G", frenchWord: "Gâteau", englishMeaning: "Cake", phonetic: "zheh · gah-toh", punjabiSound: "ਜ਼ੇ · ਗਾਤੋ", emojiIcon: "🎂"),
        AlphabetItem(letter: "H", frenchWord: "Horloge", englishMeaning: "Clock", phonetic: "ash · or-lozh", punjabiSound: "ਆਸ਼ · ਓਰਲੋਜ਼", emojiIcon: "⏰"),
        AlphabetItem(letter: "I", frenchWord: "Île", englishMeaning: "Island", phonetic: "ee · eel", punjabiSound: "ਈ · ਈਲ", emojiIcon: "🏝️"),
        AlphabetItem(letter: "J", frenchWord: "Jardin", englishMeaning: "Garden", phonetic: "zhee · zhar-dahn", punjabiSound: "ਜ਼ੀ · ਜ਼ਾਰਦਾਂ", emojiIcon: "🏡"),
        AlphabetItem(letter: "K", frenchWord: "Kangourou", englishMeaning: "Kangaroo", phonetic: "kah · kahn-goo-roo", punjabiSound: "ਕਾ · ਕਾਂਗੂਰੂ", emojiIcon: "🦘"),
        AlphabetItem(letter: "L", frenchWord: "Lune", englishMeaning: "Moon", phonetic: "ell · loon", punjabiSound: "ਐਲ · ਲੂਨ", emojiIcon: "🌙"),
        AlphabetItem(letter: "M", frenchWord: "Maison", englishMeaning: "House", phonetic: "emm · meh-zohn", punjabiSound: "ਐਮ · ਮੇਜ਼ੋਂ", emojiIcon: "🏠"),
        AlphabetItem(letter: "N", frenchWord: "Nuage", englishMeaning: "Cloud", phonetic: "enn · noo-azh", punjabiSound: "ਐਨ · ਨੂਆਜ਼", emojiIcon: "☁️"),
        AlphabetItem(letter: "O", frenchWord: "Oiseau", englishMeaning: "Bird", phonetic: "oh · wah-zoh", punjabiSound: "ਓ · ਵਾਜ਼ੋ", emojiIcon: "🐦"),
        AlphabetItem(letter: "P", frenchWord: "Pomme", englishMeaning: "Apple", phonetic: "peh · puhm", punjabiSound: "ਪੇ · ਪੋਮ", emojiIcon: "🍎"),
        AlphabetItem(letter: "Q", frenchWord: "Quatre", englishMeaning: "Four", phonetic: "koo · kah-trə", punjabiSound: "ਕੂ · ਕਾਤ੍ਰ", emojiIcon: "4️⃣"),
        AlphabetItem(letter: "R", frenchWord: "Règle", englishMeaning: "Ruler / Rule", phonetic: "ehr · reh-glə", punjabiSound: "ਐਖ਼ · ਰੈਗਲ", emojiIcon: "📏"),
        AlphabetItem(letter: "S", frenchWord: "Soleil", englishMeaning: "Sun", phonetic: "ess · soh-lay", punjabiSound: "ਐਸ · ਸੋਲੇ", emojiIcon: "☀️"),
        AlphabetItem(letter: "T", frenchWord: "Train", englishMeaning: "Train", phonetic: "teh · trahn", punjabiSound: "ਤੇ · ਤ੍ਰਾਂ", emojiIcon: "🚆"),
        AlphabetItem(letter: "U", frenchWord: "Usine", englishMeaning: "Factory", phonetic: "oo · oo-zeen", punjabiSound: "ਊ · ਊਜ਼ੀਨ", emojiIcon: "🏭"),
        AlphabetItem(letter: "V", frenchWord: "Voiture", englishMeaning: "Car", phonetic: "veh · vwah-toor", punjabiSound: "ਵੇ · ਵਵਾਤੂਖ਼", emojiIcon: "🚗"),
        AlphabetItem(letter: "W", frenchWord: "Wagon", englishMeaning: "Wagon / Carriage", phonetic: "doo-bluh-veh · vah-gohn", punjabiSound: "ਦੂਬਲ-ਵੇ · ਵਾਗੋਂ", emojiIcon: "🚃"),
        AlphabetItem(letter: "X", frenchWord: "Xylophone", englishMeaning: "Xylophone", phonetic: "eeks · ksee-loh-fuhn", punjabiSound: "ਈਕਸ · ਕਸੀਲੋਫੋਨ", emojiIcon: "🎼"),
        AlphabetItem(letter: "Y", frenchWord: "Yaourt", englishMeaning: "Yogurt", phonetic: "ee-grehk · yah-oort", punjabiSound: "ਈ-ਗ੍ਰੇਕ · ਯਾਊਰਤ", emojiIcon: "🥛"),
        AlphabetItem(letter: "Z", frenchWord: "Zèbre", englishMeaning: "Zebra", phonetic: "zehd · zeh-brə", punjabiSound: "ਜ਼ੈਡ · ਜ਼ੇਬ੍ਰ", emojiIcon: "🦓")
    ]

    // MARK: - All 5 Section Groups with 23 Categories

    static let sections: [BasicsSectionGroup] = [
        // SECTION 1: Absolute Basics
        BasicsSectionGroup(
            title: "Section 1: The Absolute Basics",
            emojiIcon: "⭐",
            categories: [
                BasicsCategory(
                    title: "Greetings & Magic Words",
                    emojiIcon: "👋",
                    description: "Essential polite phrases for daily conversation and exam speaking tasks.",
                    items: [
                        BasicsItem(french: "Bonjour", english: "Hello / Good morning", phonetic: "bon-zhoo-kh", punjabiSound: "ਬੋਂਜ਼ੂਖ਼", emojiIcon: "☀️"),
                        BasicsItem(french: "Bonsoir", english: "Good evening", phonetic: "bon-swahr", punjabiSound: "ਬੋਂਸਵਾਖ਼", emojiIcon: "🌙"),
                        BasicsItem(french: "Au revoir", english: "Goodbye", phonetic: "oh-khvahr", punjabiSound: "ਓ-ਖ਼ਵਾਖ਼", emojiIcon: "👋"),
                        BasicsItem(french: "S'il vous plaît", english: "Please (formal)", phonetic: "seel-voo-pleh", punjabiSound: "ਸੀਲ-ਵੂ-ਪਲੇ", emojiIcon: "🙏"),
                        BasicsItem(french: "Merci beaucoup", english: "Thank you very much", phonetic: "mair-see boh-koo", punjabiSound: "ਮੈਖ਼ਸੀ ਬੋਕੂ", emojiIcon: "💖"),
                        BasicsItem(french: "De rien", english: "You're welcome", phonetic: "duh-ryen", punjabiSound: "ਦੁ-ਰਿਆਂ", emojiIcon: "😊"),
                        BasicsItem(french: "Pardon / Désolé", english: "Sorry / Excuse me", phonetic: "par-dohn / day-zoh-lay", punjabiSound: "ਪਾਰਦੋਂ / ਦੇਜ਼ੋਲੇ", emojiIcon: "🤝", spokenText: "Pardon, Désolé"),
                        BasicsItem(french: "Comment ça va ?", english: "How is it going?", phonetic: "koh-mahn sah vah", punjabiSound: "ਕੋਮਾਂ ਸਾ ਵਾ", emojiIcon: "💬"),
                        BasicsItem(french: "À bientôt", english: "See you soon", phonetic: "ah byan-toh", punjabiSound: "ਆ ਬਿਆਂਤੋ", emojiIcon: "👋"),
                        BasicsItem(french: "Enchanté / Enchantée", english: "Nice to meet you", phonetic: "ahn-shahn-tay", punjabiSound: "ਆਂਸ਼ਾਂਤੇ", emojiIcon: "🤝", spokenText: "Enchanté", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Bonne journée !", english: "Have a good day!", phonetic: "bun zhoor-nay", punjabiSound: "ਬੋਨ ਜ਼ੂਖ਼ਨੇ", emojiIcon: "🌤️")
                    ]
                ),
                BasicsCategory(
                    title: "Numbers & Counting (1 to 100)",
                    emojiIcon: "🔢",
                    description: "Master counting from 1 to 100 and compound number rules.",
                    items: [
                        BasicsItem(french: "Un, Deux, Trois, Quatre, Cinq", english: "1, 2, 3, 4, 5", phonetic: "uhn, duh, trwah, katr, sank", punjabiSound: "ਅੰ, ਦੁ, ਤ੍ਰਵਾ, ਕਾਤ੍ਰ, ਸੈਂਕ", emojiIcon: "1️⃣"),
                        BasicsItem(french: "Six, Sept, Huit, Neuf, Dix", english: "6, 7, 8, 9, 10", phonetic: "sees, set, weet, nuhf, dees", punjabiSound: "ਸੀਸ, ਸੈਤ, ਵੀਤ, ਨੂਫ, ਦੀਸ", emojiIcon: "6️⃣"),
                        BasicsItem(french: "Onze, Douze, Treize, Quatorze, Quinze, Seize", english: "11 to 16", phonetic: "ohnz, dooz, trehz, kah-torz, kanz, sehz", punjabiSound: "ਓਂਜ਼, ਦੂਜ਼, ਤ੍ਰੈਜ਼, ਕਾਤੋਖ਼ਜ਼, ਕੈਂਜ਼, ਸੈਜ਼", emojiIcon: "🔢"),
                        BasicsItem(french: "Vingt, Trente, Quarante, Cinquante, Soixante", english: "20, 30, 40, 50, 60", phonetic: "vahn, trahnt, kah-rahnt, san-kahnt, swah-sahnt", punjabiSound: "ਵੇਂ, ਤ੍ਰਾਂਤ, ਕਾਰਾਂਤ, ਸੈਂਕਾਂਤ, ਸਵਾਸਾਂਤ", emojiIcon: "📊"),
                        BasicsItem(french: "Soixante-dix (70)", english: "70 (60 + 10 = Soixante-dix)", phonetic: "swah-sahnt-dees", punjabiSound: "ਸਵਾਸਾਂਤ-ਦੀਸ", emojiIcon: "➕", grammarNote: "70 in French is 60+10 (Soixante-dix), 71 is Soixante-et-onze!", spokenText: "Soixante-dix"),
                        BasicsItem(french: "Quatre-vingts (80)", english: "80 (4 × 20 = Quatre-vingts)", phonetic: "katr-vahn", punjabiSound: "ਕਾਤ੍ਰ-ਵੇਂ", emojiIcon: "✖️", grammarNote: "80 in French is 4 times 20 (Quatre-vingts)!", spokenText: "Quatre-vingts"),
                        BasicsItem(french: "Quatre-vingt-dix (90)", english: "90 (4 × 20 + 10 = Quatre-vingt-dix)", phonetic: "katr-vahn-dees", punjabiSound: "ਕਾਤ੍ਰ-ਵੇਂ-ਦੀਸ", emojiIcon: "➕", grammarNote: "90 is (4×20)+10. 99 is Quatre-vingt-dix-neuf!", spokenText: "Quatre-vingt-dix"),
                        BasicsItem(french: "Cent", english: "100", phonetic: "sahn", punjabiSound: "ਸਾਂ", emojiIcon: "💯")
                    ]
                ),
                BasicsCategory(
                    title: "Colors (Les Couleurs)",
                    emojiIcon: "🎨",
                    description: "Colors in French with exact color dots & gender forms.",
                    items: [
                        BasicsItem(french: "Rouge", english: "Red (m/f invariable)", phonetic: "roozh", punjabiSound: "ਰੂਜ਼", emojiIcon: "🔴", colorHex: "#FF3B30", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Bleu / Bleue", english: "Blue (m: Bleu | f: Bleue)", phonetic: "bluh", punjabiSound: "ਬਲੂ", emojiIcon: "🔵", colorHex: "#007AFF", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Vert / Verte", english: "Green (m: Vert | f: Verte)", phonetic: "vair / vairt", punjabiSound: "ਵੇਖ਼ / ਵੇਖ਼ਤ", emojiIcon: "🟢", spokenText: "Vert, Verte", colorHex: "#34C759", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Jaune", english: "Yellow (m/f invariable)", phonetic: "zhohn", punjabiSound: "ਜ਼ੋਨ", emojiIcon: "🟡", colorHex: "#FFCC00", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Blanc / Blanche", english: "White (m: Blanc | f: Blanche)", phonetic: "blahn / blahnsh", punjabiSound: "ਬਲਾਂ / ਬਲਾਂਸ਼", emojiIcon: "⚪", spokenText: "Blanc, Blanche", colorHex: "#FFFFFF", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Noir / Noire", english: "Black (m: Noir | f: Noire)", phonetic: "nwahr", punjabiSound: "ਨਵਾਖ਼", emojiIcon: "⚫", spokenText: "Noir, Noire", colorHex: "#1C1C1E", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Orange", english: "Orange (m/f invariable)", phonetic: "oh-rahnzh", punjabiSound: "ਓਰਾਂਜ਼", emojiIcon: "🟠", colorHex: "#FF9500", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Rose", english: "Pink (m/f invariable)", phonetic: "rohz", punjabiSound: "ਰੋਜ਼", emojiIcon: "🩷", colorHex: "#FF2D55", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Violet / Violette", english: "Purple (m: Violet | f: Violette)", phonetic: "vyoh-leh / vyoh-let", punjabiSound: "ਵੀਓਲੇ / ਵੀਓਲੇਤ", emojiIcon: "🟣", spokenText: "Violet, Violette", colorHex: "#AF52DE", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Gris / Grise", english: "Grey (m: Gris | f: Grise)", phonetic: "gree / greez", punjabiSound: "ਗ੍ਰੀ / ਗ੍ਰੀਜ਼", emojiIcon: "🔘", spokenText: "Gris, Grise", colorHex: "#8E8E93", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Marron", english: "Brown (m/f invariable)", phonetic: "mah-rohn", punjabiSound: "ਮਾਰੋਂ", emojiIcon: "🟤", colorHex: "#A2845E", genderTag: "MASC & FEM")
                    ]
                ),
                BasicsCategory(
                    title: "Shapes (Les Formes)",
                    emojiIcon: "📐",
                    description: "Geometric shapes and forms.",
                    items: [
                        BasicsItem(french: "Le Cercle", english: "Circle", phonetic: "luh sair-klə", punjabiSound: "ਲੁ ਸੈਰਕਲ", emojiIcon: "🔴", genderTag: "MASC"),
                        BasicsItem(french: "Le Carré", english: "Square", phonetic: "luh kah-ray", punjabiSound: "ਲੁ ਕਾਰੇ", emojiIcon: "🟦", genderTag: "MASC"),
                        BasicsItem(french: "Le Triangle", english: "Triangle", phonetic: "luh treh-ahn-glə", punjabiSound: "ਲੁ ਤ੍ਰਿਆਂਗਲ", emojiIcon: "🔺", genderTag: "MASC"),
                        BasicsItem(french: "L'Étoile", english: "Star (la)", phonetic: "lay-twahl", punjabiSound: "ਲੇਤਵਾਲ", emojiIcon: "⭐", genderTag: "FEM"),
                        BasicsItem(french: "Le Rectangle", english: "Rectangle", phonetic: "luh khayk-tahn-glə", punjabiSound: "ਲੁ ਰੇਕਤਾਂਗਲ", emojiIcon: "🟧", genderTag: "MASC")
                    ]
                ),
                BasicsCategory(
                    title: "Praising & Describing (TEF/TCF)",
                    emojiIcon: "✨",
                    description: "High-scoring adjectives & expressions to describe scenery, nature, and people in speaking exams.",
                    items: [
                        BasicsItem(french: "Captivant / Captivante", english: "Captivating / Mesmerizing", phonetic: "kahp-tee-vahn / kahp-tee-vahnt", punjabiSound: "ਕਾਪਤੀਵਾਂ / ਕਾਪਤੀਵਾਂਤ", emojiIcon: "🌀", grammarNote: "Describe scenery or an artwork to show high-level vocabulary!", spokenText: "Captivant, Captivante", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Fascinant / Fascinante", english: "Fascinating", phonetic: "fah-see-nahn / fah-see-nahnt", punjabiSound: "ਫਾਸੀਨਾਂ / ਫਾਸੀਨਾਂਤ", emojiIcon: "🤩", spokenText: "Fascinant, Fascinante", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Adorable", english: "Adorable / Lovable", phonetic: "ah-doh-rah-blə", punjabiSound: "ਆਦੋਰਾਬਲ", emojiIcon: "🥰", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Magnifique", english: "Gorgeous / Magnificent", phonetic: "mah-nyee-feek", punjabiSound: "ਮਾਨੀਫੀਕ", emojiIcon: "✨", grammarNote: "Invariable: stays 'magnifique' for both genders.", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Splendide", english: "Splendid / Superb", phonetic: "splahn-deed", punjabiSound: "ਸਪਲਾਂਦੀਦ", emojiIcon: "🌟", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Fabuleux / Fabuleuse", english: "Fabulous", phonetic: "fah-boo-luh / fah-boo-luhz", punjabiSound: "ਫਾਬੂਲੂ / ਫਾਬੂਲੂਜ਼", emojiIcon: "🏆", spokenText: "Fabuleux, Fabuleuse", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Verdoyant / Verdoyante", english: "Lush Green / Verdant", phonetic: "vair-doy-yahn / vair-doy-yahnt", punjabiSound: "ਵੇਖ਼ਦੁਆਯਾਂ / ਵੇਖ਼ਦੁਆਯਾਂਤ", emojiIcon: "🌳", grammarNote: "Perfect to describe natural spots in TEF speaking tasks!", spokenText: "Verdoyant, Verdoyante", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Pittoresque", english: "Picturesque / Scenic", phonetic: "pee-toh-resk", punjabiSound: "ਪੀਤੋਰੈਸਕ", emojiIcon: "🖼️", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Une vue imprenable", english: "Breathtaking / Unobstructed View", phonetic: "oon voo ahn-pruh-nah-blə", punjabiSound: "ਊਨ ਵੂ ਐਂਪ੍ਰਨਾਬਲ", emojiIcon: "🏔️", grammarNote: "Idiomatic: means an unobstructed stunning view from a mountain/balcony.", genderTag: "FEM"),
                        BasicsItem(french: "À couper le souffle", english: "Breath-taking", phonetic: "ah koo-pay luh soo-flə", punjabiSound: "ਆ ਕੂਪੇ ਲੁ ਸੂਫਲ", emojiIcon: "🌬️", grammarNote: "Literally: 'to cut the breath'. A native-level French phrase for exams."),
                        BasicsItem(french: "Charmant / Charmante", english: "Charming / Lovely", phonetic: "shar-mahn / shar-mahnt", punjabiSound: "ਸ਼ਾਰਮਾਂ / ਸ਼ਾਰਮਾਂਤ", emojiIcon: "🌸", spokenText: "Charmant, Charmante", genderTag: "MASC & FEM")
                    ]
                )
            ]
        ),

        // SECTION 2: Me and My Family
        BasicsSectionGroup(
            title: "Section 2: Me and My Family",
            emojiIcon: "👨‍👩‍👧‍👦",
            categories: [
                BasicsCategory(
                    title: "Parts of the Body",
                    emojiIcon: "🧍",
                    description: "Human body parts in French.",
                    items: [
                        BasicsItem(french: "La Tête", english: "Head", phonetic: "lah teht", punjabiSound: "ਲਾ ਤੇਤ", emojiIcon: "🗣️", genderTag: "FEM"),
                        BasicsItem(french: "Les Épaules", english: "Shoulders (la)", phonetic: "leh-zay-pohl", punjabiSound: "ਲੇਜ਼ੇਪੋਲ", emojiIcon: "🧍", genderTag: "FEM"),
                        BasicsItem(french: "Les Yeux", english: "Eyes (un œil / le)", phonetic: "leh-zyuh", punjabiSound: "ਲੇਜ਼ੂ", emojiIcon: "👀", genderTag: "MASC"),
                        BasicsItem(french: "Les Oreilles", english: "Ears (une / la)", phonetic: "leh-zoh-ray-yə", punjabiSound: "ਲੇਜ਼ੋਰੇਯ", emojiIcon: "👂", genderTag: "FEM"),
                        BasicsItem(french: "Les Mains", english: "Hands (la main)", phonetic: "leh mahn", punjabiSound: "ਲੇ ਮੈਂ", emojiIcon: "✋", genderTag: "FEM"),
                        BasicsItem(french: "Les Pieds", english: "Feet (le pied)", phonetic: "leh pyay", punjabiSound: "ਲੇ ਪਿਏ", emojiIcon: "🦶", genderTag: "MASC"),
                        BasicsItem(french: "Le Nez", english: "Nose", phonetic: "luh nay", punjabiSound: "ਲੁ ਨੇ", emojiIcon: "👃", genderTag: "MASC"),
                        BasicsItem(french: "La Bouche", english: "Mouth", phonetic: "lah boosh", punjabiSound: "ਲਾ ਬੂਸ਼", emojiIcon: "👄", genderTag: "FEM"),
                        BasicsItem(french: "Les Cheveux", english: "Hair (le cheveu)", phonetic: "leh shuh-vuh", punjabiSound: "ਲੇ ਸ਼ੁਵੂ", emojiIcon: "💇", genderTag: "MASC"),
                        BasicsItem(french: "Le Bras", english: "Arm", phonetic: "luh brah", punjabiSound: "ਲੁ ਬ੍ਰਾ", emojiIcon: "💪", genderTag: "MASC"),
                        BasicsItem(french: "La Jambe", english: "Leg", phonetic: "lah zhahnb", punjabiSound: "ਲਾ ਜ਼ਾਂਬ", emojiIcon: "🦵", genderTag: "FEM")
                    ]
                ),
                BasicsCategory(
                    title: "Family Members",
                    emojiIcon: "🏡",
                    description: "Parents, siblings, and relatives.",
                    items: [
                        BasicsItem(french: "La Mère (Maman)", english: "Mother (Mom)", phonetic: "lah mair-kh", punjabiSound: "ਲਾ ਮੇਖ਼ (ਮਾਮਾਂ)", emojiIcon: "👩", spokenText: "La Mère, Maman", genderTag: "FEM"),
                        BasicsItem(french: "Le Père (Papa)", english: "Father (Dad)", phonetic: "luh pair-kh", punjabiSound: "ਲੁ ਪੇਖ਼ (ਪਾਪਾ)", emojiIcon: "👨", spokenText: "Le Père, Papa", genderTag: "MASC"),
                        BasicsItem(french: "Le Frère", english: "Brother", phonetic: "luh frehr", punjabiSound: "ਲੁ ਫ੍ਰੇਖ਼", emojiIcon: "👦", genderTag: "MASC"),
                        BasicsItem(french: "La Sœur", english: "Sister", phonetic: "lah suhr", punjabiSound: "ਲਾ ਸੂਖ਼", emojiIcon: "👧", genderTag: "FEM"),
                        BasicsItem(french: "Le Grand-père", english: "Grandfather", phonetic: "luh grahn-pair-kh", punjabiSound: "ਲੁ ਗ੍ਰਾਂ-ਪੇਖ਼", emojiIcon: "👴", genderTag: "MASC"),
                        BasicsItem(french: "La Grand-mère", english: "Grandmother", phonetic: "lah grahn-mair-kh", punjabiSound: "ਲਾ ਗ੍ਰਾਂ-ਮੇਖ਼", emojiIcon: "👵", genderTag: "FEM"),
                        BasicsItem(french: "Le Fils", english: "Son", phonetic: "luh fees", punjabiSound: "ਲੁ ਫੀਸ", emojiIcon: "👦", genderTag: "MASC"),
                        BasicsItem(french: "La Fille", english: "Daughter", phonetic: "lah feey", punjabiSound: "ਲਾ ਫੀਯ", emojiIcon: "👧", genderTag: "FEM"),
                        BasicsItem(french: "L'Oncle", english: "Uncle", phonetic: "lohn-klə", punjabiSound: "ਲੋਂਕਲ", emojiIcon: "👨", genderTag: "MASC"),
                        BasicsItem(french: "La Tante", english: "Aunt", phonetic: "lah tahnt", punjabiSound: "ਲਾ ਤਾਂਤ", emojiIcon: "👩", genderTag: "FEM"),
                        BasicsItem(french: "L'Ami / L'Amie", english: "Friend", phonetic: "lah-mee", punjabiSound: "ਲਾਮੀ", emojiIcon: "🧑‍🤝‍🧑", spokenText: "L'Ami", genderTag: "MASC & FEM")
                    ]
                ),
                BasicsCategory(
                    title: "Feelings & Emotions",
                    emojiIcon: "😀",
                    description: "Express how you feel.",
                    items: [
                        BasicsItem(french: "Je suis heureux (m) / heureuse (f)", english: "I am happy", phonetic: "zhuh swee uh-ruh", punjabiSound: "ਜ਼ੁ ਸੁਈ ਊਰੂ", emojiIcon: "😀", spokenText: "Je suis heureux, heureuse", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Je suis triste (m/f)", english: "I am sad", phonetic: "zhuh swee treest", punjabiSound: "ਜ਼ੁ ਸੁਈ ਤ੍ਰੀਸਤ", emojiIcon: "😢", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Je suis fatigué (m) / fatiguée (f)", english: "I am tired", phonetic: "zhuh swee fah-tee-gay", punjabiSound: "ਜ਼ੁ ਸੁਈ ਫਾਤੀਗੇ", emojiIcon: "🥱", spokenText: "Je suis fatigué", genderTag: "MASC & FEM"),
                        BasicsItem(french: "J'ai faim", english: "I am hungry (I have hunger)", phonetic: "zhay fahn", punjabiSound: "ਜ਼ੇ ਫੈਂ", emojiIcon: "🍽️"),
                        BasicsItem(french: "J'ai soif", english: "I am thirsty (I have thirst)", phonetic: "zhay swahf", punjabiSound: "ਜ਼ੇ ਸਵਾਫ", emojiIcon: "🧃"),
                        BasicsItem(french: "Je suis en colère", english: "I am angry", phonetic: "zhuh swee zahn koh-lair", punjabiSound: "ਜ਼ੁ ਸੁਈ ਜ਼ਾਂ ਕੋਲੈਖ਼", emojiIcon: "😡", spokenText: "Je suis en colère"),
                        BasicsItem(french: "Je suis surpris / surprise", english: "I am surprised", phonetic: "zhuh swee soor-pree", punjabiSound: "ਜ਼ੁ ਸੁਈ ਸੂਖ਼ਪ੍ਰੀ", emojiIcon: "😮", spokenText: "Je suis surpris", genderTag: "MASC & FEM"),
                        BasicsItem(french: "Je suis malade", english: "I am sick", phonetic: "zhuh swee mah-lahd", punjabiSound: "ਜ਼ੁ ਸੁਈ ਮਾਲਾਦ", emojiIcon: "🤒"),
                        BasicsItem(french: "J'ai peur", english: "I am scared (I have fear)", phonetic: "zhay puhr", punjabiSound: "ਜ਼ੇ ਪੂਖ਼", emojiIcon: "😨")
                    ]
                ),
                BasicsCategory(
                    title: "Personal Stuff & Clothing",
                    emojiIcon: "👕",
                    description: "Everyday clothes and grooming items.",
                    items: [
                        BasicsItem(french: "Le Peigne", english: "Comb", phonetic: "luh pehn-yə", punjabiSound: "ਲੁ ਪੇਨਯ", emojiIcon: "🪮", genderTag: "MASC"),
                        BasicsItem(french: "L'Huile pour cheveux", english: "Hair oil (la)", phonetic: "lweel poor shuh-vuh", punjabiSound: "ਲੁਈਲ ਪੂਖ਼ ਸ਼ੁਵੂ", emojiIcon: "🧴", genderTag: "FEM"),
                        BasicsItem(french: "Le Sèche-cheveux", english: "Hair dryer", phonetic: "luh sehsh-shuh-vuh", punjabiSound: "ਲੁ ਸੈਸ਼-ਸ਼ੁਵੂ", emojiIcon: "💨", genderTag: "MASC"),
                        BasicsItem(french: "Le T-shirt", english: "T-shirt", phonetic: "luh tee-shurt", punjabiSound: "ਲੁ ਟੀ-ਸ਼ਰਟ", emojiIcon: "👕", genderTag: "MASC"),
                        BasicsItem(french: "Les Chaussures", english: "Shoes (la)", phonetic: "leh shoh-soor", punjabiSound: "ਲੇ ਸ਼ੋਸੂਖ਼", emojiIcon: "👟", genderTag: "FEM"),
                        BasicsItem(french: "Le Pyjama", english: "Pajamas", phonetic: "luh pee-zhah-mah", punjabiSound: "ਲੁ ਪੀਜ਼ਾਮਾ", emojiIcon: "🥋", genderTag: "MASC"),
                        BasicsItem(french: "Les Sous-vêtements", english: "Underwear (le)", phonetic: "leh soo-veh-tmah", punjabiSound: "ਲੇ ਸੂ-ਵੇਤਮਾਂ", emojiIcon: "🩲", genderTag: "MASC"),
                        BasicsItem(french: "Les Chaussettes", english: "Socks (la)", phonetic: "leh shoh-set", punjabiSound: "ਲੇ ਸ਼ੋਸੈਤ", emojiIcon: "🧦", genderTag: "FEM"),
                        BasicsItem(french: "Le Pantalon", english: "Trousers / Pants", phonetic: "luh pahn-tah-lohn", punjabiSound: "ਲੁ ਪਾਂਤਾਲੋਂ", emojiIcon: "👖", genderTag: "MASC"),
                        BasicsItem(french: "La Robe", english: "Dress", phonetic: "lah ruhb", punjabiSound: "ਲਾ ਰੋਬ", emojiIcon: "👗", genderTag: "FEM"),
                        BasicsItem(french: "La Veste", english: "Jacket", phonetic: "lah vest", punjabiSound: "ਲਾ ਵੈਸਤ", emojiIcon: "🧥", genderTag: "FEM"),
                        BasicsItem(french: "Le Chapeau", english: "Hat", phonetic: "luh shah-poh", punjabiSound: "ਲੁ ਸ਼ਾਪੋ", emojiIcon: "🎩", genderTag: "MASC")
                    ]
                )
            ]
        ),

        // SECTION 3: Time and Nature
        BasicsSectionGroup(
            title: "Section 3: Time and Nature",
            emojiIcon: "⏰",
            categories: [
                BasicsCategory(
                    title: "Days of the Week",
                    emojiIcon: "📅",
                    description: "The 7 days of the week (all masculine in French).",
                    items: [
                        BasicsItem(french: "Lundi", english: "Monday (Le)", phonetic: "luhn-dee", punjabiSound: "ਲੰਦੀ", emojiIcon: "📅", genderTag: "MASC"),
                        BasicsItem(french: "Mardi", english: "Tuesday (Le)", phonetic: "mar-dee", punjabiSound: "ਮਾਰਦੀ", emojiIcon: "📅", genderTag: "MASC"),
                        BasicsItem(french: "Mercredi", english: "Wednesday (Le)", phonetic: "mair-kruh-dee", punjabiSound: "ਮੈਖ਼ਕ੍ਰੁਦੀ", emojiIcon: "📅", genderTag: "MASC"),
                        BasicsItem(french: "Jeudi", english: "Thursday (Le)", phonetic: "zhuh-dee", punjabiSound: "ਜ਼ੁਦੀ", emojiIcon: "📅", genderTag: "MASC"),
                        BasicsItem(french: "Vendredi", english: "Friday (Le)", phonetic: "vahn-druh-dee", punjabiSound: "ਵਾਂਦ੍ਰੁਦੀ", emojiIcon: "📅", genderTag: "MASC"),
                        BasicsItem(french: "Samedi", english: "Saturday (Le)", phonetic: "sahm-dee", punjabiSound: "ਸਾਮਦੀ", emojiIcon: "📅", genderTag: "MASC"),
                        BasicsItem(french: "Dimanche", english: "Sunday (Le)", phonetic: "dee-mahnsh", punjabiSound: "ਦੀਮਾਂਸ਼", emojiIcon: "☀️", genderTag: "MASC")
                    ]
                ),
                BasicsCategory(
                    title: "Months of the Year",
                    emojiIcon: "🗓️",
                    description: "The 12 months in French (all masculine).",
                    items: [
                        BasicsItem(french: "Janvier, Février, Mars, Avril", english: "Jan, Feb, Mar, Apr (m)", phonetic: "zhahn-vyay, fay-vryay, marz, ah-vreel", punjabiSound: "ਜ਼ਾਂਵੀਏ, ਫੇਵਰੀਏ, ਮਾਰਸ, ਆਵਰੀਲ", emojiIcon: "❄️", genderTag: "MASC"),
                        BasicsItem(french: "Mai, Juin, Juillet, Août", english: "May, June, July, Aug (m)", phonetic: "meh, zhwahn, zhwee-yeh, oot", punjabiSound: "ਮੇ, ਜ਼ਵਾਂ, ਜ਼ੁਈਏ, ਊਤ", emojiIcon: "☀️", genderTag: "MASC"),
                        BasicsItem(french: "Septembre, Octobre, Novembre, Décembre", english: "Sep, Oct, Nov, Dec (m)", phonetic: "sep-tahm-brə, ok-toh-brə, noh-vahm-brə, day-sahm-brə", punjabiSound: "ਸੈਪਤਾਂਬ੍ਰ, ਓਕਤੋਬ੍ਰ, ਨੋਵਾਂਬ੍ਰ, ਦੇਸਾਂਬ੍ਰ", emojiIcon: "🍂", genderTag: "MASC")
                    ]
                ),
                BasicsCategory(
                    title: "Seasons & Weather",
                    emojiIcon: "🌤️",
                    description: "Talk about weather and four seasons.",
                    items: [
                        BasicsItem(french: "L'Été", english: "Summer (le)", phonetic: "lay-tay", punjabiSound: "ਲੇਤੇ", emojiIcon: "☀️", genderTag: "MASC"),
                        BasicsItem(french: "L'Hiver", english: "Winter (le)", phonetic: "lee-vair", punjabiSound: "ਲੀਵੇਖ਼", emojiIcon: "❄️", genderTag: "MASC"),
                        BasicsItem(french: "L'Automne", english: "Autumn / Fall (le)", phonetic: "loh-tuhn", punjabiSound: "ਲੋਤন", emojiIcon: "🍂", genderTag: "MASC"),
                        BasicsItem(french: "Le Printemps", english: "Spring", phonetic: "luh prahn-tahn", punjabiSound: "ਲੁ ਪ੍ਰਾਂਤਾਂ", emojiIcon: "🌸", genderTag: "MASC"),
                        BasicsItem(french: "Il fait beau", english: "The weather is nice", phonetic: "eel feh boh", punjabiSound: "ਈਲ ਫੇ ਬੋ", emojiIcon: "🌤️"),
                        BasicsItem(french: "Il pleut", english: "It is raining", phonetic: "eel pluh", punjabiSound: "ਈਲ ਪਲੂ", emojiIcon: "🌧️")
                    ]
                ),
                BasicsCategory(
                    title: "Telling Time (Clock Guide)",
                    emojiIcon: "⏰",
                    description: "Learn how to ask and tell time in French.",
                    items: [
                        BasicsItem(french: "Quelle heure est-il ?", english: "What time is it?", phonetic: "kel uhr eh-teel", punjabiSound: "ਕੈਲ ਊਖ਼ ਐ-ਤੀਲ", emojiIcon: "❓"),
                        BasicsItem(french: "Il est huit heures (8h00)", english: "It is 8 o'clock", phonetic: "eel eh weet uhr", punjabiSound: "ਈਲ ਐ ਵੀਤ ਊਖ਼", emojiIcon: "⏰", spokenText: "Il est huit heures"),
                        BasicsItem(french: "Il est huit heures et quart (8h15)", english: "It is 8:15 (quarter past 8)", phonetic: "eel eh weet uhr ay kar", punjabiSound: "ਈਲ ਐ ਵੀਤ ਊਖ਼ ਏ ਕਾਰ", emojiIcon: "⏰", spokenText: "Il est huit heures et quart"),
                        BasicsItem(french: "Il est huit heures et demie (8h30)", english: "It is 8:30 (half past 8)", phonetic: "eel eh weet uhr ay duh-mee", punjabiSound: "ਈਲ ਐ ਵੀਤ ਊਖ਼ ਏ ਦੁਮੀ", emojiIcon: "⏰", spokenText: "Il est huit heures et demie"),
                        BasicsItem(french: "Il est neuf heures moins le quart (8h45)", english: "It is 8:45 (quarter to 9)", phonetic: "eel eh nuhf uhr mwahn luh kar", punjabiSound: "ਈਲ ਐ ਨੂਫ ਊਖ਼ ਮਵਾਂ ਲੁ ਕਾਰ", emojiIcon: "⏰", spokenText: "Il est neuf heures moins le quart")
                    ]
                ),
                BasicsCategory(
                    title: "The Date (La Date)",
                    emojiIcon: "📆",
                    description: "How to say and write today's date.",
                    items: [
                        BasicsItem(french: "Aujourd'hui, c'est...", english: "Today is...", phonetic: "oh-zhoor-dwee seh", punjabiSound: "ਓਜ਼ੂਖ਼ਦੁਈ ਸੈ", emojiIcon: "☀️"),
                        BasicsItem(french: "Quel jour sommes-nous ?", english: "What day are we today?", phonetic: "kel zhoor suhm-noo", punjabiSound: "ਕੈਲ ਜ਼ੂਖ਼ ਸੁਮ-ਨੂ", emojiIcon: "❓"),
                        BasicsItem(french: "C'est le 15 août", english: "It is August 15th (Date format: Le + Number + Month)", phonetic: "seh luh kanz oot", punjabiSound: "ਸੈ ਲੁ ਕੈਂਜ਼ ਊਤ", emojiIcon: "🗓️", grammarNote: "In French dates, always write 'Le' + Number + Month (e.g. Le 15 août). First day is 'Le premier'!")
                    ]
                ),
                BasicsCategory(
                    title: "Nature & Sky",
                    emojiIcon: "🌳",
                    description: "Sun, moon, stars, trees and flowers.",
                    items: [
                        BasicsItem(french: "Le Soleil", english: "Sun", phonetic: "luh soh-lay", punjabiSound: "ਲੁ ਸੋਲੇ", emojiIcon: "☀️", genderTag: "MASC"),
                        BasicsItem(french: "La Lune", english: "Moon", phonetic: "lah loon", punjabiSound: "ਲਾ ਲੂਨ", emojiIcon: "🌙", genderTag: "FEM"),
                        BasicsItem(french: "Les Étoiles", english: "Stars (la)", phonetic: "leh-zay-twahl", punjabiSound: "ਲੇਜ਼ੇਤਵਾਲ", emojiIcon: "⭐", genderTag: "FEM"),
                        BasicsItem(french: "L'Arbre", english: "Tree (le)", phonetic: "lahr-brə", punjabiSound: "ਲਾਰਬ੍ਰ", emojiIcon: "🌳", genderTag: "MASC"),
                        BasicsItem(french: "La Fleur", english: "Flower", phonetic: "lah fluhr", punjabiSound: "ਲਾ ਫਲੂਖ਼", emojiIcon: "🌸", genderTag: "FEM")
                    ]
                )
            ]
        ),

        // SECTION 4: My Home and School
        BasicsSectionGroup(
            title: "Section 4: My Home and School",
            emojiIcon: "🎒",
            categories: [
                BasicsCategory(
                    title: "My Room & Furniture",
                    emojiIcon: "🛏️",
                    description: "Furniture and room essentials.",
                    items: [
                        BasicsItem(french: "Le Lit", english: "Bed", phonetic: "luh lee", punjabiSound: "ਲੁ ਲੀ", emojiIcon: "🛏️", genderTag: "MASC"),
                        BasicsItem(french: "La Chaise", english: "Chair", phonetic: "lah shehz", punjabiSound: "ਲਾ ਸ਼ੈਜ਼", emojiIcon: "🪑", genderTag: "FEM"),
                        BasicsItem(french: "La Table", english: "Table", phonetic: "lah tah-blə", punjabiSound: "ਲਾ ਤਾਬਲ", emojiIcon: "🪵", genderTag: "FEM"),
                        BasicsItem(french: "L'Armoire", english: "Wardrobe / Almirah (la)", phonetic: "lar-mwahr", punjabiSound: "ਲਾਰਮਵਾਖ਼", emojiIcon: "🚪", genderTag: "FEM"),
                        BasicsItem(french: "La Coiffeuse", english: "Dressing table", phonetic: "lah kwah-fuhz", punjabiSound: "ਲਾ ਕਵਾਫੂਜ਼", emojiIcon: "🪞", genderTag: "FEM"),
                        BasicsItem(french: "Le Bureau", english: "Desk / Study table", phonetic: "luh boo-roh", punjabiSound: "ਲੁ ਬੂਰੋ", emojiIcon: "✍️", genderTag: "MASC"),
                        BasicsItem(french: "La Lampe", english: "Lamp", phonetic: "lah lahnp", punjabiSound: "ਲਾ ਲਾਂਪ", emojiIcon: "💡", genderTag: "FEM"),
                        BasicsItem(french: "Le Miroir", english: "Mirror", phonetic: "luh mee-khwahr", punjabiSound: "ਲੁ ਮੀਖ਼ਵਾਰ", emojiIcon: "🪞", genderTag: "MASC"),
                        BasicsItem(french: "L'Oreiller", english: "Pillow", phonetic: "loh-ray-yay", punjabiSound: "ਲੋਰੇਯੇ", emojiIcon: "🛌", genderTag: "MASC"),
                        BasicsItem(french: "La Couverture", english: "Blanket / Quilt", phonetic: "lah koo-vair-toor", punjabiSound: "ਲਾ ਕੂਵੇਖ਼ਤੂਖ਼", emojiIcon: "🧣", genderTag: "FEM"),
                        BasicsItem(french: "Le Tapis", english: "Rug / Carpet", phonetic: "luh tah-pee", punjabiSound: "ਲੁ ਤਾਪੀ", emojiIcon: "🧶", genderTag: "MASC")
                    ]
                ),
                BasicsCategory(
                    title: "School Supplies",
                    emojiIcon: "✏️",
                    description: "Stationery and school items.",
                    items: [
                        BasicsItem(french: "Le Sac à dos", english: "Backpack / School bag", phonetic: "luh sahk ah doh", punjabiSound: "ਲੁ ਸਾਕ ਆ ਦੋ", emojiIcon: "🎒", genderTag: "MASC"),
                        BasicsItem(french: "Le Crayon", english: "Pencil", phonetic: "luh kreh-yohn", punjabiSound: "ਲੁ ਕ੍ਰੇਯੋਂ", emojiIcon: "✏️", genderTag: "MASC"),
                        BasicsItem(french: "Les Livres", english: "Books (le)", phonetic: "leh leev-khə", punjabiSound: "ਲੇ ਲੀਵਖ਼", emojiIcon: "📚", genderTag: "MASC"),
                        BasicsItem(french: "La Gomme", english: "Eraser", phonetic: "lah guhm", punjabiSound: "ਲਾ ਗੋਮ", emojiIcon: "🧼", genderTag: "FEM"),
                        BasicsItem(french: "Le Stylo", english: "Pen", phonetic: "luh stee-loh", punjabiSound: "ਲੁ ਸਤੀਲੋ", emojiIcon: "🖊️", genderTag: "MASC"),
                        BasicsItem(french: "Le Cahier", english: "Notebook", phonetic: "luh kah-yay", punjabiSound: "ਲੁ ਕਾਯੇ", emojiIcon: "📓", genderTag: "MASC"),
                        BasicsItem(french: "La Règle", english: "Ruler", phonetic: "lah reh-glə", punjabiSound: "ਲਾ ਰੈਗਲ", emojiIcon: "📏", genderTag: "FEM"),
                        BasicsItem(french: "Les Ciseaux", english: "Scissors (le)", phonetic: "leh see-zoh", punjabiSound: "ਲੇ ਸੀਜ਼ੋ", emojiIcon: "✂️", genderTag: "MASC")
                    ]
                )
            ]
        ),

        // SECTION 5: Food and World
        BasicsSectionGroup(
            title: "Section 5: Food and World",
            emojiIcon: "🍎",
            categories: [
                BasicsCategory(
                    title: "Kitchen Stuff & Tableware",
                    emojiIcon: "🍽️",
                    description: "Plates, spoons, glasses, and utensils.",
                    items: [
                        BasicsItem(french: "L'Assiette", english: "Plate (la)", phonetic: "lah-syeht", punjabiSound: "ਲਾਸਿਏਤ", emojiIcon: "🍽️", genderTag: "FEM"),
                        BasicsItem(french: "La Cuillère", english: "Spoon", phonetic: "lah kwee-yair", punjabiSound: "ਲਾ ਕਵੀਏਖ਼", emojiIcon: "🥄", genderTag: "FEM"),
                        BasicsItem(french: "La Fourchette", english: "Fork", phonetic: "lah foor-sheht", punjabiSound: "ਲਾ ਫੂਰਸ਼ੈਤ", emojiIcon: "🍴", genderTag: "FEM"),
                        BasicsItem(french: "Le Verre", english: "Glass", phonetic: "luh vair", punjabiSound: "ਲੁ ਵੇਖ਼", emojiIcon: "🥛", genderTag: "MASC"),
                        BasicsItem(french: "Le Bol", english: "Bowl", phonetic: "luh buhl", punjabiSound: "ਲੁ ਬੋਲ", emojiIcon: "🥣", genderTag: "MASC"),
                        BasicsItem(french: "Le Couteau", english: "Knife", phonetic: "luh koo-toh", punjabiSound: "ਲੁ ਕੂਤੋ", emojiIcon: "🔪", genderTag: "MASC"),
                        BasicsItem(french: "La Tasse", english: "Cup", phonetic: "lah tahs", punjabiSound: "ਲਾ ਤਾਸ", emojiIcon: "☕", genderTag: "FEM"),
                        BasicsItem(french: "La Poêle", english: "Frying Pan", phonetic: "lah pwahl", punjabiSound: "ਲਾ ਪਵਾਲ", emojiIcon: "🍳", genderTag: "FEM"),
                        BasicsItem(french: "La Bouilloire", english: "Kettle", phonetic: "lah bwee-ywahr", punjabiSound: "ਲਾ ਬੁਈਯਵਾਰ", emojiIcon: "🫖", genderTag: "FEM"),
                        BasicsItem(french: "La Serviette", english: "Napkin", phonetic: "lah sair-vyeht", punjabiSound: "ਲਾ ਸੈਰਵਿਏਤ", emojiIcon: "🧻", genderTag: "FEM")
                    ]
                ),
                BasicsCategory(
                    title: "Fruits",
                    emojiIcon: "🍎",
                    description: "Popular delicious fruits.",
                    items: [
                        BasicsItem(french: "La Pomme", english: "Apple", phonetic: "lah puhm", punjabiSound: "ਲਾ ਪੋਮ", emojiIcon: "🍎", genderTag: "FEM"),
                        BasicsItem(french: "La Banane", english: "Banana", phonetic: "lah bah-nahn", punjabiSound: "ਲਾ ਬਾਨਾਨ", emojiIcon: "🍌", genderTag: "FEM"),
                        BasicsItem(french: "L'Orange", english: "Orange (la)", phonetic: "loh-rahnzh", punjabiSound: "ਲੋਰਾਂਜ਼", emojiIcon: "🍊", genderTag: "FEM"),
                        BasicsItem(french: "Le Raisin", english: "Grapes", phonetic: "luh khay-zahn", punjabiSound: "ਲੁ ਰੇਜ਼ਾਂ", emojiIcon: "🍇", genderTag: "MASC"),
                        BasicsItem(french: "La Fraise", english: "Strawberry", phonetic: "lah frehz", punjabiSound: "ਲਾ ਫ੍ਰੈਜ਼", emojiIcon: "🍓", genderTag: "FEM"),
                        BasicsItem(french: "Le Citron", english: "Lemon", phonetic: "luh see-trohn", punjabiSound: "ਲੁ ਸੀਤ੍ਰੋਂ", emojiIcon: "🍋", genderTag: "MASC"),
                        BasicsItem(french: "La Cerise", english: "Cherry", phonetic: "lah suh-reez", punjabiSound: "ਲਾ ਸੁਰੀਜ਼", emojiIcon: "🍒", genderTag: "FEM"),
                        BasicsItem(french: "La Pêche", english: "Peach", phonetic: "lah pehsh", punjabiSound: "ਲਾ ਪੈਸ਼", emojiIcon: "🍑", genderTag: "FEM"),
                        BasicsItem(french: "La Pastèque", english: "Watermelon", phonetic: "lah pahs-tehk", punjabiSound: "ਲਾ ਪਾਸਤੈਕ", emojiIcon: "🍉", genderTag: "FEM")
                    ]
                ),
                BasicsCategory(
                    title: "Vegetables",
                    emojiIcon: "🥕",
                    description: "Common vegetables.",
                    items: [
                        BasicsItem(french: "La Pomme de terre", english: "Potato", phonetic: "lah puhm duh tair", punjabiSound: "ਲਾ ਪੋਮ ਦੁ ਤੈਖ਼", emojiIcon: "🥔", genderTag: "FEM"),
                        BasicsItem(french: "La Tomate", english: "Tomato", phonetic: "lah toh-maht", punjabiSound: "ਲਾ ਤੋਮਾਤ", emojiIcon: "🍅", genderTag: "FEM"),
                        BasicsItem(french: "L'Oignon", english: "Onion (le)", phonetic: "lohn-yohn", punjabiSound: "ਲੋਨਯੋਂ", emojiIcon: "🧅", genderTag: "MASC"),
                        BasicsItem(french: "Les Carottes", english: "Carrots (la)", phonetic: "leh kah-kht", punjabiSound: "ਲੇ ਕਾਖ਼ੋਤ", emojiIcon: "🥕", genderTag: "FEM"),
                        BasicsItem(french: "La Salade", english: "Lettuce / Salad", phonetic: "lah sah-lahd", punjabiSound: "ਲਾ ਸਾਲਾਦ", emojiIcon: "🥬", genderTag: "FEM"),
                        BasicsItem(french: "Le Concombre", english: "Cucumber", phonetic: "luh kohn-kohn-brə", punjabiSound: "ਲੁ ਕੋਨਕੋਨਬਰ", emojiIcon: "🥒", genderTag: "MASC"),
                        BasicsItem(french: "L'Ail", english: "Garlic", phonetic: "lye", punjabiSound: "ਲਾਈ", emojiIcon: "🧄", genderTag: "MASC"),
                        BasicsItem(french: "Le Petit pois", english: "Peas", phonetic: "luh puh-tee pwah", punjabiSound: "ਲੁ ਪਤੀ ਪਵਾ", emojiIcon: "🫛", spokenText: "Le Petit pois", genderTag: "MASC"),
                        BasicsItem(french: "Le Champignon", english: "Mushroom", phonetic: "luh shahn-peen-yohn", punjabiSound: "ਲੁ ਸ਼ਾਂਪੀਨਯੋਂ", emojiIcon: "🍄", genderTag: "MASC")
                    ]
                ),
                BasicsCategory(
                    title: "Animals",
                    emojiIcon: "🐱",
                    description: "Domestic and wild animals.",
                    items: [
                        BasicsItem(french: "Le Chien", english: "Dog", phonetic: "luh shyen", punjabiSound: "ਲੁ ਸ਼ਿਆਂ", emojiIcon: "🐶", genderTag: "MASC"),
                        BasicsItem(french: "Le Chat", english: "Cat", phonetic: "luh shah", punjabiSound: "ਲੁ ਸ਼ਾ", emojiIcon: "🐱", genderTag: "MASC"),
                        BasicsItem(french: "Le Lion", english: "Lion", phonetic: "luh lee-ohn", punjabiSound: "ਲੁ ਲੀਓਂ", emojiIcon: "🦁", genderTag: "MASC"),
                        BasicsItem(french: "L'Éléphant", english: "Elephant (le)", phonetic: "lay-lay-fahn", punjabiSound: "ਲੇਲੇਫਾਂ", emojiIcon: "🐘", genderTag: "MASC"),
                        BasicsItem(french: "La Vache", english: "Cow", phonetic: "lah vahsh", punjabiSound: "ਲਾ ਵਾਸ਼", emojiIcon: "🐮", genderTag: "FEM"),
                        BasicsItem(french: "Le Cheval", english: "Horse", phonetic: "luh shuh-vahl", punjabiSound: "ਲੁ ਸ਼ਵਾਲ", emojiIcon: "🐎", genderTag: "MASC"),
                        BasicsItem(french: "Le Mouton", english: "Sheep", phonetic: "luh moo-tohn", punjabiSound: "ਲੁ ਮੂਤੋਂ", emojiIcon: "🐑", genderTag: "MASC"),
                        BasicsItem(french: "Le Singe", english: "Monkey", phonetic: "luh sahnh-zhə", punjabiSound: "ਲੁ ਸੈਂਜ਼", emojiIcon: "🐒", genderTag: "MASC"),
                        BasicsItem(french: "Le Lapin", english: "Rabbit", phonetic: "luh lah-pahn", punjabiSound: "ਲੁ ਲਾਪੈਂ", emojiIcon: "🐰", genderTag: "MASC"),
                        BasicsItem(french: "L'Ours", english: "Bear", phonetic: "loors", punjabiSound: "ਲੂਰਸ", emojiIcon: "🐻", genderTag: "MASC"),
                        BasicsItem(french: "L'Oiseau", english: "Bird", phonetic: "lwah-zoh", punjabiSound: "ਲਵਾਜ਼ੋ", emojiIcon: "🐦", genderTag: "MASC")
                    ]
                ),
                BasicsCategory(
                    title: "Transport",
                    emojiIcon: "🚗",
                    description: "Vehicles and transport modes.",
                    items: [
                        BasicsItem(french: "La Voiture", english: "Car", phonetic: "lah vwah-toor", punjabiSound: "ਲਾ ਵਵਾਤੂਖ਼", emojiIcon: "🚗", genderTag: "FEM"),
                        BasicsItem(french: "Le Bus", english: "Bus", phonetic: "luh boos", punjabiSound: "ਲੁ ਬੂਸ", emojiIcon: "🚌", genderTag: "MASC"),
                        BasicsItem(french: "Le Vélo", english: "Bicycle", phonetic: "luh vay-loh", punjabiSound: "ਲੁ ਵੇਲੋ", emojiIcon: "🚲", genderTag: "MASC"),
                        BasicsItem(french: "L'Avion", english: "Airplane (le)", phonetic: "lah-vyohn", punjabiSound: "ਲਾਵੀਓਂ", emojiIcon: "✈️", genderTag: "MASC"),
                        BasicsItem(french: "Le Train", english: "Train", phonetic: "luh trahn", punjabiSound: "ਲੁ ਤ੍ਰੈਂ", emojiIcon: "🚆", genderTag: "MASC"),
                        BasicsItem(french: "Le Bateau", english: "Boat / Ship", phonetic: "luh bah-toh", punjabiSound: "ਲੁ ਬਾਤੋ", emojiIcon: "⛵", genderTag: "MASC"),
                        BasicsItem(french: "Le Taxi", english: "Taxi", phonetic: "luh tahk-see", punjabiSound: "ਲੁ ਤਾਕਸੀ", emojiIcon: "🚕", genderTag: "MASC"),
                        BasicsItem(french: "La Moto", english: "Motorcycle", phonetic: "lah moh-toh", punjabiSound: "ਲਾ ਮੋਤੋ", emojiIcon: "🏍️", genderTag: "FEM"),
                        BasicsItem(french: "Le Métro", english: "Subway / Metro", phonetic: "luh may-troh", punjabiSound: "ਲੁ ਮੇਤਰੋ", emojiIcon: "🚇", genderTag: "MASC")
                    ]
                )
            ]
        )
    ]
}
