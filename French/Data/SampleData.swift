import Foundation

enum SampleData {

    static let alphabetWords: [FrenchWord] = [
        FrenchWord(french: "A", english: "A", punjabiSound: "ਆ", audioHint: nil),
        FrenchWord(french: "B", english: "B", punjabiSound: "ਬੇ", audioHint: nil),
        FrenchWord(french: "C", english: "C", punjabiSound: "ਸੇ", audioHint: nil),
        FrenchWord(french: "H", english: "H (silent)", punjabiSound: "ਆਸ਼ (ਖਾਮੋਸ਼)", audioHint: nil),
        FrenchWord(french: "R", english: "R (guttural throat sound)", punjabiSound: "ਐਖ਼ (ਗਲੇ ਵਿੱਚੋਂ - ਖ਼)", audioHint: nil),
    ]

    static let accentWords: [FrenchWord] = [
        FrenchWord(french: "où", english: "where", punjabiSound: "ਊ", audioHint: nil),
        FrenchWord(french: "ou", english: "or", punjabiSound: "ਉ", audioHint: nil),
        FrenchWord(french: "sûr", english: "sure", punjabiSound: "ਸੂਖ਼ (ਗਲੇ ਵਿੱਚੋਂ ਖ਼)", audioHint: nil),
        FrenchWord(french: "sur", english: "on", punjabiSound: "ਸੁਖ਼ (ਗਲੇ ਵਿੱਚੋਂ ਖ਼)", audioHint: nil),
        FrenchWord(french: "à", english: "to, at", punjabiSound: "ਆ", audioHint: nil),
    ]

    static func makeExercise(from word: FrenchWord, distractors: [String]) -> Exercise {
        var options = distractors
        options.append(word.english)
        options.shuffle()
        return Exercise(
            type: .listenAndPick,
            prompt: word.french,
            correctAnswer: word.english,
            options: options,
            relatedWord: word
        )
    }

    static let liaisonWords: [FrenchWord] = [
        FrenchWord(french: "les amis", english: "the friends", punjabiSound: "ਲੇ-ਜ਼ਾ-ਮੀ", audioHint: nil),
        FrenchWord(french: "vous avez", english: "you have", punjabiSound: "ਵੂ-ਜ਼ਾ-ਵੇ", audioHint: nil),
        FrenchWord(french: "nous avons", english: "we have", punjabiSound: "ਨੂ-ਜ਼ਾ-ਵੋਂ", audioHint: nil),
        FrenchWord(french: "un homme", english: "a man", punjabiSound: "ਐਨ-ਓਮ", audioHint: nil),
    ]

    static let cognateWords: [FrenchWord] = [
        FrenchWord(french: "tuteur", english: "tutor / guardian", punjabiSound: "ਤੂਤੇਖ਼", audioHint: nil),
        FrenchWord(french: "nation", english: "nation", punjabiSound: "ਨਾਸਿਓਂ", audioHint: nil),
        FrenchWord(french: "université", english: "university", punjabiSound: "ਊਨੀਵੇਖ਼ਸੀਤੇ", audioHint: nil),
        FrenchWord(french: "logique", english: "logic", punjabiSound: "ਲੋਜ਼ੀਕ", audioHint: nil),
        FrenchWord(french: "fameux", english: "famous", punjabiSound: "ਫਾਮੂ", audioHint: nil),
        FrenchWord(french: "confortable", english: "comfortable", punjabiSound: "ਕੋਂਫੋਖ਼ਤਾਬਲ", audioHint: nil),
    ]

    static let etreWords: [FrenchWord] = [
        FrenchWord(french: "je suis", english: "I am", punjabiSound: "ਯ਼ੂ ਸ੍ਵੀ", audioHint: nil),
        FrenchWord(french: "tu es", english: "you are", punjabiSound: "ਤੂ ਏ", audioHint: nil),
        FrenchWord(french: "il est", english: "he is", punjabiSound: "ਈਲ ਏ", audioHint: nil),
        FrenchWord(french: "nous sommes", english: "we are", punjabiSound: "ਨੂ ਸੋਮ", audioHint: nil),
        FrenchWord(french: "vous êtes", english: "you are (formal)", punjabiSound: "ਵੂ ਏਤ", audioHint: nil),
        FrenchWord(french: "ils sont", english: "they are", punjabiSound: "ਈਲ ਸੋਂ", audioHint: nil),
    ]

