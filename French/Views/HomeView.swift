import SwiftUI

struct HomeView: View {
    @ObservedObject private var progressStore = ProgressStore.shared
    @State private var selectedLesson: Lesson?

    private let units = SampleData.allUnits

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    ForEach(units) { unit in
                        VStack(spacing: 24) {
                            Text(unit.unitTitle.uppercased())
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)

                            ForEach(Array(unit.lessons.enumerated()), id: \.element.id) { index, lesson in
                                LessonNode(
                                    lesson: lesson,
                                    isComplete: progressStore.isLessonComplete(lesson),
                                    isLocked: lesson.isLocked && !isUnlocked(unit: unit, index: index)
                                )
                                .onTapGesture {
                                    let unlocked = !lesson.isLocked || isUnlocked(unit: unit, index: index)
                                    if unlocked {
                                        HapticManager.shared.tapWord()
                                        selectedLesson = lesson
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 24)
            }
            .navigationTitle("French")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Label("\(progressStore.progress.streakDays)", systemImage: "flame.fill")
                        .foregroundStyle(.orange)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 4) {
                        Image(systemName: "heart.fill").foregroundStyle(.red)
                        Text("\(progressStore.progress.hearts)")
                        Text("·")
                        Image(systemName: "star.fill").foregroundStyle(.yellow)
                        Text("\(progressStore.progress.xp) XP")
                    }
                    .font(.subheadline.bold())
                }
            }
            .fullScreenCover(item: $selectedLesson) { lesson in
                LessonSessionView(lesson: lesson)
            }
        }
    }

    /// A lesson unlocks once the lesson immediately before it (in reading order,
    /// across the whole path — not just within the same unit) is complete.
    private func isUnlocked(unit: LessonUnit, index: Int) -> Bool {
        if index > 0 {
            return progressStore.isLessonComplete(unit.lessons[index - 1])
        }
        // First lesson of a unit: check the last lesson of the previous unit.
        guard let unitIndex = units.firstIndex(where: { $0.id == unit.id }), unitIndex > 0 else {
            return true // very first lesson in the whole path
        }
        guard let previousUnitLastLesson = units[unitIndex - 1].lessons.last else { return true }
        return progressStore.isLessonComplete(previousUnitLastLesson)
    }
}

private struct LessonNode: View {
    let lesson: Lesson
    let isComplete: Bool
    let isLocked: Bool

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(circleColor)
                    .frame(width: 72, height: 72)
                    .shadow(color: circleColor.opacity(0.4), radius: 6, y: 4)

                Image(systemName: isLocked ? "lock.fill" : (isComplete ? "checkmark" : lesson.iconName))
                    .font(.title2.bold())
                    .foregroundStyle(.white)
            }
            Text(lesson.title)
                .font(.footnote.bold())
            Text(lesson.subtitle)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .opacity(isLocked ? 0.5 : 1.0)
    }

    private var circleColor: Color {
        if isLocked { return .gray }
        if isComplete { return .green }
        return .blue
    }
}

#Preview {
    HomeView()
}
