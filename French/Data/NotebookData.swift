import Foundation

enum NotebookData {

    // MARK: - 1. Accents & French Sound Hacks
    static let accentsSection = NotebookSection(
        title: "Accents & French Sound Hacks",
        iconName: "textformat",
        description: "Master French accents and the famous throat 'R' (ਖ਼) sound.",
        items: [
            NotebookItem(
                french: "The French Guttural 'R' Sound (ਖ਼)",
                english: "French R is NEVER rolling Punjabi 'ਰ'. It is a throat sound like Punjabi 'ਖ਼' (e.g. Bonjour = Bon-zhoo-kh, Merci = Mair-khee)",
                phonetic: "Bon-zhoo-kh · ਬੋਂਜ਼ੂਖ਼ / ਮੈਖ਼ਸੀ",
                grammarNote: "CRITICAL: Produce the 'R' sound from the back of your throat like Punjabi 'ਖ਼' / 'ਖ਼', not tongue 'ਰ'.",
                audioText: "Bonjour, merci, parler, mère"
            ),
            NotebookItem(
                french: "é (Accent Aigu)",
                english: "Sounds like 'ay' in 'day' (e.g., une école = a school)",
                phonetic: "ay-koll · ਏਕੋਲ",
                grammarNote: "Hack: Only appears on the letter E. Always pronounced like 'ay'.",
                audioText: "une école"
            ),
            NotebookItem(
                french: "è / ê (Accent Grave & Circonflexe)",
                english: "Sounds like 'eh' in 'bed' (e.g., la mère = mother, la fête = party)",
                phonetic: "lah mair-kh · ਲਾ ਮੇਖ਼",
                grammarNote: "Hack: Opens up the sound to a relaxed 'eh' with throat 'ਖ਼' ending.",
                audioText: "la mère, la fête"
            ),
            NotebookItem(
                french: "ç (C-cédilla)",
                english: "Forces a soft 'S' sound before a, o, u (e.g., garçon = boy)",
                phonetic: "ga-kh-sohn · ਗਾਖ਼ਸੋਂ",
                grammarNote: "Hack: Without the tail, 'garcon' would sound like 'garkon'. The ç makes it S.",
                audioText: "garçon"
            ),
            NotebookItem(
                french: "à / où (Accent Grave on A & U)",
                english: "Does not change pronunciation, only changes meaning (à = at/to, où = where)",
                phonetic: "ah / oo · ਆ / ਊ",
                grammarNote: "Hack: Distinguishes 'ou' (or) from 'où' (where) and 'a' (has) from 'à' (at/to).",
                audioText: "à, où"
            )
        ]
    )

    // MARK: - 2. Gender Shortcuts & Noun Hacks
    static let genderHacksSection = NotebookSection(
        title: "Gender Shortcuts & Noun Hacks",
        iconName: "sparkles",
        description: "Easy tricks to guess Masculine vs Feminine nouns without memorizing everything.",
        items: [
            NotebookItem(
                french: "Feminine Endings: -tion, -té, -ette, -ence",
                english: "Nouns with these endings are almost ALWAYS Feminine (la nation, la santé, la serviette)",
                phonetic: "lah nah-syohn · ਲਾ ਨਾਸਿਓਂ",
                grammarNote: "Hack: Use 'la' or 'une' for words ending in -tion, -té, -ette.",
                audioText: "la nation, la santé, la serviette"
            ),
            NotebookItem(
                french: "Masculine Endings: -ment, -eau, -age, -isme",
                english: "Nouns with these endings are almost ALWAYS Masculine (le gouvernement, le bateau, le fromage)",
                phonetic: "luh bah-toh · ਲੁ ਬਾਤੋ",
                grammarNote: "Hack: Use 'le' or 'un' for words ending in -ment, -eau, -age.",
                audioText: "le gouvernement, le bateau, le fromage"
            ),
            NotebookItem(
                french: "The 'E' Rule Trick",
                english: "Words ending in -e are usually feminine, BUT major exceptions are le livre (book) & le musée (museum).",
                phonetic: "luh leev-khə · ਲੁ ਲੀਵਖ਼",
                grammarNote: "Hack: Always memorize new nouns together with their article (le/la).",
                audioText: "le livre, le musée"
            )
        ]
    )

