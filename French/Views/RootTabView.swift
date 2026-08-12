import SwiftUI

enum AppTab: Int, CaseIterable, Identifiable {
    case notebook = 0
    case reference = 1
    case links = 2
    case settings = 3

    var id: Int { rawValue }
}

struct RootTabView: View {
    @ObservedObject private var themeManager = ThemeManager.shared
    @State private var selectedTab: AppTab = .notebook

    var body: some View {
        TabView(selection: $selectedTab) {
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
