import SwiftUI

struct LessonSessionView: View {
    let lesson: Lesson

    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var progressStore = ProgressStore.shared
    @StateObject private var speech = SpeechService.shared

    @State private var currentIndex = 0
    @State private var selectedOption: String?
    @State private var showResult = false
    @State private var correctCount = 0
    @State private var sessionEnded = false

    private var exercises: [Exercise] { lesson.exercises }
    private var currentExercise: Exercise { exercises[currentIndex] }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                header

                if sessionEnded {
                    SessionCompleteView(
                        correctCount: correctCount,
                        total: exercises.count,
                        onDone: {
                            progressStore.completeLesson(lesson, xpEarned: correctCount * 2)
                            HapticManager.shared.lessonComplete()
                            dismiss()
                        }
                    )
                } else {
                    exerciseCard
                    Spacer()
                    actionButton
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        .onAppear { HapticManager.shared.prepareAll() }
    }

    private var header: some View {
        VStack(spacing: 8) {
            ProgressView(value: Double(currentIndex), total: Double(exercises.count))
                .tint(.green)
            HStack {
                Image(systemName: "heart.fill").foregroundStyle(.red)
                Text("\(progressStore.progress.hearts)")
                Spacer()
            }
            .font(.subheadline.bold())
        }
    }

    private var exerciseCard: some View {
        VStack(spacing: 20) {
            Text("Tap to hear the word")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Button {
                HapticManager.shared.tapWord()
                speech.speak(currentExercise.prompt)
            } label: {
                VStack(spacing: 8) {
                    Image(systemName: speech.isSpeaking ? "speaker.wave.2.fill" : "speaker.wave.2")
                        .font(.system(size: 40))
                    Text(currentExercise.prompt)
                        .font(.largeTitle.bold())
                    Text(currentExercise.relatedWord.punjabiSound)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                .padding(32)
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .buttonStyle(.plain)

            VStack(spacing: 12) {
                ForEach(currentExercise.options, id: \.self) { option in
                    OptionRow(
                        text: option,
                        state: optionState(for: option)
                    )
                    .onTapGesture {
                        guard selectedOption == nil else { return }
                        selectedOption = option
                        handleAnswer(option)
                    }
                }
            }
        }
    }

    private func optionState(for option: String) -> OptionRow.State {
        guard let selected = selectedOption else { return .neutral }
        if option == currentExercise.correctAnswer { return .correct }
        if option == selected { return .wrong }
        return .neutral
    }

    private func handleAnswer(_ option: String) {
        if option == currentExercise.correctAnswer {
            HapticManager.shared.correctAnswer()
            correctCount += 1
        } else {
            HapticManager.shared.wrongAnswer()
            progressStore.loseHeart()
        }
    }

    private var actionButton: some View {
        Button {
            advance()
        } label: {
            Text(currentIndex == exercises.count - 1 ? "Finish" : "Continue")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(selectedOption == nil ? Color.gray.opacity(0.3) : Color.green)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .disabled(selectedOption == nil)
    }

    private func advance() {
        selectedOption = nil
        if currentIndex < exercises.count - 1 {
            currentIndex += 1
        } else {
            sessionEnded = true
        }
    }
}

private struct OptionRow: View {
    enum State { case neutral, correct, wrong }
    let text: String
    let state: State

    var body: some View {
        Text(text)
            .font(.body.bold())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(backgroundColor)
            .foregroundColor(state == .neutral ? .primary : .white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: state == .neutral ? 1 : 0)
            )
    }

    private var backgroundColor: Color {
        switch state {
        case .neutral: return Color(.secondarySystemBackground)
        case .correct: return .green
        case .wrong: return .red
        }
    }
}

private struct SessionCompleteView: View {
    let correctCount: Int
    let total: Int
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "party.popper.fill")
                .font(.system(size: 60))
                .foregroundStyle(.yellow)
            Text("Lesson Complete!")
                .font(.title.bold())
            Text("\(correctCount)/\(total) correct")
                .font(.title3)
                .foregroundStyle(.secondary)
            Spacer()
            Button(action: onDone) {
                Text("Continue")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
        }
    }
}
