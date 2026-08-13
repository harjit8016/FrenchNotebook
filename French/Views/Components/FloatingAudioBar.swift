import SwiftUI

struct FloatingAudioBar: View {
    @ObservedObject var speech: SpeechService
    @ObservedObject private var themeManager = ThemeManager.shared
    @State private var waveAnim: Bool = false

    var body: some View {
        if speech.isSpeaking {
            HStack(spacing: 12) {
                // Speech Wave Icon / Pulse
                HStack(spacing: 3) {
                    ForEach(0..<4) { index in
                        Capsule()
                            .fill(themeManager.currentTheme.accentColor)
                            .frame(width: 3, height: waveAnim ? CGFloat([14, 22, 10, 18][index]) : 6)
                            .animation(
                                .easeInOut(duration: 0.45)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.12),
                                value: waveAnim
                            )
                    }
                }
                .frame(width: 24, height: 24)
                .onAppear { waveAnim = true }
                .onDisappear { waveAnim = false }

                VStack(alignment: .leading, spacing: 2) {
                    Text("SPEAKING FRENCH")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(themeManager.currentTheme.accentColor)

                    HighlightedTextView(
                        fullText: speech.currentSpokenText.isEmpty ? "Listening..." : speech.currentSpokenText,
                        activeRange: speech.currentWordRange,
                        font: .system(size: 13, weight: .bold),
                        normalColor: themeManager.currentTheme.primaryTextColor,
                        highlightColor: themeManager.currentTheme.accentColor
                    )
                    .lineLimit(1)
                }

                Spacer()

                // Speech Speed Toggle Pill
                Button {
                    HapticManager.shared.tapWord()
                    cycleSpeed()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "gauge.with.dots.needle.50percent")
                            .font(.system(size: 11, weight: .bold))
                        Text(String(format: "%.2fx", themeManager.speechRate))
                            .font(.system(size: 11, weight: .bold))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(themeManager.currentTheme.accentColor.opacity(0.15))
                    .foregroundStyle(themeManager.currentTheme.accentColor)
                    .clipShape(Capsule())
                }
                .buttonStyle(.plain)

                // Stop Button
                Button {
                    HapticManager.shared.tapWord()
                    speech.stop()
                } label: {
                    Image(systemName: "stop.circle.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(themeManager.currentTheme.accentColor)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .appFloatingCard(cornerRadius: 20)
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .animation(.spring(response: 0.35, dampingFraction: 0.72), value: speech.isSpeaking)
        }
    }

    private func cycleSpeed() {
        if themeManager.speechRate <= 0.20 {
            themeManager.speechRate = 0.30
        } else if themeManager.speechRate <= 0.30 {
            themeManager.speechRate = 0.45
        } else {
            themeManager.speechRate = 0.20
        }
    }
}
