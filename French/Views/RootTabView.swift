import SwiftUI

enum AppTab: Int, CaseIterable, Identifiable {
    case basics = 0
    case notebook = 1
    case reference = 2
    case links = 3
    case settings = 4

    var id: Int { rawValue }
}

struct RootTabView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    @State private var selectedTab: AppTab = .basics

    var body: some View {
        TabView(selection: $selectedTab) {
            BasicsView()
                .tabItem {
                    Label("Basics", systemImage: "sparkles")
                }
                .tag(AppTab.basics)

            NotebookView()
                .tabItem {
                    Label("Notebook", systemImage: "book.pages.fill")
                }
                .tag(AppTab.notebook)

            ReferenceView()
                .tabItem {
                    Label("Reference", systemImage: "text.book.closed.fill")
                }
                .tag(AppTab.reference)

            LinksView()
                .tabItem {
                    Label("Media", systemImage: "play.rectangle.fill")
                }
                .tag(AppTab.links)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(AppTab.settings)
        }
        .tint(themeManager.currentTheme.accentColor)
        .preferredColorScheme(themeManager.currentTheme.isDark ? .dark : .light)
    }
}

#Preview {
    RootTabView()
}
