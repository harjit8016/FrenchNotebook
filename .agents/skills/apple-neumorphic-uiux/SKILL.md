---
name: apple-neumorphic-uiux
description: Guidelines and best practices for Apple Human Interface Guidelines (HIG) combined with Neumorphic (Soft UI) visual design aesthetics.
---

# Apple HIG + Neumorphic UI/UX Skill

This skill defines standards for designing Apple-compliant iOS and macOS user interfaces using a refined **Neumorphic (Soft UI)** visual style.

## Core Design Principles

### 1. Apple Human Interface Guidelines (HIG) Alignment
- **Clarity**: Text is legible at every size, icons are precise, highlights indicate function, and purpose drives design.
- **Deference**: Fluid movement and a crisp, clean interface help users understand and interact with content without competing with it.
- **Depth**: Distinct visual layers and realistic motion impart vitality and heighten understanding.
- **Accessibility**: Support Dynamic Type, ensure contrast ratios meet WCAG AA standard (4.5:1 for body text), and preserve accessibility labels for VoiceOver.

### 2. Neumorphic (Soft UI) Aesthetics
Neumorphic design creates the illusion of extruded shapes from the background surface using soft dual light and dark shadows.

- **Light Source Consistency**: Simulate a top-left light source (135° angle).
- **Dual Shadow System**:
  - **Top-Left Highlight**: Soft white/light shadow (`Color.white.opacity(0.7)` or `.opacity(0.15)` in dark mode) offset by negative x/y values (e.g. `x: -6, y: -6`).
  - **Bottom-Right Shadow**: Soft dark shadow (`Color.black.opacity(0.15)`) offset by positive x/y values (e.g. `x: 6, y: 6`).
- **Canvas Tone**: Use soft off-white canvas tones (e.g., `#EBEEF5` in light mode, `#1E222A` in dark mode) rather than stark `#FFFFFF` or `#000000`.
- **Tactile Interaction**:
  - **Unpressed / Default State**: Convex outset shadow (element appears floating slightly above background).
  - **Pressed / Active State**: Inset shadow effect or scale transform down to `0.97` with softened outset shadow to mimic a physical button press.

---

## Code Examples (SwiftUI Implementation)

### Neumorphic Modifier Standard
```swift
import SwiftUI

struct NeumorphicCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 16
    var isPressed: Bool = false

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color("NeumorphicBackground"))
                    .shadow(color: Color.white.opacity(0.7), radius: isPressed ? 2 : 6, x: isPressed ? -2 : -5, y: isPressed ? -2 : -5)
                    .shadow(color: Color.black.opacity(0.15), radius: isPressed ? 2 : 6, x: isPressed ? 2 : 5, y: isPressed ? 2 : 5)
            )
    }
}

extension View {
    func neumorphicCard(cornerRadius: CGFloat = 16, isPressed: Bool = false) -> some View {
        self.modifier(NeumorphicCardModifier(cornerRadius: cornerRadius, isPressed: isPressed))
    }
}
```

---

## Checklist for UI/UX Reviews
- [ ] Light source direction is consistent across all cards and buttons.
- [ ] Contrast ratio between text and neumorphic background passes accessibility checks.
- [ ] Interactive elements provide clear haptic and visual feedback on tap.
- [ ] Typography uses SF Pro / System font with proper hierarchy (`.title`, `.headline`, `.subheadline`, `.body`).
- [ ] Views support both Light Mode and Dark Mode smoothly.