    // MARK: - 3. 500+ Word Cognate Hacks (English <-> French)
    static let cognatesSection = NotebookSection(
        title: "500+ Word Cognate Hacks",
        iconName: "arrow.triangle.2.circlepath",
        description: "Instant vocabulary tricks for English & Punjabi speakers.",
        items: [
            NotebookItem(
                french: "-tion → -tion (Identical!)",
                english: "nation, attention, action, station (Same spelling, French accent!)",
                phonetic: "nah-syohn · ਨਾਸਿਓਂ",
                grammarNote: "Hack: 100+ English words ending in -tion are identical in French.",
                audioText: "nation, attention, action"
            ),
            NotebookItem(
                french: "-or → -eur",
                english: "doctor → docteur, actor → acteur, tutor → tuteur",
                phonetic: "dawk-tuh-kh · ਦੌਕਤੇਖ਼",
                grammarNote: "Hack: Change English '-or' to '-eur' with throat 'ਖ਼' sound.",
                audioText: "docteur, acteur, tuteur"
            ),
            NotebookItem(
                french: "-ty → -té",
                english: "university → université, society → société, liberty → liberté",
                phonetic: "oo-nee-vair-see-tay · ਊਨੀਵੇਖ਼ਸੀਤੇ",
                grammarNote: "Hack: Change English '-ty' to '-té'.",
                audioText: "université, société, liberté"
            ),
            NotebookItem(
                french: "-ic → -ique",
                english: "music → musique, logic → logique, classic → classique",
                phonetic: "moo-zeek · ਮੂਜ਼ੀਕ",
                grammarNote: "Hack: Change English '-ic' to '-ique'.",
                audioText: "musique, logique, classique"
            ),
            NotebookItem(
                french: "-ous → -eux",
                english: "famous → fameux, dangerous → dangereux, curious → curieux",
                phonetic: "fah-muh · ਫਾਮੂ",
                grammarNote: "Hack: Change English '-ous' to '-eux'.",
                audioText: "fameux, dangereux, curieux"
            ),
            NotebookItem(
                french: "-able → -able (Identical!)",
                english: "comfortable → confortable, adorable → adorable",
                phonetic: "kohn-for-tah-blə · ਕੋਂਫੋਖ਼ਤਾਬਲ",
                grammarNote: "Hack: Adjectives ending in -able are identical.",
                audioText: "confortable, adorable"
            )
        ]
    )

    // MARK: - 4. Silent Letters & Pronunciation Rules
    static let silentLettersSection = NotebookSection(
        title: "Silent Letters & Pronunciation Rules",
        iconName: "waveform",
        description: "The DEPSTX rule and smooth French Liaison.",
        items: [
            NotebookItem(
                french: "The DEPSTX Rule (Silent Final Consonants)",
                english: "Final D, E, P, S, T, X are usually SILENT at the end of words (e.g. petit = puh-tee, grand = grahn)",
                phonetic: "puh-tee / grahn · ਪਤੀ / ਗ੍ਰਾਂ",
                grammarNote: "Hack: Don't pronounce the last consonant unless followed by a vowel!",
                audioText: "petit, grand"
            ),
            NotebookItem(
                french: "Liaison (Linking Sounds)",
                english: "When a silent final consonant meets a vowel next, it wakes up! (les amis = leh-zah-mee)",
                phonetic: "leh-zah-mee · ਲੇ-ਜ਼ਾ-ਮੀ",
                grammarNote: "Hack: The silent 's' in 'les' becomes a smooth 'Z' sound before 'amis'.",
                audioText: "les amis"
            ),
            NotebookItem(
                french: "eau / au sound = 'O'",
                english: "eau (water) and bateau (boat) make a clean English 'O' sound.",
                phonetic: "oh / bah-toh · ਓ / ਬਾਤੋ",
                grammarNote: "Hack: Whenever you see eau or au, say 'oh'.",
                audioText: "eau, bateau"
            )
        ]
    )

