import Foundation

// MARK: - Reference Content Models

struct RuleExample: Identifiable, Hashable {
    var id: UUID = UUID()
    let french: String
    let english: String
    let punjabiSound: String
}

struct RuleCard: Identifiable {
    var id: UUID = UUID()
    let title: String
    let iconName: String
    let explanation: String
    let examples: [RuleExample]
}

struct ConjugationRow: Identifiable, Hashable {
    var id: UUID = UUID()
    let pronoun: String
    let pronounPunjabi: String
    let verbForm: String
    let punjabiSound: String
}

struct VerbCard: Identifiable {
    var id: UUID = UUID()
    let infinitive: String
    let englishMeaning: String
    let group: String
    let rows: [ConjugationRow]
    let note: String
}

// MARK: - Reference Data

enum ReferenceData {

    // MARK: Liaison Rules
    static let liaisonRules: [RuleCard] = [
        RuleCard(
            title: "Liaison — Shabd Judke Bolna",
            iconName: "link",
            explanation: "Jado ek shabd consonant naal khatam hunda hai te agla shabd vowel/silent-H naal shuru hunda hai, dono jud ke bolde ne.",
            examples: [
                RuleExample(french: "les amis", english: "the friends", punjabiSound: "ਲੇ-ਜ਼ਾ-ਮੀ"),
                RuleExample(french: "vous avez", english: "you have", punjabiSound: "ਵੂ-ਜ਼ਾ-ਵੇ"),
                RuleExample(french: "nous avons", english: "we have", punjabiSound: "ਨੂ-ਜ਼ਾ-ਵੋਂ"),
                RuleExample(french: "un homme", english: "a man", punjabiSound: "ਐਨ-ਓਮ"),
            ]
        ),
        RuleCard(
            title: "Kado Liaison NAHI Hundi",
            iconName: "link.badge.plus",
            explanation: "Jado agla shabd consonant ya sakht H (h aspiré) naal shuru hunda hai, dono vakhre bolo.",
            examples: [
                RuleExample(french: "les / chats", english: "the / cats", punjabiSound: "ਲੇ / ਸ਼ਾ (vakhre)"),
                RuleExample(french: "des / héros", english: "the / heroes", punjabiSound: "ਦੇ / ਏਖ਼ੋ (vakhre, throat ਖ਼)"),
            ]
        )
    ]

