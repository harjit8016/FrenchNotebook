---
name: solid-principles
description: Standards and guidelines for applying SOLID software engineering principles in Swift and application development.
---

# SOLID Principles Skill

This skill defines standards for enforcing the five SOLID design principles in Swift architecture and UI design.

## Principles Overview

### 1. Single Responsibility Principle (SRP)
- A class, struct, or module should have one, and only one, reason to change.
- **Example**: Separate speech synthesis (`SpeechService`) from data storage (`ProgressStore`) and view layout (`NotebookView`).

### 2. Open/Closed Principle (OCP)
- Software entities (classes, modules, functions) should be open for extension, but closed for modification.
- Use protocols and generics to allow new card types, content formats, or speech providers without mutating core view logic.

### 3. Liskov Substitution Principle (LSP)
- Subtypes must be substitutable for their base types without altering correctness.
- In Swift, implement protocol conformances strictly adhering to contract behaviors.

### 4. Interface Segregation Principle (ISP)
- Clients should not be forced to depend upon interfaces they do not use.
- Keep protocols small and targeted (e.g. `AudioPlayable`, `SearchableContent`, `ExportableData`).

### 5. Dependency Inversion Principle (DIP)
- Depend upon abstractions, not concretions.
- Inject dependencies (like audio synthesizers or data stores) via initializers or environment protocols to enable easy testing and modular replacement.

---

## Architectural Mapping in Swift

```swift
// Audio Synthesizing Abstraction (DIP & ISP)
protocol SpeechSynthesizing {
    func speak(_ text: String, rate: Float, pitch: Float)
    func stop()
}

// Concrete Implementation (SRP)
final class SpeechService: NSObject, ObservableObject, SpeechSynthesizing {
    static let shared = SpeechService()
    // Speech synthesis implementation only
}
```

---

## Checklist for SOLID Audits
- [ ] Views contain only UI presentation logic (SRP).
- [ ] Domain services handle single isolated responsibilities (SRP).
- [ ] Dependencies are injectable or protocol-based (DIP).
- [ ] Protocols are concise and focused (ISP).
