---
name: dry-principle
description: Standards and practices for Don't Repeat Yourself (DRY) principles in software engineering and SwiftUI application development.
---

# DRY (Don't Repeat Yourself) Principle Skill

This skill defines standards for enforcing DRY principles across codebases, avoiding duplicated logic, redundant UI declarations, and repetitive data structures.

## Key Rules

### 1. Single Source of Truth
- Every piece of knowledge, rule, or configuration must have a single, unambiguous representation within the system.
- Avoid duplicate string constants or color hex codes; use centralized constants, enums, or Asset Catalogs.

### 2. Extracted Modular Components
- Never copy-paste view blocks (e.g. repetition of card styles or list item rows). Extract reusable subviews or custom `ViewModifier` extensions.
- Consolidate business logic into reusable service services (e.g., audio synthesizer service, speech synthesizer manager).

### 3. Unified Data Providers
- Store static lesson/reference content in consolidated data models rather than hardcoding identical structures across multiple view files.
- Centralize formatting functions (e.g., phonetic transcriptions, sentence translations, date formatting) in domain helper extensions.

---

## Anti-Pattern vs Refactored Standard

### ❌ Anti-Pattern (Duplicated UI & Logic)
```swift
// Card 1
VStack {
    Text(french)
    Text(english)
    Button(action: { speechService.speak(french) }) { ... }
}
.padding()
.background(Color.gray.opacity(0.1))
.cornerRadius(12)

// Card 2 (Duplicated identical view block)
VStack {
    Text(french2)
    Text(english2)
    Button(action: { speechService.speak(french2) }) { ... }
}
.padding()
.background(Color.gray.opacity(0.1))
.cornerRadius(12)
```

### ✅ Refactored Standard (Extracted Reusable Component)
```swift
struct SentenceRowView: View {
    let french: String
    let english: String
    let phonetic: String?
    let onSpeak: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(french).font(.headline)
                Text(english).font(.subheadline).foregroundStyle(.secondary)
                if let phonetic {
                    Text(phonetic).font(.caption).foregroundStyle(.blue)
                }
            }
            Spacer()
            Button(action: onSpeak) {
                Image(systemName: "speaker.wave.2.fill")
            }
        }
        .neumorphicCard()
    }
}
```

---

## Checklist for Code Reviews
- [ ] No duplicated layout modifier stacks across views.
- [ ] Centralized color, font, and asset tokens.
- [ ] Business logic isolated from presentation views.
- [ ] Audio/speech interaction unified in single service manager.