    // MARK: Word Ending Hacks (Cognates)
    static let cognateHacks: [RuleCard] = [
        RuleCard(
            title: "-tion → -tion (Same!)",
            iconName: "equal.circle",
            explanation: "Eh ending bilkul nahi badalda — spelling same, bas French accent naal bolo.",
            examples: [
                RuleExample(french: "nation", english: "nation", punjabiSound: "ਨਾਸਿਓਂ"),
                RuleExample(french: "attention", english: "attention", punjabiSound: "ਆਤਾਂਸਿਓਂ"),
                RuleExample(french: "action", english: "action", punjabiSound: "ਆਕਸਿਓਂ"),
            ]
        ),
        RuleCard(
            title: "-or → -eur (Throat ਖ਼ Sound)",
            iconName: "arrow.triangle.2.circlepath",
            explanation: "English '-or' French ch '-eur' ban jaanda hai — ending ch throat 'ਖ਼' bolo.",
            examples: [
                RuleExample(french: "tuteur", english: "tutor / guardian", punjabiSound: "ਤੂਤੇਖ਼"),
                RuleExample(french: "acteur", english: "actor", punjabiSound: "ਆਕਤੇਖ਼"),
                RuleExample(french: "docteur", english: "doctor", punjabiSound: "ਦੌਕਤੇਖ਼"),
            ]
        ),
        RuleCard(
            title: "-ty → -té",
            iconName: "arrow.triangle.2.circlepath",
            explanation: "English '-ty' French ch '-té' ban jaanda hai.",
            examples: [
                RuleExample(french: "université", english: "university", punjabiSound: "ਊਨੀਵੇਖ਼ਸੀਤੇ"),
                RuleExample(french: "société", english: "society", punjabiSound: "ਸੋਸਿਏਤੇ"),
                RuleExample(french: "liberté", english: "liberty", punjabiSound: "ਲਿਬੇਖ਼ਤੇ"),
            ]
        ),
        RuleCard(
            title: "-ic → -ique",
            iconName: "arrow.triangle.2.circlepath",
            explanation: "English '-ic' French ch '-ique' ban jaanda hai.",
            examples: [
                RuleExample(french: "logique", english: "logic", punjabiSound: "ਲੋਜ਼ੀਕ"),
                RuleExample(french: "musique", english: "music", punjabiSound: "ਮੂਜ਼ੀਕ"),
                RuleExample(french: "classique", english: "classic", punjabiSound: "ਕਲਾਸੀਕ"),
            ]
        ),
        RuleCard(
            title: "-ous → -eux",
            iconName: "arrow.triangle.2.circlepath",
            explanation: "English '-ous' French ch '-eux' ban jaanda hai.",
            examples: [
                RuleExample(french: "fameux", english: "famous", punjabiSound: "ਫਾਮੂ"),
                RuleExample(french: "dangereux", english: "dangerous", punjabiSound: "ਦਾਂਜ਼ਖ਼ੂ"),
                RuleExample(french: "curieux", english: "curious", punjabiSound: "ਕੂਰੀਓ"),
            ]
        ),
        RuleCard(
            title: "-able → -able (Same!)",
            iconName: "equal.circle",
            explanation: "Bas French accent naal bolo.",
            examples: [
                RuleExample(french: "confortable", english: "comfortable", punjabiSound: "ਕੋਂਫੋਖ਼ਤਾਬਲ"),
                RuleExample(french: "adorable", english: "adorable", punjabiSound: "ਆਦੋਖ਼ਾਬਲ"),
            ]
        )
    ]

    // MARK: Pronouns
    static let pronounRule = RuleCard(
        title: "Subject Pronouns",
        iconName: "person.2.fill",
        explanation: "Verb ton pehla aunde ne te dasde ne kaun kar riha hai.",
        examples: [
            RuleExample(french: "je", english: "I", punjabiSound: "ਯ਼"),
            RuleExample(french: "tu", english: "you (informal)", punjabiSound: "ਤੂ"),
            RuleExample(french: "il", english: "he / it (masc.)", punjabiSound: "ਈਲ"),
            RuleExample(french: "elle", english: "she / it (fem.)", punjabiSound: "ਐੱਲ"),
            RuleExample(french: "nous", english: "we", punjabiSound: "ਨੂ"),
            RuleExample(french: "vous", english: "you (formal/plural)", punjabiSound: "ਵੂ"),
            RuleExample(french: "ils", english: "they (masc./mixed)", punjabiSound: "ਈਲ"),
            RuleExample(french: "elles", english: "they (fem.)", punjabiSound: "ਐੱਲ"),
        ]
    )

    // MARK: Verb Basics
    static let etreCard = VerbCard(
        infinitive: "être (ਐਤ-ਖ਼)",
        englishMeaning: "to be (am/is/are)",
        group: "Irregular — memorize first",
        rows: [
            ConjugationRow(pronoun: "je suis", pronounPunjabi: "ਯ਼", verbForm: "suis", punjabiSound: "ਯ਼ੂ ਸ੍ਵੀ (I am)"),
            ConjugationRow(pronoun: "tu es", pronounPunjabi: "ਤੂ", verbForm: "es", punjabiSound: "ਤੂ ਏ (you are)"),
            ConjugationRow(pronoun: "il/elle est", pronounPunjabi: "ਈਲ/ਐੱਲ", verbForm: "est", punjabiSound: "ਈਲ ਏ (he/she is)"),
            ConjugationRow(pronoun: "nous sommes", pronounPunjabi: "ਨੂ", verbForm: "sommes", punjabiSound: "ਨੂ ਸੋਮ (we are)"),
            ConjugationRow(pronoun: "vous êtes", pronounPunjabi: "ਵੂ", verbForm: "êtes", punjabiSound: "ਵੂ ਏਤ (you are)"),
            ConjugationRow(pronoun: "ils/elles sont", pronounPunjabi: "ਈਲ/ਐੱਲ", verbForm: "sont", punjabiSound: "ਈਲ ਸੋਂ (they are)"),
        ],
        note: "'is/am/are' sabh eh ek hi verb 'être' de forms ne."
    )

