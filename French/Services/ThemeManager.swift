import SwiftUI
import UIKit
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
        case .systemLight: return Color(red: 0.93, green: 0.94, blue: 0.96) // Crisp soft off-white #ECF0F5
        case .systemDark: return Color(red: 0.11, green: 0.12, blue: 0.15)  // Rich dark #1C1E26
        case .creamSepia: return Color(red: 0.97, green: 0.93, blue: 0.84)  // Warm sepia #F7EDD6
        case .mintSage: return Color(red: 0.90, green: 0.94, blue: 0.91)    // Visual comfort sage #E6F0E8
        case .midnightSlate: return Color(red: 0.10, green: 0.13, blue: 0.18) // Midnight slate #1A212E
        }
    }

    // Card Surface Background
    var cardBackgroundColor: Color {
        switch self {
        case .systemLight: return Color(red: 0.98, green: 0.98, blue: 0.99) // #FBFBFD
        case .systemDark: return Color(red: 0.16, green: 0.18, blue: 0.22)  // #292E38
        case .creamSepia: return Color(red: 0.93, green: 0.88, blue: 0.77)  // #EDE0C4
        case .mintSage: return Color(red: 0.83, green: 0.89, blue: 0.85)    // #D4E3D9
        case .midnightSlate: return Color(red: 0.15, green: 0.19, blue: 0.26) // #263042
        }
    }

    // Primary Text (High Contrast 7:1+)
    var primaryTextColor: Color {
        switch self {
        case .systemLight: return Color(red: 0.10, green: 0.12, blue: 0.18) // Deep Navy Black
        case .systemDark: return Color(red: 0.96, green: 0.97, blue: 0.99)  // Pure Ice White
        case .creamSepia: return Color(red: 0.22, green: 0.15, blue: 0.08)  // Dark Espresso
        case .mintSage: return Color(red: 0.06, green: 0.18, blue: 0.12)    // Deep Pine Black
        case .midnightSlate: return Color(red: 0.92, green: 0.95, blue: 0.98) // Bright Ice White
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

    // Accent Color (Action Buttons, Phonetics, Highlights)
    var accentColor: Color {
        switch self {
        case .systemLight: return Color(red: 0.00, green: 0.45, blue: 0.90) // Royal Blue
        case .systemDark: return Color(red: 0.30, green: 0.65, blue: 1.00)  // Electric Blue
        case .creamSepia: return Color(red: 0.75, green: 0.42, blue: 0.10)  // Burnt Amber
        case .mintSage: return Color(red: 0.10, green: 0.50, blue: 0.32)    // Deep Emerald Green
        case .midnightSlate: return Color(red: 0.38, green: 0.72, blue: 0.98) // Ice Blue
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

    private init() {
        updateSystemAppearances()
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

        // Force main window scene redraw
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            for window in windowScene.windows {
                window.overrideUserInterfaceStyle = theme.isDark ? .dark : .light
            }
        }
    }
}