    // MARK: - 5. Essential Articles & Possessives
    static let articlesSection = NotebookSection(
        title: "Articles & Possessive Adjectives",
        iconName: "doc.text.fill",
        description: "Definite (le/la/les), Indefinite (un/une/des) and Possessives (mon/ma/mes).",
        items: [
            NotebookItem(
                french: "Le livre / La chaise / L'école / Les étudiants",
                english: "The book (masc) / The chair (fem) / The school (vowel) / The students (plural)",
                phonetic: "luh leev-khə / lah shehz / leh-koll · ਲੁ ਲੀਵਖ਼ / ਲਾ ਸ਼ੇਜ਼",
                grammarNote: "Definite articles (The): Le, La, L', Les.",
                audioText: "le livre, la chaise, l'école, les étudiants"
            ),
            NotebookItem(
                french: "Un cahier / Une trousse / Des stylos",
                english: "A notebook (masc) / A pencil case (fem) / Some pens (plural)",
                phonetic: "un kay-yay / oon trooss / day stee-loh · ਐਨ ਕਾਹੀਏ / ਊਨ ਤ੍ਰੂਸ",
                grammarNote: "Indefinite articles (A/Some): Un, Une, Des.",
                audioText: "un cahier, une trousse, des stylos"
            ),
            NotebookItem(
                french: "Mon père / Ma mère / Mes amis",
                english: "My father / My mother / My friends",
                phonetic: "mohn pair-kh / mah mair-kh / may-zah-mee · ਮੋਂ ਪੇਖ਼ / ਮਾ ਮੇਖ਼",
                grammarNote: "Possessives (My): Mon (masc), Ma (fem), Mes (plural).",
                audioText: "mon père, ma mère, mes amis"
            ),
            NotebookItem(
                french: "Ton cahier / Ta voiture / Tes livres",
                english: "Your notebook / Your car / Your books (informal)",
                phonetic: "tohn kay-yay / tah vwah-too-kh / tay leev-khə · ਤੋਂ ਕਾਹੀਏ / ਤਾ ਵੋਆਤੂਖ਼",
                grammarNote: "Possessives (Your): Ton, Ta, Tes.",
                audioText: "ton cahier, ta voiture, tes livres"
            )
        ]
    )

    // MARK: - 6. Core Verb Conjugation Hacks
    static let verbsSection = NotebookSection(
        title: "Core Verb Conjugations",
        iconName: "character.book.closed.fill",
        description: "Être (to be), Avoir (to have), Aller (to go), Faire (to do) & Regular -ER pattern.",
        items: [
            NotebookItem(
                french: "Être (To be): suis, es, est, sommes, êtes, sont",
                english: "Je suis (I am), Tu es (You are), Il est (He is), Nous sommes (We are)",
                phonetic: "Zhuh swee / Too eh / Eel eh / Nooz soh-m · ਯ਼ੂ ਸ੍ਵੀ / ਤੂ ਏ / ਈਲ ਏ",
                grammarNote: "Hack: 'is/am/are' are all forms of ONE verb (Être).",
                audioText: "je suis, tu es, il est, nous sommes, vous êtes, ils sont"
            ),
            NotebookItem(
                french: "Avoir (To have): ai, as, a, avons, avez, ont",
                english: "J'ai (I have), Tu as (You have), Il a (He has), Nous avons (We have)",
                phonetic: "Zhay / Too ah / Eel ah / Nooz ah-vohn · ਯ਼ੇ / ਤੂ ਆ / ਈਲ ਆ",
                grammarNote: "Hack: In French, age uses Avoir (e.g. J'ai 29 ans = I have 29 years).",
                audioText: "j'ai, tu as, il a, nous avons, vous avez, ils ont"
            ),
            NotebookItem(
                french: "Aller (To go): vais, vas, va, allons, allez, vont",
                english: "Je vais (I go/am going), Nous allons au cinéma (We are going to the cinema)",
                phonetic: "Zhuh vay / Nooz ah-lohn oh see-nay-mah · ਯ਼ ਵੇ / ਨੂਜ਼ ਆਲੋਂ",
                grammarNote: "Hack: Je vais + Infinitive = Near Future (e.g. Je vais manger = I am going to eat).",
                audioText: "je vais, tu vas, il va, nous allons, vous allez, ils vont"
            ),
            NotebookItem(
                french: "Faire (To do / make): fais, fais, fait, faisons, faites, font",
                english: "Je fais (I do/make), Tu fais (You do), Il fait (He does), Nous faisons (We do)",
                phonetic: "Zhuh fay / Too fay / Eel fay / Noo fuh-zohn · ਯ਼ ਫੇ / ਤੂ ਫੇ / ਈਲ ਫੇ",
                grammarNote: "Hack: Used for daily activities & weather (e.g. Il fait beau = The weather is fine).",
                audioText: "je fais, tu fais, il fait, nous faisons, vous faites, ils font"
            ),
            NotebookItem(
                french: "Parler (-ER Pattern): parle, parles, parle, parlons, parlez, parlent",
                english: "Je parle (I speak), Tu parles (You speak), Nous parlons (We speak)",
                phonetic: "Zhuh pa-kh-l / Noo par-lohn · ਯ਼ ਪਾਖ਼ਲ / ਨੂ ਪਾਰਲੋਂ",
                grammarNote: "Hack: 90% of French verbs follow this exact -ER ending pattern!",
                audioText: "je parle, tu parles, il parle, nous parlons, vous parlez, ils parlent"
            )
        ]
    )

