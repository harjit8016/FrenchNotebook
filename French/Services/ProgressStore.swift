import Foundation
import Combine

/// Persists and publishes user progress. Swap the storage layer for SwiftData/CloudKit later
/// without touching any View code — everything reads through this ObservableObject.
final class ProgressStore: ObservableObject {
    static let shared = ProgressStore()

    @Published private(set) var progress: UserProgress

    private let storageKey = "user_progress_v1"

    private init() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode(UserProgress.self, from: data) {
            self.progress = decoded
        } else {
            self.progress = UserProgress()
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(progress) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    func completeLesson(_ lesson: Lesson, xpEarned: Int = 10) {
        progress.recordLessonComplete(lesson, xpEarned: xpEarned)
        save()
    }

    func isLessonComplete(_ lesson: Lesson) -> Bool {
        progress.completedLessonIDs.contains(lesson.id)
    }

    func loseHeart() {
        progress.loseHeart()
        save()
    }

    func refillHearts() {
        progress.refillHearts()
        save()
    }

    func reset() {
        progress = UserProgress()
        save()
    }
}
