import Foundation

// MARK: - Notebook Item & Category

struct NotebookItem: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    let french: String          // e.g. "Je voudrais un café au lait." or "é (Accent Aigu)"
    let english: String         // e.g. "I would like a coffee with milk."
    let phonetic: String        // e.g. "Zhuh voo-dreh un kah-fay oh leh"
    let grammarNote: String?    // optional grammar or context note
    let audioText: String?      // explicit French text to speak (e.g. "une école" for accent cards)

    var spokenFrench: String {
        audioText ?? french
    }
}

struct NotebookSection: Identifiable, Codable {
    var id: UUID = UUID()
    let title: String
    let iconName: String
    let description: String
    let items: [NotebookItem]
}

// MARK: - User Progress

struct UserProgress: Codable {
    var completedLessonIDs: Set<UUID> = []
    var xp: Int = 0
    var streakDays: Int = 0
    var lastPracticeDate: Date? = nil
    var hearts: Int = 5
    var wordsMastered: Set<UUID> = []

    mutating func recordLessonComplete(_ lesson: Lesson, xpEarned: Int) {
        completedLessonIDs.insert(lesson.id)
        xp += xpEarned
        for w in lesson.words { wordsMastered.insert(w.id) }
        updateStreak()
    }

    mutating func updateStreak() {
        let calendar = Calendar.current
        let today = Date()
        if let last = lastPracticeDate {
            if calendar.isDateInToday(last) {
                // already practiced today
            } else if calendar.isDateInYesterday(last) {
                streakDays += 1
            } else {
                streakDays = 1
            }
        } else {
            streakDays = 1
        }
        lastPracticeDate = today
    }

    mutating func loseHeart() {
        hearts = max(0, hearts - 1)
    }

    mutating func refillHearts() {
        hearts = 5
    }
}

// MARK: - Vocabulary & Lesson Models

struct FrenchWord: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    let french: String
    let english: String
    let punjabiSound: String
    let audioHint: String?
}

enum ExerciseType: String, Codable {
    case listenAndPick
    case tapWhatYouHear
    case matchPairs
    case buildSentence
}

struct Exercise: Identifiable, Codable {
    var id: UUID = UUID()
    let type: ExerciseType
    let prompt: String
    let correctAnswer: String
    let options: [String]
    let relatedWord: FrenchWord
}

struct Lesson: Identifiable, Codable {
    var id: UUID = UUID()
    let title: String
    let subtitle: String
    let iconName: String
    let words: [FrenchWord]
    let exercises: [Exercise]
    var isLocked: Bool = false
}

struct LessonUnit: Identifiable, Codable {
    var id: UUID = UUID()
    let unitTitle: String
    let lessons: [Lesson]
}