    // MARK: - 7. Everyday Conversation & Introductions
    static let conversationSection = NotebookSection(
        title: "Everyday Conversation & Introductions",
        iconName: "bubble.left.and.bubble.right.fill",
        description: "Essential sentences to introduce yourself and chat confidently.",
        items: [
            NotebookItem(
                french: "Bonjour ! Je m'appelle Harjit.",
                english: "Hello! My name is Harjit.",
                phonetic: "Bon-zhoo-kh ! Zhuh mah-pell Harjit · ਬੋਂਜ਼ੂਖ਼ ! ਯ਼ ਮਾਪੈਲ ਹਰਜੀਤ",
                grammarNote: "Standard polite greeting.",
                audioText: "Bonjour ! Je m'appelle Harjit."
            ),
            NotebookItem(
                french: "Je suis ingénieur logiciel.",
                english: "I am a software engineer.",
                phonetic: "Zhuh swee zahn-zhay-nyu-kh loh-zhee-syell · ਯ਼ੂ ਸ੍ਵੀ ਇੰਜੀਨੀਅਰ",
                grammarNote: "Hack: No article needed before profession.",
                audioText: "Je suis ingénieur logiciel."
            ),
            NotebookItem(
                french: "J'habite à Gobindgarh, Inde.",
                english: "I live in Gobindgarh, India.",
                phonetic: "Zhah-beet ah Gobindgarh · ਯ਼ਾਬੀਤ ਆ ਗੋਬਿੰਦਗੜ੍ਹ",
                grammarNote: "Habiter à + city name.",
                audioText: "J'habite à Gobindgarh, Inde."
            ),
            NotebookItem(
                french: "Enchanté de faire votre connaissance !",
                english: "Delighted to meet you!",
                phonetic: "Ahn-shahn-tay duh fai-kh voh-tkh koh-neh-sahns · ਆਂਸ਼ਾਂਤੇ",
                grammarNote: "Polite phrase when introduced to someone new.",
                audioText: "Enchanté de faire votre connaissance !"
            )
        ]
    )

