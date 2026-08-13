import SwiftUI
import UIKit
import AVFoundation
import Combine

// MARK: - Custom Font Helper (Authentic Georgia Book Serif - Preinstalled on iOS)

extension Font {
    static func kindleContentFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        // Georgia is built into iOS and provides the exact sturdy slab-serif & high x-height of Kindle Bookerly
        if weight == .bold || weight == .semibold {
            return .custom("Georgia-Bold", size: size)
        } else {
            return .custom("Georgia", size: size)
        }
    }
}

// MARK: - App Theme Options (Kindle-Inspired Palettes)

enum AppTheme: String, CaseIterable, Identifiable, Codable {
    case systemLight = "Soft Light"
    case systemDark = "Dark Mode"
    case creamSepia = "Warm Cream"
    case mintSage = "Visual Comfort"
    case midnightSlate = "Midnight Slate"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .systemLight: return "sun.max.fill"
        case .systemDark: return "moon.fill"
        case .creamSepia: return "book.fill"
        case .mintSage: return "leaf.fill"
        case .midnightSlate: return "sparkles"
        }
    }

    // Canvas Background
    var backgroundColor: Color {
        switch self {
        case .systemLight: return Color(red: 0.93, green: 0.94, blue: 0.96)
        case .systemDark: return Color(red: 0.11, green: 0.12, blue: 0.15)
        case .creamSepia: return Color(red: 0.96, green: 0.93, blue: 0.85) // Kindle Warm Paper
        case .mintSage: return Color(red: 0.90, green: 0.94, blue: 0.91)
        case .midnightSlate: return Color(red: 0.10, green: 0.13, blue: 0.18)
        }
    }

    // Card Surface Background
    var cardBackgroundColor: Color {
        switch self {
        case .systemLight: return Color(red: 0.98, green: 0.98, blue: 0.99)
        case .systemDark: return Color(red: 0.16, green: 0.18, blue: 0.22)
        case .creamSepia: return Color(red: 0.91, green: 0.87, blue: 0.78)
        case .mintSage: return Color(red: 0.83, green: 0.89, blue: 0.85)
        case .midnightSlate: return Color(red: 0.15, green: 0.19, blue: 0.26)
        }
    }

    // Primary Text (Deep Ink Charcoal - High Contrast 7:1+)
    var primaryTextColor: Color {
        switch self {
        case .systemLight: return Color(red: 0.10, green: 0.12, blue: 0.18)
        case .systemDark: return Color(red: 0.96, green: 0.97, blue: 0.99)
        case .creamSepia: return Color(red: 0.14, green: 0.11, blue: 0.06) // Deep Kindle Charcoal
        case .mintSage: return Color(red: 0.06, green: 0.18, blue: 0.12)
        case .midnightSlate: return Color(red: 0.92, green: 0.95, blue: 0.98)
        }
    }

    // Secondary Text (Readable Subtitles)
    var secondaryTextColor: Color {
        switch self {
        case .systemLight: return Color(red: 0.40, green: 0.44, blue: 0.52)
        case .systemDark: return Color(red: 0.65, green: 0.70, blue: 0.78)
        case .creamSepia: return Color(red: 0.40, green: 0.32, blue: 0.18)
        case .mintSage: return Color(red: 0.22, green: 0.36, blue: 0.28)
        case .midnightSlate: return Color(red: 0.62, green: 0.70, blue: 0.78)
        }
    }

    // Accent Color (Action Buttons, Highlights, Active Tab Icon)
    var accentColor: Color {
        switch self {
        case .systemLight: return Color(red: 0.00, green: 0.45, blue: 0.90)
        case .systemDark: return Color(red: 0.30, green: 0.65, blue: 1.00)
        case .creamSepia: return Color(red: 0.72, green: 0.38, blue: 0.08)
        case .mintSage: return Color(red: 0.10, green: 0.50, blue: 0.32)
        case .midnightSlate: return Color(red: 0.38, green: 0.72, blue: 0.98)
        }
    }

    var isDark: Bool {
        self == .systemDark || self == .midnightSlate
    }
}

// MARK: - Font Size Scale Options (Authentic Georgia Book Serif Typography)

enum FontSizeScale: String, CaseIterable, Identifiable, Codable {
    case small = "Compact"
    case medium = "Standard"
    case large = "Large"
    case extraLarge = "Extra Large"

    var id: String { rawValue }

    var scaleFactor: CGFloat {
        switch self {
        case .small: return 0.9
        case .medium: return 1.0
        case .large: return 1.15
        case .extraLarge: return 1.3
        }
    }

    // 1. UI Controls & Navigation (Roboto / System Sans-Serif)
    var uiTitleFont: Font { Font.system(size: 17 * scaleFactor, weight: .bold, design: .default) }
    var uiButtonFont: Font { Font.system(size: 15 * scaleFactor, weight: .semibold, design: .default) }
    var uiLabelFont: Font { Font.system(size: 13.5 * scaleFactor, weight: .medium, design: .default) }

    // 2. Kindle Book Serif Content Typography (Authentic Georgia Book Serif)
    var contentTitleFont: Font { Font.kindleContentFont(size: 20.0 * scaleFactor, weight: .bold) }
    var contentBodyFont: Font { Font.kindleContentFont(size: 17.5 * scaleFactor, weight: .regular) }
    var contentPhoneticFont: Font { Font.kindleContentFont(size: 15.0 * scaleFactor, weight: .medium) }

