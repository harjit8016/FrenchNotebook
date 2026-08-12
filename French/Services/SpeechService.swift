import AVFoundation
import Combine

/// Handles tap-to-play French pronunciation with real-time word highlighting and customizable voice options.
final class SpeechService: NSObject, ObservableObject {
    static let shared = SpeechService()

    private let synthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking: Bool = false
    @Published var currentlySpeakingItemID: UUID? = nil
    @Published var currentWordRange: NSRange? = nil

    private var activeUtterance: AVSpeechUtterance? = nil

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
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }

        let utterance = AVSpeechUtterance(string: text)

        // Apply chosen French Voice identifier if selected
        let voiceID = ThemeManager.shared.selectedVoiceIdentifier
        if !voiceID.isEmpty, let voice = AVSpeechSynthesisVoice(identifier: voiceID) {
            utterance.voice = voice
        } else {
            utterance.voice = AVSpeechSynthesisVoice(language: "fr-FR")
        }

        utterance.rate = rate
        utterance.pitchMultiplier = pitch

        activeUtterance = utterance
        currentlySpeakingItemID = itemID
        currentWordRange = nil
        isSpeaking = true

        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        activeUtterance = nil
        currentlySpeakingItemID = nil
        currentWordRange = nil
        isSpeaking = false
    }
}

extension SpeechService: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            if self.activeUtterance === utterance {
                self.isSpeaking = true
            }
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            if self.activeUtterance === utterance {
                self.currentWordRange = characterRange
            }
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            if self.activeUtterance === utterance {
                self.isSpeaking = false
                self.currentlySpeakingItemID = nil
                self.currentWordRange = nil
                self.activeUtterance = nil
            }
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            if self.activeUtterance === utterance {
                self.isSpeaking = false
                self.currentlySpeakingItemID = nil
                self.currentWordRange = nil
                self.activeUtterance = nil
            }
        }
    }
}
