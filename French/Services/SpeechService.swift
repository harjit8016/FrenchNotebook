import AVFoundation
import Combine

/// Handles tap-to-play French pronunciation with real-time word highlighting.
final class SpeechService: NSObject, ObservableObject {
    static let shared = SpeechService()

    private let synthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking: Bool = false
    @Published var currentlySpeakingItemID: UUID? = nil
    @Published var currentWordRange: NSRange? = nil

    private var lastSpokenText: String? = nil
    private var lastSpokenTime: Date = Date.distantPast

    private override init() {
        super.init()
        synthesizer.delegate = self
        configureAudioSession()
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session error: \(error)")
        }
    }

    /// Speak a French word/phrase with item tracking and real-time word range updates.
    func speak(_ text: String, itemID: UUID? = nil, rate: Float = 0.42, pitch: Float = 1.0) {
        let now = Date()
        if lastSpokenText == text && now.timeIntervalSince(lastSpokenTime) < 0.35 {
            return
        }
        lastSpokenText = text
        lastSpokenTime = now

        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }

        currentlySpeakingItemID = itemID
        currentWordRange = nil

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "fr-FR")
        utterance.rate = rate
        utterance.pitchMultiplier = pitch
        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        currentlySpeakingItemID = nil
        currentWordRange = nil
    }
}

extension SpeechService: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = true
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.currentWordRange = characterRange
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = false
            self.currentlySpeakingItemID = nil
            self.currentWordRange = nil
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isSpeaking = false
            self.currentlySpeakingItemID = nil
            self.currentWordRange = nil
        }
    }
}