    static let avoirWords: [FrenchWord] = [
        FrenchWord(french: "j'ai", english: "I have", punjabiSound: "ਯ਼ੇ", audioHint: nil),
        FrenchWord(french: "tu as", english: "you have", punjabiSound: "ਤੂ ਆ", audioHint: nil),
        FrenchWord(french: "il a", english: "he has", punjabiSound: "ਈਲ ਆ", audioHint: nil),
        FrenchWord(french: "nous avons", english: "we have", punjabiSound: "ਨੂ ਜ਼ਾਵੋਂ", audioHint: nil),
        FrenchWord(french: "vous avez", english: "you have (formal)", punjabiSound: "ਵੂ ਜ਼ਾਵੇ", audioHint: nil),
        FrenchWord(french: "ils ont", english: "they have", punjabiSound: "ਈਲ ਜ਼ੋਂ", audioHint: nil),
    ]

    static let parlerWords: [FrenchWord] = [
        FrenchWord(french: "je parle", english: "I speak", punjabiSound: "ਯ਼ ਪਾਖ਼ਲ", audioHint: nil),
        FrenchWord(french: "tu parles", english: "you speak", punjabiSound: "ਤੂ ਪਾਖ਼ਲ", audioHint: nil),
        FrenchWord(french: "il parle", english: "he speaks", punjabiSound: "ਈਲ ਪਾਖ਼ਲ", audioHint: nil),
        FrenchWord(french: "nous parlons", english: "we speak", punjabiSound: "ਨੂ ਪਾਖ਼ਲੋਂ", audioHint: nil),
        FrenchWord(french: "vous parlez", english: "you speak (formal)", punjabiSound: "ਵੂ ਪਾਖ਼ਲੇ", audioHint: nil),
        FrenchWord(french: "ils parlent", english: "they speak", punjabiSound: "ਈਲ ਪਾਖ਼ਲ", audioHint: nil),
    ]

    static let unit1 = LessonUnit(
        unitTitle: "Foundations",
        lessons: [
            Lesson(
                title: "The Alphabet",
                subtitle: "Letters & sounds",
                iconName: "textformat.abc",
                words: alphabetWords,
                exercises: alphabetWords.map {
                    makeExercise(from: $0, distractors: ["Wrong 1", "Wrong 2"])
                },
                isLocked: false
            ),
            Lesson(
                title: "Accents",
                subtitle: "é è ê à where they matter",
                iconName: "textformat",
                words: accentWords,
                exercises: accentWords.map {
                    makeExercise(from: $0, distractors: ["Wrong 1", "Wrong 2"])
                },
                isLocked: true
            ),
            Lesson(
                title: "Liaison",
                subtitle: "Words that join together",
                iconName: "link",
                words: liaisonWords,
                exercises: liaisonWords.map {
                    makeExercise(from: $0, distractors: ["Wrong 1", "Wrong 2"])
                },
                isLocked: true
            )
        ]
    )

    static let unit2 = LessonUnit(
        unitTitle: "Word Hacks",
        lessons: [
            Lesson(
                title: "Cognates",
                subtitle: "-tion, -eur, -té, -ique, -eux",
                iconName: "wand.and.stars",
                words: cognateWords,
                exercises: cognateWords.map {
                    makeExercise(from: $0, distractors: ["Wrong 1", "Wrong 2"])
                },
                isLocked: true
            )
        ]
    )

    static let unit3 = LessonUnit(
        unitTitle: "Verb Basics",
        lessons: [
            Lesson(
                title: "être (to be)",
                subtitle: "am / is / are",
                iconName: "person.fill",
                words: etreWords,
                exercises: etreWords.map {
                    makeExercise(from: $0, distractors: ["Wrong 1", "Wrong 2"])
                },
                isLocked: true
            ),
            Lesson(
                title: "avoir (to have)",
                subtitle: "has / have",
                iconName: "hand.raised.fill",
                words: avoirWords,
                exercises: avoirWords.map {
                    makeExercise(from: $0, distractors: ["Wrong 1", "Wrong 2"])
                },
                isLocked: true
            ),
            Lesson(
                title: "-ER Verbs",
                subtitle: "parler pattern (90% of verbs)",
                iconName: "text.bubble.fill",
                words: parlerWords,
                exercises: parlerWords.map {
                    makeExercise(from: $0, distractors: ["Wrong 1", "Wrong 2"])
                },
                isLocked: true
            )
        ]
    )

    static let allUnits: [LessonUnit] = [unit1, unit2, unit3]
}
