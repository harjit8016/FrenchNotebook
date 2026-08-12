import SwiftUI
import UIKit
import AVFoundation
import Combine

// MARK: - App Theme Options (5 Readers' Favorites)

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
        case .creamSepia: return Color(red: 0.97, green: 0.93, blue: 0.84)
        case .mintSage: return Color(red: 0.90, green: 0.94, blue: 0.91)
        case .midnightSlate: return Color(red: 0.10, green: 0.13, blue: 0.18)
        }
    }

    // Card Surface Background
    var cardBackgroundColor: Color {
        switch self {
        case .systemLight: return Color(red: 0.98, green: 0.98, blue: 0.99)
        case .systemDark: return Color(red: 0.16, green: 0.18, blue: 0.22)
        case .creamSepia: return Color(red: 0.93, green: 0.88, blue: 0.77)
        case .mintSage: return Color(red: 0.83, green: 0.89, blue: 0.85)
        case .midnightSlate: return Color(red: 0.15, green: 0.19, blue: 0.26)
        }
    }

    // Primary Text (High Contrast 7:1+)
    var primaryTextColor: Color {
        switch self {
        case .systemLight: return Color(red: 0.10, green: 0.12, blue: 0.18)
        case .systemDark: return Color(red: 0.96, green: 0.97, blue: 0.99)
        case .creamSepia: return Color(red: 0.22, green: 0.15, blue: 0.08)
        case .mintSage: return Color(red: 0.06, green: 0.18, blue: 0.12)
        case .midnightSlate: return Color(red: 0.92, green: 0.95, blue: 0.98)
        }
    }

    // Secondary Text (Readable Subtitles)
    var secondaryTextColor: Color {
        switch self {
        case .systemLight: return Color(red: 0.40, green: 0.44, blue: 0.52)
        case .systemDark: return Color(red: 0.65, green: 0.70, blue: 0.78)
        case .creamSepia: return Color(red: 0.46, green: 0.36, blue: 0.24)
        case .mintSage: return Color(red: 0.22, green: 0.36, blue: 0.28)
        case .midnightSlate: return Color(red: 0.62, green: 0.70, blue: 0.78)
        }
    }

    // Accent Color (Action Buttons, Highlights, Active Tab Icon)
    var accentColor: Color {
        switch self {
        case .systemLight: return Color(red: 0.00, green: 0.45, blue: 0.90)
        case .systemDark: return Color(red: 0.30, green: 0.65, blue: 1.00)
        case .creamSepia: return Color(red: 0.75, green: 0.42, blue: 0.10)
        case .mintSage: return Color(red: 0.10, green: 0.50, blue: 0.32)
        case .midnightSlate: return Color(red: 0.38, green: 0.72, blue: 0.98)
        }
    }

    var isDark: Bool {
        self == .systemDark || self == .midnightSlate
    }
}

// MARK: - Font Size Scale Options

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

    var titleFont: Font { Font.system(size: 19 * scaleFactor, weight: .bold) }
    var bodyFont: Font { Font.system(size: 15 * scaleFactor) }
    var captionFont: Font { Font.system(size: 13 * scaleFactor, weight: .medium) }
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

    @AppStorage("speechRateKey") var speechRate: Double = 0.42 {
        didSet { objectWillChange.send() }
    }

    @AppStorage("selectedVoiceIdentifierKey") var selectedVoiceIdentifier: String = "" {
        didSet { objectWillChange.send() }
    }

    private init() {
        updateSystemAppearances()
    }

    /// Curates a maximum of 5 top quality French voice options.
    var availableFrenchVoices: [FrenchVoiceOption] {
        var options: [FrenchVoiceOption] = [
            FrenchVoiceOption(id: "", name: "System Default", genderName: "Auto / Native", isDefault: true)
        ]

        let installedVoices = AVSpeechSynthesisVoice.speechVoices()
            .filter { $0.language.hasPrefix("fr") }
            .sorted { v1, v2 in
                if v1.quality.rawValue != v2.quality.rawValue {
                    return v1.quality.rawValue > v2.quality.rawValue
                }
                return v1.name < v2.name
            }

        for voice in installedVoices {
            if options.count >= 5 { break } // Max 5 curated options!

            let genderStr: String
            switch voice.gender {
            case .female: genderStr = "Female Voice"
            case .male: genderStr = "Male Voice"
            default: genderStr = "Native Voice"
            }
            let qualityStr = voice.quality == .enhanced ? " (Enhanced)" : (voice.quality == .premium ? " (Premium)" : "")
            let option = FrenchVoiceOption(
                id: voice.identifier,
                name: "\(voice.name)\(qualityStr)",
                genderName: genderStr,
                isDefault: false
            )
            if !options.contains(where: { $0.id == option.id }) {
                options.append(option)
            }
        }
        return options
    }

    func updateSystemAppearances() {
        let theme = currentTheme

        // Navigation Bar Appearance
        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = UIColor(theme.backgroundColor)
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor(theme.primaryTextColor)]
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(theme.primaryTextColor)]
        
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance

        // Tab Bar Appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(theme.backgroundColor)
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor(theme.secondaryTextColor)
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(theme.secondaryTextColor)]
        itemAppearance.selected.iconColor = UIColor(theme.accentColor)
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(theme.accentColor)]
        
        tabBarAppearance.stackedLayoutAppearance = itemAppearance
        tabBarAppearance.inlineLayoutAppearance = itemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = itemAppearance

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

        // Force in-place window & tab bar redraw on main thread without view hierarchy destruction
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
