import Foundation

// MARK: - Alphabet Item Model

struct AlphabetItem: Identifiable {
    let id = UUID()
    let letter: String
    let frenchWord: String
    let englishMeaning: String
    let phonetic: String
    let punjabiSound: String
    let iconName: String
}

// MARK: - Basics Item Model

struct BasicsItem: Identifiable {
    let id = UUID()
    let french: String
    let english: String
    let phonetic: String
    let punjabiSound: String
    let iconName: String
    var grammarNote: String? = nil
    var spokenText: String? = nil
}

// MARK: - Basics Category Model

struct BasicsCategory: Identifiable {
    let id = UUID()
    let title: String
    let iconName: String
    let description: String
    let items: [BasicsItem]
}

// MARK: - Basics Section Group Model

struct BasicsSectionGroup: Identifiable {
    let id = UUID()
    let title: String
    let iconName: String
    let categories: [BasicsCategory]
}

// MARK: - Basics Dataset (French Kaida)

enum BasicsData {

    // MARK: - 1. Alphabet (A to Z)
    static let alphabet: [AlphabetItem] = [
        AlphabetItem(letter: "A", frenchWord: "Arbre", englishMeaning: "Tree", phonetic: "ah · ahr-brə", punjabiSound: "ਆ · ਆਰਬ੍ਰ", iconName: "tree.fill"),
        AlphabetItem(letter: "B", frenchWord: "Bateau", englishMeaning: "Boat", phonetic: "beh · bah-toh", punjabiSound: "ਬੇ · ਬਾਤੋ", iconName: "sailboat.fill"),
        AlphabetItem(letter: "C", frenchWord: "Chat", englishMeaning: "Cat", phonetic: "seh · shah", punjabiSound: "ਸੇ · ਸ਼ਾ", iconName: "cat.fill"),
        AlphabetItem(letter: "D", frenchWord: "Dauphin", englishMeaning: "Dolphin", phonetic: "deh · doh-fahn", punjabiSound: "ਦੇ · ਦੋਫਾਂ", iconName: "fish.fill"),
        AlphabetItem(letter: "E", frenchWord: "Éléphant", englishMeaning: "Elephant", phonetic: "uh · eh-lay-fahn", punjabiSound: "ਉ · ਏਲੇਫਾਂ", iconName: "circle.grid.cross.fill"),
        AlphabetItem(letter: "F", frenchWord: "Fleur", englishMeaning: "Flower", phonetic: "eff · fluhr", punjabiSound: "ਐਫ · ਫਲੂਖ਼", iconName: "camera.macro"),
        AlphabetItem(letter: "G", frenchWord: "Gâteau", englishMeaning: "Cake", phonetic: "zheh · gah-toh", punjabiSound: "ਜ਼ੇ · ਗਾਤੋ", iconName: "birthday.cake.fill"),
        AlphabetItem(letter: "H", frenchWord: "Horloge", englishMeaning: "Clock", phonetic: "ash · or-lozh", punjabiSound: "ਆਸ਼ · ਓਰਲੋਜ਼", iconName: "clock.fill"),
        AlphabetItem(letter: "I", frenchWord: "Île", englishMeaning: "Island", phonetic: "ee · eel", punjabiSound: "ਈ · ਈਲ", iconName: "sun.max.fill"),
        AlphabetItem(letter: "J", frenchWord: "Jardin", englishMeaning: "Garden", phonetic: "zhee · zhar-dahn", punjabiSound: "ਜ਼ੀ · ਜ਼ਾਰਦਾਂ", iconName: "leaf.fill"),
        AlphabetItem(letter: "K", frenchWord: "Kangourou", englishMeaning: "Kangaroo", phonetic: "kah · kahn-goo-roo", punjabiSound: "ਕਾ · ਕਾਂਗੂਰੂ", iconName: "pawprint.fill"),
        AlphabetItem(letter: "L", frenchWord: "Lune", englishMeaning: "Moon", phonetic: "ell · loon", punjabiSound: "ਐਲ · ਲੂਨ", iconName: "moon.stars.fill"),
        AlphabetItem(letter: "M", frenchWord: "Maison", englishMeaning: "House", phonetic: "emm · meh-zohn", punjabiSound: "ਐਮ · ਮੇਜ਼ੋਂ", iconName: "house.fill"),
        AlphabetItem(letter: "N", frenchWord: "Nuage", englishMeaning: "Cloud", phonetic: "enn · noo-azh", punjabiSound: "ਐਨ · ਨੂਆਜ਼", iconName: "cloud.fill"),
        AlphabetItem(letter: "O", frenchWord: "Oiseau", englishMeaning: "Bird", phonetic: "oh · wah-zoh", punjabiSound: "ਓ · ਵਾਜ਼ੋ", iconName: "bird.fill"),
        AlphabetItem(letter: "P", frenchWord: "Pomme", englishMeaning: "Apple", phonetic: "peh · puhm", punjabiSound: "ਪੇ · ਪੋਮ", iconName: "apple.logo"),
        AlphabetItem(letter: "Q", frenchWord: "Quatre", englishMeaning: "Four", phonetic: "koo · kah-trə", punjabiSound: "ਕੂ · ਕਾਤ੍ਰ", iconName: "4.square.fill"),
        AlphabetItem(letter: "R", frenchWord: "Soleil", englishMeaning: "Sun / Throat R", phonetic: "ehr · soh-lay", punjabiSound: "ਐਖ਼ · ਸੋਲੇ", iconName: "sun.max.fill"),
        AlphabetItem(letter: "S", frenchWord: "Soleil", englishMeaning: "Sun", phonetic: "ess · soh-lay", punjabiSound: "ਐਸ · ਸੋਲੇ", iconName: "sun.haze.fill"),
        AlphabetItem(letter: "T", frenchWord: "Train", englishMeaning: "Train", phonetic: "teh · trahn", punjabiSound: "ਤੇ · ਤ੍ਰਾਂ", iconName: "train.side.front.car"),
        AlphabetItem(letter: "U", frenchWord: "Usine", englishMeaning: "Factory / City", phonetic: "oo · oo-zeen", punjabiSound: "ਊ · ਊਜ਼ੀਨ", iconName: "building.2.fill"),
        AlphabetItem(letter: "V", frenchWord: "Voiture", englishMeaning: "Car", phonetic: "veh · vwah-toor", punjabiSound: "ਵੇ · ਵਵਾਤੂਖ਼", iconName: "car.fill"),
        AlphabetItem(letter: "W", frenchWord: "Wagon", englishMeaning: "Wagon / Train car", phonetic: "doo-bluh-veh · vah-gohn", punjabiSound: "ਦੂਬਲ-ਵੇ · ਵਾਗੋਂ", iconName: "box.truck.fill"),
        AlphabetItem(letter: "X", frenchWord: "Xylophone", englishMeaning: "Xylophone", phonetic: "eeks · ksee-loh-fuhn", punjabiSound: "ਈਕਸ · ਕਸੀਲੋਫੋਨ", iconName: "music.note"),
        AlphabetItem(letter: "Y", frenchWord: "Yaourt", englishMeaning: "Yogurt", phonetic: "ee-grehk · yah-oort", punjabiSound: "ਈ-ਗ੍ਰੇਕ · ਯਾਊਰਤ", iconName: "cup.and.saucer.fill"),
        AlphabetItem(letter: "Z", frenchWord: "Zèbre", englishMeaning: "Zebra", phonetic: "zehd · zeh-brə", punjabiSound: "ਜ਼ੈਡ · ਜ਼ੇਬ੍ਰ", iconName: "tortoise.fill")
    ]