    static let avoirCard = VerbCard(
        infinitive: "avoir (ਆਵੋਆਖ਼)",
        englishMeaning: "to have (has/have)",
        group: "Irregular — second must-memorize verb",
        rows: [
            ConjugationRow(pronoun: "j'ai", pronounPunjabi: "ਯ਼", verbForm: "ai", punjabiSound: "ਯ਼ੇ (I have)"),
            ConjugationRow(pronoun: "tu as", pronounPunjabi: "ਤੂ", verbForm: "as", punjabiSound: "ਤੂ ਆ (you have)"),
            ConjugationRow(pronoun: "il/elle a", pronounPunjabi: "ਈਲ/ਐੱਲ", verbForm: "a", punjabiSound: "ਈਲ ਆ (he/she has)"),
            ConjugationRow(pronoun: "nous avons", pronounPunjabi: "ਨੂ", verbForm: "avons", punjabiSound: "ਨੂ ਜ਼ਾਵੋਂ (we have)"),
            ConjugationRow(pronoun: "vous avez", pronounPunjabi: "ਵੂ", verbForm: "avez", punjabiSound: "ਵੂ ਜ਼ਾਵੇ (you have)"),
            ConjugationRow(pronoun: "ils/elles ont", pronounPunjabi: "ਈਲ/ਐੱਲ", verbForm: "ont", punjabiSound: "ਈл ਜ਼ੋਂ (they have)"),
        ],
        note: "In French, age uses Avoir (J'ai 29 ans)."
    )

    static let erVerbCard = VerbCard(
        infinitive: "parler (ਪਾਖ਼ਲੇ)",
        englishMeaning: "to speak (regular -ER verb pattern)",
        group: "-ER verbs (regular) — ~90% follow this",
        rows: [
            ConjugationRow(pronoun: "je parle", pronounPunjabi: "ਯ਼", verbForm: "parle", punjabiSound: "ਯ਼ ਪਾਖ਼ਲ"),
            ConjugationRow(pronoun: "tu parles", pronounPunjabi: "ਤੂ", verbForm: "parles", punjabiSound: "ਤੂ ਪਾਖ਼ਲ"),
            ConjugationRow(pronoun: "il/elle parle", pronounPunjabi: "ਈਲ/ਐੱਲ", verbForm: "parle", punjabiSound: "ਈਲ ਪਾਖ਼ਲ"),
            ConjugationRow(pronoun: "nous parlons", pronounPunjabi: "ਨੂ", verbForm: "parlons", punjabiSound: "ਨੂ ਪਾਖ਼ਲੋਂ"),
            ConjugationRow(pronoun: "vous parlez", pronounPunjabi: "ਵੂ", verbForm: "parlez", punjabiSound: "ਵੂ ਪਾਖ਼ਲੇ"),
            ConjugationRow(pronoun: "ils/elles parlent", pronounPunjabi: "ਈਲ/ਐੱਲ", verbForm: "parlent", punjabiSound: "ਈਲ ਪਾਖ਼ਲ"),
        ],
        note: "Note: R is pronounced as throat 'ਖ਼' (ਪਾਖ਼ਲੇ, ਪਾਖ਼ਲ)."
    )

    static let modalNote = RuleCard(
        title: "will / can / must — Modals",
        iconName: "questionmark.circle",
        explanation: "Je peux (I can), Je dois (I must), Je vais parler (I will speak).",
        examples: [
            RuleExample(french: "je peux", english: "I can", punjabiSound: "ਯ਼ ਪ (pouvoir)"),
            RuleExample(french: "je dois", english: "I must", punjabiSound: "ਯ਼ ਦੂਆ (devoir)"),
            RuleExample(french: "je vais parler", english: "I will speak", punjabiSound: "ਯ਼ ਵੇ ਪਾਖ਼ਲੇ (near future)"),
        ]
    )
}