    // Aliases
    var titleFont: Font { contentTitleFont }
    var bodyFont: Font { contentBodyFont }
    var captionFont: Font { uiLabelFont }

    // Generous Kindle E-Reader line height (1.50x) & relaxed tracking (+0.2pt)
    var lineSpacing: CGFloat { 7.5 * scaleFactor }
    var tracking: CGFloat { 0.2 }
}

// MARK: - Voice Model Helper

struct FrenchVoiceOption: Identifiable, Hashable {
    let id: String // voice.identifier or "" for system default
    let name: String
    let genderName: String
    let isDefault: Bool
}

// MARK: - Theme & Reader Environment Manager (Single Source of Truth)

final class ThemeManager: ObservableObject {
    static let shared = ThemeManager()

    @AppStorage("appThemeKey") var currentTheme: AppTheme = .systemLight {
        didSet {
            updateSystemAppearances()
            objectWillChange.send()
        }
    }

    @AppStorage("fontSizeScaleKey") var fontSizeScale: FontSizeScale = .medium {
        didSet { objectWillChange.send() }
    }

    // Default slow beginner pace (0.30x)
    @AppStorage("speechRateKey") var speechRate: Double = 0.30 {
        didSet { objectWillChange.send() }
    }

    @AppStorage("selectedVoiceIdentifierKey") var selectedVoiceIdentifier: String = "" {
        didSet { objectWillChange.send() }
    }

    private init() {
        updateSystemAppearances()
    }

    /// Curates a maximum of 5 distinct, deduplicated top quality French voice options.
    var availableFrenchVoices: [FrenchVoiceOption] {
        var options: [FrenchVoiceOption] = [
            FrenchVoiceOption(id: "", name: "System Default", genderName: "Auto / Native", isDefault: true)
        ]

        let allFrench = AVSpeechSynthesisVoice.speechVoices()
            .filter { $0.language.lowercased().hasPrefix("fr") }
            .sorted { v1, v2 in
                if v1.quality.rawValue != v2.quality.rawValue {
                    return v1.quality.rawValue > v2.quality.rawValue
                }
                return v1.name < v2.name
            }

        var seenNames = Set<String>()

        for voice in allFrench {
            if options.count >= 5 { break }

            let baseName = voice.name.trimmingCharacters(in: .whitespacesAndNewlines)
            if seenNames.contains(baseName) { continue }
            seenNames.insert(baseName)

            let genderStr: String
            switch voice.gender {
            case .female: genderStr = "Female Voice"
            case .male: genderStr = "Male Voice"
            default: genderStr = "Native Voice"
            }

            let regionTag = voice.language.contains("CA") ? " (Canada)" : (voice.language.contains("FR") ? " (France)" : "")
            let qualityTag = voice.quality == .enhanced ? " • Enhanced" : (voice.quality == .premium ? " • Premium" : "")

            let option = FrenchVoiceOption(
                id: voice.identifier,
                name: "\(baseName)\(regionTag)\(qualityTag)",
                genderName: genderStr,
                isDefault: false
            )
            options.append(option)
        }
        return options
    }

    func updateSystemAppearances() {
        let theme = currentTheme

        // Navigation Bar Appearance (Roboto / System Sans-Serif)
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = UIColor(theme.backgroundColor)
        let navFont = UIFont.systemFont(ofSize: 17, weight: .bold)
        navAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(theme.primaryTextColor),
            .font: navFont
        ]
        navAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(theme.primaryTextColor),
            .font: UIFont.systemFont(ofSize: 26, weight: .bold)
        ]
        
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance

        // Tab Bar Appearance (Roboto / System Sans-Serif)
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(theme.backgroundColor)
        
        let itemAppearance = UITabBarItemAppearance()
        let tabFont = UIFont.systemFont(ofSize: 10.5, weight: .semibold)
        itemAppearance.normal.iconColor = UIColor(theme.secondaryTextColor)
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(theme.secondaryTextColor), .font: tabFont]
        itemAppearance.selected.iconColor = UIColor(theme.accentColor)
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(theme.accentColor), .font: tabFont]
        
        tabBarAppearance.stackedLayoutAppearance = itemAppearance
        tabBarAppearance.inlineLayoutAppearance = itemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = itemAppearance

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            for window in windowScene.windows {
                window.overrideUserInterfaceStyle = theme.isDark ? .dark : .light
                if let rootVC = window.rootViewController {
                    self.updateVC(rootVC, theme: theme, appearance: tabBarAppearance)
                }
            }
        }
    }

    private func updateVC(_ vc: UIViewController, theme: AppTheme, appearance: UITabBarAppearance) {
        if let tabBarVC = vc as? UITabBarController {
            tabBarVC.tabBar.standardAppearance = appearance
            tabBarVC.tabBar.scrollEdgeAppearance = appearance
            tabBarVC.tabBar.tintColor = UIColor(theme.accentColor)
            tabBarVC.tabBar.unselectedItemTintColor = UIColor(theme.secondaryTextColor)
            tabBarVC.tabBar.setNeedsLayout()
            tabBarVC.tabBar.layoutIfNeeded()
        }
        for child in vc.children {
            updateVC(child, theme: theme, appearance: appearance)
        }
    }
}
