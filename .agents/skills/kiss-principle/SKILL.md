---
name: kiss-principle
description: Standards and guidelines for Keep It Simple, Stupid (KISS) principle in UI architecture and software engineering.
---

# KISS (Keep It Simple, Stupid) Principle Skill

This skill defines standards for maintaining simplicity, clarity, and low cognitive overhead in software engineering and user interface design.

## Core Rules

### 1. Eliminate Unnecessary Friction & Bloat
- Avoid artificial user barriers such as locking content, requiring arbitrary XP points, or forcing quiz steps when the user simply wants to read, learn, and revise.
- Prefer straightforward notebook/reader navigation layouts over nested modals and multi-step dialog flows.

### 2. Predictable State Management
- Keep view state local and minimal. Avoid complex nested `@StateObject` dependencies when simple `@State` or `@Binding` suffices.
- Avoid over-architecting simple view hierarchies with redundant view models for static data presentation.

### 3. Clear & Readable Control Flow
- Write concise, readable functions that do one simple thing.
- Prefer explicit names over cryptic abbreviations.

---

## Directives for UI & App Architecture

- **Direct Content Access**: Users should be able to open the app like a notebook, browse any chapter immediately, tap to listen to pronunciation, and read translations without friction.
- **Readable Layouts**: Present full sentences, clear translations, and audio controls inline in card rows.
- **Zero Hidden Dependencies**: Make external data dependencies explicit and straightforward.

---

## Checklist for Code Reviews
- [ ] Is this feature or abstraction strictly necessary for the user's primary goal?
- [ ] Can this complex view hierarchy be simplified into a clean list/scrollview?
- [ ] Are state variables minimal and clearly scoped?
- [ ] Can a learner use the application effortlessly without tutorial popups or artificial locks?
