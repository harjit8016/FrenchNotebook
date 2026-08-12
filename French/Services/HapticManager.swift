import UIKit

/// Central place for all haptic feedback so feel stays consistent app-wide.
final class HapticManager {
    static let shared = HapticManager()
    private init() {}

    private let notification = UINotificationFeedbackGenerator()
    private let selection = UISelectionFeedbackGenerator()
    private let lightImpact = UIImpactFeedbackGenerator(style: .light)
    private let mediumImpact = UIImpactFeedbackGenerator(style: .medium)

    func correctAnswer() {
        notification.notificationOccurred(.success)
    }

    func wrongAnswer() {
        notification.notificationOccurred(.error)
    }

    func lessonComplete() {
        mediumImpact.impactOccurred()
    }

    func tapWord() {
        lightImpact.impactOccurred()
    }

    func selectionChanged() {
        selection.selectionChanged()
    }

    func prepareAll() {
        notification.prepare()
        selection.prepare()
        lightImpact.prepare()
        mediumImpact.prepare()
    }
}