    // MARK: - All 5 Section Groups with 22 Categories

    static let sections: [BasicsSectionGroup] = [
        // SECTION 1: Absolute Basics
        BasicsSectionGroup(
            title: "Section 1: The Absolute Basics",
            iconName: "star.leadinghalf.filled",
            categories: [
                BasicsCategory(
                    title: "Greetings & Magic Words",
                    iconName: "hand.wave.fill",
                    description: "Essential polite phrases for daily conversation.",
                    items: [
                        BasicsItem(french: "Bonjour", english: "Hello / Good morning", phonetic: "bon-zhoo-kh", punjabiSound: "ਬੋਂਜ਼ੂਖ਼", iconName: "sun.max.fill"),
                        BasicsItem(french: "Bonsoir", english: "Good evening", phonetic: "bon-swahr", punjabiSound: "ਬੋਂਸਵਾਖ਼", iconName: "moon.fill"),
                        BasicsItem(french: "Au revoir", english: "Goodbye", phonetic: "oh-khvahr", punjabiSound: "ਓ-ਖ਼ਵਾਖ਼", iconName: "hand.wave.fill"),
                        BasicsItem(french: "S'il vous plaît", english: "Please (formal)", phonetic: "seel-voo-pleh", punjabiSound: "ਸੀਲ-ਵੂ-ਪਲੇ", iconName: "heart.fill"),
                        BasicsItem(french: "Merci beaucoup", english: "Thank you very much", phonetic: "mair-see boh-koo", punjabiSound: "ਮੈਖ਼ਸੀ ਬੋਕੂ", iconName: "checkmark.circle.fill"),
                        BasicsItem(french: "De rien", english: "You're welcome", phonetic: "duh-ryen", punjabiSound: "ਦੁ-ਰਿਆਂ", iconName: "hand.thumbsup.fill"),
                        BasicsItem(french: "Pardon / Désolé", english: "Sorry / Excuse me", phonetic: "par-dohn / day-zoh-lay", punjabiSound: "ਪਾਰਦੋਂ / ਦੇਜ਼ੋਲੇ", iconName: "exclamationmark.circle.fill", spokenText: "Pardon, Désolé")
                    ]
                ),
                BasicsCategory(
                    title: "Numbers & Counting (1 to 100)",
                    iconName: "number.square.fill",
                    description: "Master counting from 1 to 100 and compound number rules.",
                    items: [
                        BasicsItem(french: "Un, Deux, Trois, Quatre, Cinq", english: "1, 2, 3, 4, 5", phonetic: "uhn, duh, trwah, katr, sank", punjabiSound: "ਅੰ, ਦੁ, ਤ੍ਰਵਾ, ਕਾਤ੍ਰ, ਸੈਂਕ", iconName: "1.square.fill"),
                        BasicsItem(french: "Six, Sept, Huit, Neuf, Dix", english: "6, 7, 8, 9, 10", phonetic: "sees, set, weet, nuhf, dees", punjabiSound: "ਸੀਸ, ਸੈਤ, ਵੀਤ, ਨੂਫ, ਦੀਸ", iconName: "6.square.fill"),
                        BasicsItem(french: "Onze, Douze, Treize, Quatorze, Quinze, Seize", english: "11 to 16", phonetic: "ohnz, dooz, trehz, kah-torz, kanz, sehz", punjabiSound: "ਓਂਜ਼, ਦੂਜ਼, ਤ੍ਰੈਜ਼, ਕਾਤੋਖ਼ਜ਼, ਕੈਂਜ਼, ਸੈਜ਼", iconName: "10.square.fill"),
                        BasicsItem(french: "Vingt, Trente, Quarante, Cinquante, Soixante", english: "20, 30, 40, 50, 60", phonetic: "vahn, trahnt, kah-rahnt, san-kahnt, swah-sahnt", punjabiSound: "ਵੇਂ, ਤ੍ਰਾਂਤ, ਕਾਰਾਂਤ, ਸੈਂਕਾਂਤ, ਸਵਾਸਾਂਤ", iconName: "chart.bar.fill"),
                        BasicsItem(french: "Soixante-dix (70)", english: "70 (60 + 10 = Soixante-dix)", phonetic: "swah-sahnt-dees", punjabiSound: "ਸਵਾਸਾਂਤ-ਦੀਸ", iconName: "plus.circle.fill", grammarNote: "70 in French is 60+10 (Soixante-dix), 71 is Soixante-et-onze!", spokenText: "Soixante-dix"),
                        BasicsItem(french: "Quatre-vingts (80)", english: "80 (4 × 20 = Quatre-vingts)", phonetic: "katr-vahn", punjabiSound: "ਕਾਤ੍ਰ-ਵੇਂ", iconName: "multiply.circle.fill", grammarNote: "80 in French is 4 times 20 (Quatre-vingts)!", spokenText: "Quatre-vingts"),
                        BasicsItem(french: "Quatre-vingt-dix (90)", english: "90 (4 × 20 + 10 = Quatre-vingt-dix)", phonetic: "katr-vahn-dees", punjabiSound: "ਕਾਤ੍ਰ-ਵੇਂ-ਦੀਸ", iconName: "function", grammarNote: "90 is (4×20)+10. 99 is Quatre-vingt-dix-neuf!", spokenText: "Quatre-vingt-dix"),
                        BasicsItem(french: "Cent", english: "100", phonetic: "sahn", punjabiSound: "ਸਾਂ", iconName: "100.square.fill")
                    ]
                ),
                BasicsCategory(
                    title: "Colors (Les Couleurs)",
                    iconName: "paintpalette.fill",
                    description: "Learn colors in French with visual indicators.",
                    items: [
                        BasicsItem(french: "Rouge", english: "Red", phonetic: "roozh", punjabiSound: "ਰੂਜ਼", iconName: "paintpalette.fill"),
                        BasicsItem(french: "Bleu", english: "Blue", phonetic: "bluh", punjabiSound: "ਬਲੂ", iconName: "paintpalette.fill"),
                        BasicsItem(french: "Vert", english: "Green", phonetic: "vair", punjabiSound: "ਵੇਖ਼", iconName: "paintpalette.fill"),
                        BasicsItem(french: "Jaune", english: "Yellow", phonetic: "zhohn", punjabiSound: "ਜ਼ੋਨ", iconName: "paintpalette.fill"),
                        BasicsItem(french: "Blanc", english: "White", phonetic: "blahn", punjabiSound: "ਬਲਾਂ", iconName: "paintpalette.fill"),
                        BasicsItem(french: "Noir", english: "Black", phonetic: "nwahr", punjabiSound: "ਨਵਾਖ਼", iconName: "paintpalette.fill"),
                        BasicsItem(french: "Orange / Rose", english: "Orange / Pink", phonetic: "oh-rahnzh / rohz", punjabiSound: "ਓਰਾਂਜ਼ / ਰੋਜ਼", iconName: "paintpalette.fill", spokenText: "Orange, Rose")
                    ]
                ),
                BasicsCategory(
                    title: "Shapes (Les Formes)",
                    iconName: "square.on.circle.fill",
                    description: "Geometric shapes and forms.",
                    items: [
                        BasicsItem(french: "Le Cercle", english: "Circle", phonetic: "luh sair-klə", punjabiSound: "ਲੁ ਸੈਰਕਲ", iconName: "circle.fill"),
                        BasicsItem(french: "Le Carré", english: "Square", phonetic: "luh kah-ray", punjabiSound: "ਲੁ ਕਾਰੇ", iconName: "square.fill"),
                        BasicsItem(french: "Le Triangle", english: "Triangle", phonetic: "luh treh-ahn-glə", punjabiSound: "ਲੁ ਤ੍ਰਿਆਂਗਲ", iconName: "triangle.fill"),
                        BasicsItem(french: "L'Étoile", english: "Star", phonetic: "lay-twahl", punjabiSound: "ਲੇਤਵਾਲ", iconName: "star.fill"),
                        BasicsItem(french: "Le Rectangle", english: "Rectangle", phonetic: "luh khayk-tahn-glə", punjabiSound: "ਲੁ ਰੇਕਤਾਂਗਲ", iconName: "rectangle.fill")
                    ]
                )
            ]
        ),

        // SECTION 2: Me and My Family
        BasicsSectionGroup(
            title: "Section 2: Me and My Family",
            iconName: "person.2.fill",
            categories: [
                BasicsCategory(
                    title: "Parts of the Body",
                    iconName: "figure.walk",
                    description: "Human body parts in French.",
                    items: [
                        BasicsItem(french: "La Tête", english: "Head", phonetic: "lah teht", punjabiSound: "ਲਾ ਤੇਤ", iconName: "face.smiling"),
                        BasicsItem(french: "Les Épaules", english: "Shoulders", phonetic: "leh-zay-pohl", punjabiSound: "ਲੇਜ਼ੇਪੋਲ", iconName: "figure.arms.open"),
                        BasicsItem(french: "Les Yeux", english: "Eyes", phonetic: "leh-zyuh", punjabiSound: "ਲੇਜ਼ੂ", iconName: "eye.fill"),
                        BasicsItem(french: "Les Oreilles", english: "Ears", phonetic: "leh-zoh-ray-yə", punjabiSound: "ਲੇਜ਼ੋਰੇਯ", iconName: "ear.fill"),
                        BasicsItem(french: "Les Mains", english: "Hands", phonetic: "leh mahn", punjabiSound: "ਲੇ ਮੈਂ", iconName: "hand.raised.fill"),
                        BasicsItem(french: "Les Pieds", english: "Feet", phonetic: "leh pyay", punjabiSound: "ਲੇ ਪਿਏ", iconName: "shoeprints.fill")
                    ]
                ),
                BasicsCategory(
                    title: "Family Members",
                    iconName: "house.circle.fill",
                    description: "Parents, siblings, and relatives.",
                    items: [
                        BasicsItem(french: "La Mère (Maman)", english: "Mother (Mom)", phonetic: "lah mair-kh", punjabiSound: "ਲਾ ਮੇਖ਼ (ਮਾਮਾਂ)", iconName: "heart.circle.fill", spokenText: "La Mère, Maman"),
                        BasicsItem(french: "Le Père (Papa)", english: "Father (Dad)", phonetic: "luh pair-kh", punjabiSound: "ਲੁ ਪੇਖ਼ (ਪਾਪਾ)", iconName: "person.crop.circle.fill", spokenText: "Le Père, Papa"),
                        BasicsItem(french: "Le Frère", english: "Brother", phonetic: "luh frehr", punjabiSound: "ਲੁ ਫ੍ਰੇਖ਼", iconName: "person.fill"),
                        BasicsItem(french: "La Sœur", english: "Sister", phonetic: "lah suhr", punjabiSound: "ਲਾ ਸੂਖ਼", iconName: "person.fill"),
                        BasicsItem(french: "Le Grand-père", english: "Grandfather", phonetic: "luh grahn-pair-kh", punjabiSound: "ਲੁ ਗ੍ਰਾਂ-ਪੇਖ਼", iconName: "person.crop.square.fill"),
                        BasicsItem(french: "La Grand-mère", english: "Grandmother", phonetic: "lah grahn-mair-kh", punjabiSound: "ਲਾ ਗ੍ਰਾਂ-ਮੇਖ਼", iconName: "person.crop.square.fill")
                    ]
                ),
                BasicsCategory(
                    title: "Feelings & Emotions",
                    iconName: "smiley.fill",
                    description: "Express how you feel.",
                    items: [
                        BasicsItem(french: "Je suis heureux / heureuse", english: "I am happy", phonetic: "zhuh swee uh-ruh", punjabiSound: "ਜ਼ੁ ਸੁਈ ਊਰੂ", iconName: "face.smiling.fill", spokenText: "Je suis heureux, heureuse"),
                        BasicsItem(french: "Je suis triste", english: "I am sad", phonetic: "zhuh swee treest", punjabiSound: "ਜ਼ੁ ਸੁਈ ਤ੍ਰੀਸਤ", iconName: "cloud.rain.fill"),
                        BasicsItem(french: "Je suis fatigué(e)", english: "I am tired", phonetic: "zhuh swee fah-tee-gay", punjabiSound: "ਜ਼ੁ ਸੁਈ ਫਾਤੀਗੇ", iconName: "bed.double.fill", spokenText: "Je suis fatigué"),
                        BasicsItem(french: "J'ai faim", english: "I am hungry (I have hunger)", phonetic: "zhay fahn", punjabiSound: "ਜ਼ੇ ਫੈਂ", iconName: "fork.knife"),
                        BasicsItem(french: "J'ai soif", english: "I am thirsty (I have thirst)", phonetic: "zhay swahf", punjabiSound: "ਜ਼ੇ ਸਵਾਫ", iconName: "cup.and.saucer.fill")
                    ]
                ),
                BasicsCategory(
                    title: "Personal Stuff & Clothing",
                    iconName: "tshirt.fill",
                    description: "Everyday clothes and grooming items.",
                    items: [
                        BasicsItem(french: "Le Peigne", english: "Comb", phonetic: "luh pehn-yə", punjabiSound: "ਲੁ ਪੇਨਯ", iconName: "comb.fill"),
                        BasicsItem(french: "L'Huile pour cheveux", english: "Hair oil", phonetic: "lweel poor shuh-vuh", punjabiSound: "ਲੁਈਲ ਪੂਖ਼ ਸ਼ੁਵੂ", iconName: "drop.fill"),
                        BasicsItem(french: "Le Sèche-cheveux", english: "Hair dryer", phonetic: "luh sehsh-shuh-vuh", punjabiSound: "ਲੁ ਸੈਸ਼-ਸ਼ੁਵੂ", iconName: "wind"),
                        BasicsItem(french: "Le T-shirt", english: "T-shirt", phonetic: "luh tee-shurt", punjabiSound: "ਲੁ ਟੀ-ਸ਼ਰਟ", iconName: "tshirt.fill"),
                        BasicsItem(french: "Les Chaussures", english: "Shoes", phonetic: "leh shoh-soor", punjabiSound: "ਲੇ ਸ਼ੋਸੂਖ਼", iconName: "shoe.fill"),
                        BasicsItem(french: "Le Pyjama", english: "Pajamas", phonetic: "luh pee-zhah-mah", punjabiSound: "ਲੁ ਪੀਜ਼ਾਮਾ", iconName: "bed.double.fill"),
                        BasicsItem(french: "Les Sous-vêtements", english: "Underwear", phonetic: "leh soo-veh-tmah", punjabiSound: "ਲੇ ਸੂ-ਵੇਤਮਾਂ", iconName: "square.dashed")
                    ]
                )
            ]
        ),

        // SECTION 3: Time and Nature
        BasicsSectionGroup(
            title: "Section 3: Time and Nature",
            iconName: "clock.fill",
            categories: [
                BasicsCategory(
                    title: "Days of the Week",
                    iconName: "calendar",
                    description: "The 7 days of the week in French.",
                    items: [
                        BasicsItem(french: "Lundi", english: "Monday", phonetic: "luhn-dee", punjabiSound: "ਲੰਦੀ", iconName: "calendar.day.timeline.left"),
                        BasicsItem(french: "Mardi", english: "Tuesday", phonetic: "mar-dee", punjabiSound: "ਮਾਰਦੀ", iconName: "calendar"),
                        BasicsItem(french: "Mercredi", english: "Wednesday", phonetic: "mair-kruh-dee", punjabiSound: "ਮੈਖ਼ਕ੍ਰੁਦੀ", iconName: "calendar"),
                        BasicsItem(french: "Jeudi", english: "Thursday", phonetic: "zhuh-dee", punjabiSound: "ਜ਼ੁਦੀ", iconName: "calendar"),
                        BasicsItem(french: "Vendredi", english: "Friday", phonetic: "vahn-druh-dee", punjabiSound: "ਵਾਂਦ੍ਰੁਦੀ", iconName: "calendar"),
                        BasicsItem(french: "Samedi", english: "Saturday", phonetic: "sahm-dee", punjabiSound: "ਸਾਮਦੀ", iconName: "calendar"),
                        BasicsItem(french: "Dimanche", english: "Sunday", phonetic: "dee-mahnsh", punjabiSound: "ਦੀਮਾਂਸ਼", iconName: "sun.max.fill")
                    ]
                ),
                BasicsCategory(
                    title: "Months of the Year",
                    iconName: "calendar.badge.clock",
                    description: "The 12 months in French.",
                    items: [
                        BasicsItem(french: "Janvier, Février, Mars, Avril", english: "Jan, Feb, Mar, Apr", phonetic: "zhahn-vyay, fay-vryay, marz, ah-vreel", punjabiSound: "ਜ਼ਾਂਵੀਏ, ਫੇਵਰੀਏ, ਮਾਰਸ, ਆਵਰੀਲ", iconName: "snowflake"),
                        BasicsItem(french: "Mai, Juin, Juillet, Août", english: "May, June, July, Aug", phonetic: "meh, zhwahn, zhwee-yeh, oot", punjabiSound: "ਮੇ, ਜ਼ਵਾਂ, ਜ਼ੁਈਏ, ਊਤ", iconName: "sun.max.fill"),
                        BasicsItem(french: "Septembre, Octobre, Novembre, Décembre", english: "Sep, Oct, Nov, Dec", phonetic: "sep-tahm-brə, ok-toh-brə, noh-vahm-brə, day-sahm-brə", punjabiSound: "ਸੈਪਤਾਂਬ੍ਰ, ਓਕਤੋਬ੍ਰ, ਨੋਵਾਂਬ੍ਰ, ਦੇਸਾਂਬ੍ਰ", iconName: "leaf.fill")
                    ]
                ),
                BasicsCategory(
                    title: "Seasons & Weather",
                    iconName: "cloud.sun.fill",
                    description: "Talk about weather and four seasons.",
                    items: [
                        BasicsItem(french: "L'Été", english: "Summer", phonetic: "lay-tay", punjabiSound: "ਲੇਤੇ", iconName: "sun.max.fill"),
                        BasicsItem(french: "L'Hiver", english: "Winter", phonetic: "lee-vair", punjabiSound: "ਲੀਵੇਖ਼", iconName: "snowflake"),
                        BasicsItem(french: "L'Automne", english: "Autumn / Fall", phonetic: "loh-tuhn", punjabiSound: "ਲੋਤਨ", iconName: "leaf.fill"),
                        BasicsItem(french: "Le Printemps", english: "Spring", phonetic: "luh prahn-tahn", punjabiSound: "ਲੁ ਪ੍ਰਾਂਤਾਂ", iconName: "camera.macro"),
                        BasicsItem(french: "Il fait beau", english: "The weather is nice", phonetic: "eel feh boh", punjabiSound: "ਈਲ ਫੇ ਬੋ", iconName: "sun.max.fill"),
                        BasicsItem(french: "Il pleut", english: "It is raining", phonetic: "eel pluh", punjabiSound: "ਈਲ ਪਲੂ", iconName: "cloud.rain.fill")
                    ]
                ),
                BasicsCategory(
                    title: "Telling Time (Clock Guide)",
                    iconName: "clock.badge.checkmark",
                    description: "Learn how to ask and tell time in French.",
                    items: [
                        BasicsItem(french: "Quelle heure est-il ?", english: "What time is it?", phonetic: "kel uhr eh-teel", punjabiSound: "ਕੈਲ ਊਖ਼ ਐ-ਤੀਲ", iconName: "questionmark.circle.fill"),
                        BasicsItem(french: "Il est huit heures (8h00)", english: "It is 8 o'clock", phonetic: "eel eh weet uhr", punjabiSound: "ਈਲ ਐ ਵੀਤ ਊਖ਼", iconName: "clock.fill", spokenText: "Il est huit heures"),
                        BasicsItem(french: "Il est huit heures et quart (8h15)", english: "It is 8:15 (quarter past 8)", phonetic: "eel eh weet uhr ay kar", punjabiSound: "ਈਲ ਐ ਵੀਤ ਊਖ਼ ਏ ਕਾਰ", iconName: "clock.fill", spokenText: "Il est huit heures et quart"),
                        BasicsItem(french: "Il est huit heures et demie (8h30)", english: "It is 8:30 (half past 8)", phonetic: "eel eh weet uhr ay duh-mee", punjabiSound: "ਈਲ ਐ ਵੀਤ ਊਖ਼ ਏ ਦੁਮੀ", iconName: "clock.fill", spokenText: "Il est huit heures et demie"),
                        BasicsItem(french: "Il est neuf heures moins le quart (8h45)", english: "It is 8:45 (quarter to 9)", phonetic: "eel eh nuhf uhr mwahn luh kar", punjabiSound: "ਈਲ ਐ ਨੂਫ ਊਖ਼ ਮਵਾਂ ਲੁ ਕਾਰ", iconName: "clock.fill", spokenText: "Il est neuf heures moins le quart")
                    ]
                ),
                BasicsCategory(
                    title: "The Date (La Date)",
                    iconName: "calendar.badge.plus",
                    description: "How to say and write today's date.",
                    items: [
                        BasicsItem(french: "Aujourd'hui, c'est...", english: "Today is...", phonetic: "oh-zhoor-dwee seh", punjabiSound: "ਓਜ਼ੂਖ਼ਦੁਈ ਸੈ", iconName: "sun.max.fill"),
                        BasicsItem(french: "Quel jour sommes-nous ?", english: "What day are we today?", phonetic: "kel zhoor suhm-noo", punjabiSound: "ਕੈਲ ਜ਼ੂਖ਼ ਸੁਮ-ਨੂ", iconName: "questionmark.circle.fill"),
                        BasicsItem(french: "C'est le 15 août", english: "It is August 15th (Date format: Le + Number + Month)", phonetic: "seh luh kanz oot", punjabiSound: "ਸੈ ਲੁ ਕੈਂਜ਼ ਊਤ", iconName: "calendar.circle.fill", grammarNote: "In French dates, always write 'Le' + Number + Month (e.g. Le 15 août). First day is 'Le premier'!")
                    ]
                ),
                BasicsCategory(
                    title: "Nature & Sky",
                    iconName: "leaf.circle.fill",
                    description: "Sun, moon, stars, trees and flowers.",
                    items: [
                        BasicsItem(french: "Le Soleil", english: "Sun", phonetic: "luh soh-lay", punjabiSound: "ਲੁ ਸੋਲੇ", iconName: "sun.max.fill"),
                        BasicsItem(french: "La Lune", english: "Moon", phonetic: "lah loon", punjabiSound: "ਲਾ ਲੂਨ", iconName: "moon.fill"),
                        BasicsItem(french: "Les Étoiles", english: "Stars", phonetic: "leh-zay-twahl", punjabiSound: "ਲੇਜ਼ੇਤਵਾਲ", iconName: "sparkles"),
                        BasicsItem(french: "L'Arbre", english: "Tree", phonetic: "lahr-brə", punjabiSound: "ਲਾਰਬ੍ਰ", iconName: "tree.fill"),
                        BasicsItem(french: "La Fleur", english: "Flower", phonetic: "lah fluhr", punjabiSound: "ਲਾ ਫਲੂਖ਼", iconName: "camera.macro")
                    ]
                )
            ]
        ),

        // SECTION 4: My Home and School
        BasicsSectionGroup(
            title: "Section 4: My Home and School",
            iconName: "building.2.fill",
            categories: [
                BasicsCategory(
                    title: "My Room & Furniture",
                    iconName: "bed.double.fill",
                    description: "Furniture and room essentials.",
                    items: [
                        BasicsItem(french: "Le Lit", english: "Bed", phonetic: "luh lee", punjabiSound: "ਲੁ ਲੀ", iconName: "bed.double.fill"),
                        BasicsItem(french: "La Chaise", english: "Chair", phonetic: "lah shehz", punjabiSound: "ਲਾ ਸ਼ੈਜ਼", iconName: "chair.fill"),
                        BasicsItem(french: "La Table", english: "Table", phonetic: "lah tah-blə", punjabiSound: "ਲਾ ਤਾਬਲ", iconName: "table.furniture.fill"),
                        BasicsItem(french: "L'Armoire", english: "Wardrobe / Almirah", phonetic: "lar-mwahr", punjabiSound: "ਲਾਰਮਵਾਖ਼", iconName: "square.split.2x2.fill"),
                        BasicsItem(french: "La Coiffeuse", english: "Dressing table", phonetic: "lah kwah-fuhz", punjabiSound: "ਲਾ ਕਵਾਫੂਜ਼", iconName: "sparkles")
                    ]
                ),
                BasicsCategory(
                    title: "School Supplies",
                    iconName: "book.fill",
                    description: "Stationery and school items.",
                    items: [
                        BasicsItem(french: "Le Sac à dos", english: "Backpack / School bag", phonetic: "luh sahk ah doh", punjabiSound: "ਲੁ ਸਾਕ ਆ ਦੋ", iconName: "bag.fill"),
                        BasicsItem(french: "Le Crayon", english: "Pencil", phonetic: "luh kreh-yohn", punjabiSound: "ਲੁ ਕ੍ਰੇਯੋਂ", iconName: "pencil"),
                        BasicsItem(french: "Les Livres", english: "Books", phonetic: "leh leev-khə", punjabiSound: "ਲੇ ਲੀਵਖ਼", iconName: "books.vertical.fill"),
                        BasicsItem(french: "La Gomme", english: "Eraser", phonetic: "lah guhm", punjabiSound: "ਲਾ ਗੋਮ", iconName: "eraser.fill")
                    ]
                )
            ]
        ),

        // SECTION 5: Food and World
        BasicsSectionGroup(
            title: "Section 5: Food and World",
            iconName: "fork.knife",
            categories: [
                BasicsCategory(
                    title: "Kitchen Stuff & Tableware",
                    iconName: "cup.and.saucer.fill",
                    description: "Plates, spoons, glasses, and utensils.",
                    items: [
                        BasicsItem(french: "L'Assiette", english: "Plate", phonetic: "lah-syeht", punjabiSound: "ਲਾਸਿਏਤ", iconName: "circle.fill"),
                        BasicsItem(french: "La Cuillère", english: "Spoon", phonetic: "lah kwee-yair", punjabiSound: "ਲਾ ਕਵੀਏਖ਼", iconName: "fork.knife"),
                        BasicsItem(french: "La Fourchette", english: "Fork", phonetic: "lah foor-sheht", punjabiSound: "ਲਾ ਫੂਰਸ਼ੈਤ", iconName: "fork.knife"),
                        BasicsItem(french: "Le Verre", english: "Glass", phonetic: "luh vair", punjabiSound: "ਲੁ ਵੇਖ਼", iconName: "glass.inset.filled"),
                        BasicsItem(french: "Le Bol", english: "Bowl", phonetic: "luh buhl", punjabiSound: "ਲੁ ਬੋਲ", iconName: "circle.circle.fill")
                    ]
                ),
                BasicsCategory(
                    title: "Fruits",
                    iconName: "apple.logo",
                    description: "Popular delicious fruits.",
                    items: [
                        BasicsItem(french: "La Pomme", english: "Apple", phonetic: "lah puhm", punjabiSound: "ਲਾ ਪੋਮ", iconName: "apple.logo"),
                        BasicsItem(french: "La Banane", english: "Banana", phonetic: "lah bah-nahn", punjabiSound: "ਲਾ ਬਾਨਾਨ", iconName: "leaf.fill"),
                        BasicsItem(french: "L'Orange", english: "Orange", phonetic: "loh-rahnzh", punjabiSound: "ਲੋਰਾਂਜ਼", iconName: "sun.max.fill"),
                        BasicsItem(french: "Le Raisin", english: "Grapes", phonetic: "luh khay-zahn", punjabiSound: "ਲੁ ਰੇਜ਼ਾਂ", iconName: "circle.hexagonpath.fill")
                    ]
                ),
                BasicsCategory(
                    title: "Vegetables",
                    iconName: "carrot.fill",
                    description: "Common vegetables.",
                    items: [
                        BasicsItem(french: "La Pomme de terre", english: "Potato", phonetic: "lah puhm duh tair", punjabiSound: "ਲਾ ਪੋਮ ਦੁ ਤੈਖ਼", iconName: "circle.fill"),
                        BasicsItem(french: "La Tomate", english: "Tomato", phonetic: "lah toh-maht", punjabiSound: "ਲਾ ਤੋਮਾਤ", iconName: "circle.fill"),
                        BasicsItem(french: "L'Oignon", english: "Onion", phonetic: "lohn-yohn", punjabiSound: "ਲੋਨਯੋਂ", iconName: "circle.grid.cross.fill"),
                        BasicsItem(french: "Les Carottes", english: "Carrots", phonetic: "leh kah-kht", punjabiSound: "ਲੇ ਕਾਖ਼ੋਤ", iconName: "carrot.fill")
                    ]
                ),
                BasicsCategory(
                    title: "Animals",
                    iconName: "pawprint.fill",
                    description: "Domestic and wild animals.",
                    items: [
                        BasicsItem(french: "Le Chien", english: "Dog", phonetic: "luh shyen", punjabiSound: "ਲੁ ਸ਼ਿਆਂ", iconName: "dog.fill"),
                        BasicsItem(french: "Le Chat", english: "Cat", phonetic: "luh shah", punjabiSound: "ਲੁ ਸ਼ਾ", iconName: "cat.fill"),
                        BasicsItem(french: "Le Lion", english: "Lion", phonetic: "luh lee-ohn", punjabiSound: "ਲੁ ਲੀਓਂ", iconName: "pawprint.fill"),
                        BasicsItem(french: "L'Éléphant", english: "Elephant", phonetic: "lay-lay-fahn", punjabiSound: "ਲੇਲੇਫਾਂ", iconName: "circle.grid.cross.fill"),
                        BasicsItem(french: "La Vache", english: "Cow", phonetic: "lah vahsh", punjabiSound: "ਲਾ ਵਾਸ਼", iconName: "pawprint.fill")
                    ]
                ),
                BasicsCategory(
                    title: "Transport",
                    iconName: "car.fill",
                    description: "Vehicles and transport modes.",
                    items: [
                        BasicsItem(french: "La Voiture", english: "Car", phonetic: "lah vwah-toor", punjabiSound: "ਲਾ ਵਵਾਤੂਖ਼", iconName: "car.fill"),
                        BasicsItem(french: "Le Bus", english: "Bus", phonetic: "luh boos", punjabiSound: "ਲੁ ਬੂਸ", iconName: "bus.fill"),
                        BasicsItem(french: "Le Vélo", english: "Bicycle", phonetic: "luh vay-loh", punjabiSound: "ਲੁ ਵੇਲੋ", iconName: "bicycle"),
                        BasicsItem(french: "L'Avion", english: "Airplane", phonetic: "lah-vyohn", punjabiSound: "ਲਾਵੀਓਂ", iconName: "airplane")
                    ]
                )
            ]
        )
    ]
}
