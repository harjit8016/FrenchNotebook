import Foundation
import Speech
import AVFoundation
import Combine

/// Handles Speech-to-Text (Mic Pronunciation Practice) using Apple's SFSpeechRecognizer in fr-FR.
final class SpeechToTextService: ObservableObject {
    static let shared = SpeechToTextService()

    @Published var recognizedText: String = ""
    @Published var isListening: Bool = false
    @Published var permissionGranted: Bool = false
    @Published var activeItemID: UUID? = nil

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "fr-FR"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()

    private init() {}

    func toggleListening(for itemID: UUID, targetText: String) {
        if isListening {
            if activeItemID == itemID {
                stopListening()
            } else {
                stopListening()
                requestAuthAndStart(for: itemID)
            }
        } else {
            requestAuthAndStart(for: itemID)
        }
    }

    private func requestAuthAndStart(for itemID: UUID) {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                if status == .authorized {
                    self.permissionGranted = true
                    self.startListening(for: itemID)
                } else {
                    self.permissionGranted = false
                    self.recognizedText = "Permission denied for Speech Recognition"
                }
            }
        }
    }

    private func startListening(for itemID: UUID) {
        stopListening() // clean up any existing task

        activeItemID = itemID
        recognizedText = "Listening..."
        isListening = true

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Failed to set audio session for recording: \(error)")
            stopListening()
            return
        }

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest, let speechRecognizer = speechRecognizer, speechRecognizer.isAvailable else {
            recognizedText = "Speech recognizer unavailable"
            stopListening()
            return
        }

        recognitionRequest.shouldReportPartialResults = true

        let inputNode = audioEngine.inputNode
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let self = self else { return }

            if let result = result {
                DispatchQueue.main.async {
                    self.recognizedText = result.bestTranscription.formattedString
                }
            }

            if error != nil || (result?.isFinal ?? false) {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                DispatchQueue.main.async {
                    self.isListening = false
                }
            }
        }

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("AudioEngine start error: \(error)")
            stopListening()
        }
    }

    func stopListening() {
        if audioEngine.isRunning {
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
            recognitionRequest?.endAudio()
        }
        recognitionTask?.cancel()
        recognitionRequest = nil
        recognitionTask = nil
        isListening = false
        activeItemID = nil
    }
}
