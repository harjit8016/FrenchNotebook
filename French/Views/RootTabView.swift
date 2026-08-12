import SwiftUI

struct RootTabView: View {
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        TabView {
            NotebookView()
                .tabItem {
                    Label("Notebook", systemImage: "book.pages.fill")
                }

            ReferenceView()
                .tabItem {
                    Label("Reference", systemImage: "text.book.closed.fill")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .tint(themeManager.currentTheme.accentColor)
        .preferredColorScheme(themeManager.currentTheme.isDark ? .dark : .light)
    }
}

#Preview {
    RootTabView()
}