    // MARK: - 8. Café & Bistro Survival Sentences
    static let diningSection = NotebookSection(
        title: "Café & Bistro Survival",
        iconName: "cup.and.saucer.fill",
        description: "Ordering food, coffee, asking for recommendations and the bill.",
        items: [
            NotebookItem(
                french: "Bonjour, une table pour deux personnes, s'il vous plaît.",
                english: "Hello, a table for two people, please.",
                phonetic: "Bon-zhoo-kh, oon tab-luh poo-kh duh pair-sonn, seel voo pleh · ਬੋਂਜ਼ੂਖ਼, ਊਨ ਤਾਬਲ ਪੂਖ਼",
                grammarNote: "Polite entrance request.",
                audioText: "Bonjour, une table pour deux personnes, s'il vous plaît."
            ),
            NotebookItem(
                french: "Je voudrais un café au lait et un croissant.",
                english: "I would like a coffee with milk and a croissant.",
                phonetic: "Zhuh voo-dreh un kah-fay oh leh ay un kwah-sahn · ਯ਼ ਵੂਦਰੇ ਐਨ ਕਾਫੇ",
                grammarNote: "Je voudrais = polite 'I would like'.",
                audioText: "Je voudrais un café au lait et un croissant."
            ),
            NotebookItem(
                french: "L'addition, s'il vous plaît.",
                english: "The bill, please.",
                phonetic: "Lah-dee-syohn, seel voo pleh · ਲਾਦੀਸਿਓਂ, ਸੀਲ ਵੂ ਪਲੇ",
                grammarNote: "Standard phrase to get the check.",
                audioText: "L'addition, s'il vous plaît."
            )
        ]
    )

    // MARK: - 9. City Directions & Navigation
    static let directionsSection = NotebookSection(
        title: "City Directions & Navigation",
        iconName: "map.fill",
        description: "Finding train stations, turning left/right, and asking distances.",
        items: [
            NotebookItem(
                french: "Excusez-moi, où se trouve la gare ?",
                english: "Excuse me, where is the train station located?",
                phonetic: "Ex-koo-zay mwah, oo suh troov lah gah-kh ? · ਐਕਸਕੂਜ਼ੇ ਮੁਆ, ਲਾ ਗਾਖ਼",
                grammarNote: "Où se trouve = where is located.",
                audioText: "Excusez-moi, où se trouve la gare ?"
            ),
            NotebookItem(
                french: "Allez tout droit et tournez à gauche.",
                english: "Go straight ahead and turn left.",
                phonetic: "Ah-lay too drwah ay too-kh-nay ah gohsh · ਆਲੇ ਤੂ ਦ੍ਰੁਆ",
                grammarNote: "Tout droit = straight, à gauche = left, à droite = right.",
                audioText: "Allez tout droit et tournez à gauche."
            ),
            NotebookItem(
                french: "C'est près d'ici ou loin ?",
                english: "Is it near here or far away?",
                phonetic: "Say preh-kh dee-see oo lwahn ? · ਸੇ ਪ੍ਰੇ ਦੀਸੀ ਊ ਲੁਆਂ",
                grammarNote: "Près = near, loin = far.",
                audioText: "C'est près d'ici ou loin ?"
            )
        ]
    )

    // MARK: - 10. Emergency & Assistance
    static let emergencySection = NotebookSection(
        title: "Emergency & Assistance",
        iconName: "cross.case.fill",
        description: "Urgent phrases for medical help, doctor, and lost items.",
        items: [
            NotebookItem(
                french: "Aidez-moi, s'il vous plaît !",
                english: "Help me, please!",
                phonetic: "Ay-day mwah, seel voo pleh ! · ਐਦੇ ਮੁਆ",
                grammarNote: "Urgent call for help.",
                audioText: "Aidez-moi, s'il vous plaît !"
            ),
            NotebookItem(
                french: "J'ai besoin d'un médecin.",
                english: "I need a doctor.",
                phonetic: "Zhay buh-zwahn dun may-tsahn · ਯ਼ੇ ਬਜ਼ੁਆਂ ਦੈਨ ਮੇਦਸਾਂ",
                grammarNote: "Avoir besoin de = to need.",
                audioText: "J'ai besoin d'un médecin."
            ),
            NotebookItem(
                french: "J'ai perdu mon passeport.",
                english: "I have lost my passport.",
                phonetic: "Zhay pair-doo mohn pass-po-kh · ਯ਼ੇ ਪੈਰਦੂ ਮੋਂ ਪਾਸਪੋਖ਼",
                grammarNote: "Passé composé of perdre.",
                audioText: "J'ai perdu mon passeport."
            )
        ]
    )

    static let allSections: [NotebookSection] = [
        accentsSection,
        genderHacksSection,
        cognatesSection,
        silentLettersSection,
        articlesSection,
        verbsSection,
        conversationSection,
        diningSection,
        directionsSection,
        emergencySection
    ]
}
