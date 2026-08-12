import SwiftUI

struct LinksView: View {
    @ObservedObject private var store = LinkStore.shared
    @ObservedObject private var themeManager = ThemeManager.shared
    @State private var showAddSheet: Bool = false

    private let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(store.links) { link in
                        NavigationLink(destination: WebViewDetailView(link: link)) {
                            LinkCardView(link: link)
                        }
                        .buttonStyle(.plain)
                        .contextMenu {
                            Button(role: .destructive) {
                                store.deleteLink(link)
                            } label: {
                                Label("Delete Link", systemImage: "trash")
                            }
                        }
                    }
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
            }
            .appBackground()
            .appNavigationStyle(title: "Media Links", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        HapticManager.shared.tapWord()
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                            .foregroundStyle(themeManager.currentTheme.accentColor)
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                AddLinkSheetView()
            }
        }
    }
}

// MARK: - 2-Column Link Card View

private struct LinkCardView: View {
    let link: SavedLink
    @ObservedObject private var themeManager = ThemeManager.shared

    private var platformIcon: String {
        switch link.platform {
        case "YouTube": return "play.tv.fill"
        case "Instagram": return "camera.fill"
        default: return "link.circle.fill"
        }
    }

    private var platformColor: Color {
        switch link.platform {
        case "YouTube": return .red
        case "Instagram": return .purple
        default: return themeManager.currentTheme.accentColor
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                ZStack {
                    Circle()
                        .fill(platformColor.opacity(0.12))
                        .frame(width: 36, height: 36)

                    Image(systemName: platformIcon)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(platformColor)
                }

                Spacer()

                Text(link.platform)
                    .font(.caption2.bold())
                    .foregroundStyle(platformColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(platformColor.opacity(0.1))
                    .clipShape(Capsule())
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(link.title)
                    .font(themeManager.fontSizeScale.bodyFont.bold())
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                Text(link.urlString)
                    .font(.caption2)
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                    .lineLimit(1)
            }

            HStack {
                Spacer()
                Image(systemName: "play.circle.fill")
                    .font(.caption.bold())
                    .foregroundStyle(themeManager.currentTheme.accentColor)
            }
        }
        .padding(12)
        .appNeumorphicCard(cornerRadius: 14)
    }
}

// MARK: - Add Link Sheet View

private struct AddLinkSheetView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var store = LinkStore.shared
    @ObservedObject private var themeManager = ThemeManager.shared

    @State private var urlString: String = ""
    @State private var title: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                themeManager.currentTheme.backgroundColor
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Link URL")
                            .font(themeManager.fontSizeScale.captionFont)
                            .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                        TextField("https://youtube.com/shorts/... or instagram.com/...", text: $urlString)
                            .font(themeManager.fontSizeScale.bodyFont)
                            .padding(12)
                            .appNeumorphicCard(cornerRadius: 10)
                            .autocapitalization(.none)
                            .keyboardType(.URL)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Title (Optional)")
                            .font(themeManager.fontSizeScale.captionFont)
                            .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                        TextField("e.g., French Pronunciation Lesson", text: $title)
                            .font(themeManager.fontSizeScale.bodyFont)
                            .padding(12)
                            .appNeumorphicCard(cornerRadius: 10)
                    }

                    Spacer()

                    Button {
                        HapticManager.shared.tapWord()
                        if !urlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            store.addLink(urlString: urlString, title: title)
                            dismiss()
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Save Link")
                                .font(themeManager.fontSizeScale.bodyFont.bold())
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .padding(.vertical, 14)
                        .background(urlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray : themeManager.currentTheme.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .disabled(urlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .buttonStyle(.plain)
                }
                .padding()
            }
            .navigationTitle("Add New Link")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(themeManager.currentTheme.accentColor)
                }
            }
            .appNavigationStyle(title: "Add New Link", displayMode: .inline)
        }
    }
}

#Preview {
    LinksView()
}
