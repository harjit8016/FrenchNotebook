import SwiftUI
import LinkPresentation

// MARK: - Link Metadata Loader & Helper

struct LinkMetadataHelper {
    static func getYouTubeThumbnailURL(from urlString: String) -> URL? {
        if urlString.contains("/shorts/") {
            let components = urlString.components(separatedBy: "/shorts/")
            if components.count > 1 {
                let id = components[1].components(separatedBy: "?")[0].components(separatedBy: "/")[0]
                return URL(string: "https://img.youtube.com/vi/\(id)/hqdefault.jpg")
            }
        } else if urlString.contains("watch?v=") {
            let components = urlString.components(separatedBy: "watch?v=")
            if components.count > 1 {
                let id = components[1].components(separatedBy: "&")[0].components(separatedBy: "/")[0]
                return URL(string: "https://img.youtube.com/vi/\(id)/hqdefault.jpg")
            }
        } else if urlString.contains("youtu.be/") {
            let components = urlString.components(separatedBy: "youtu.be/")
            if components.count > 1 {
                let id = components[1].components(separatedBy: "?")[0].components(separatedBy: "/")[0]
                return URL(string: "https://img.youtube.com/vi/\(id)/hqdefault.jpg")
            }
        }
        return nil
    }
}

// MARK: - Main Media Links View (2-Column Grid)

struct LinksView: View {
    @ObservedObject private var store = LinkStore.shared
    @ObservedObject private var themeManager = ThemeManager.shared
    @State private var showAddSheet: Bool = false

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
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

// MARK: - 2-Column Rich Thumbnail Link Card View

private struct LinkCardView: View {
    let link: SavedLink
    @ObservedObject private var themeManager = ThemeManager.shared

    private var thumbnailURL: URL? {
        LinkMetadataHelper.getYouTubeThumbnailURL(from: link.urlString)
    }

    private var platformIcon: String {
        switch link.platform {
        case "YouTube": return "play.tv.fill"
        case "Instagram": return "camera.fill"
        default: return "link.circle.fill"
        }
    }

    private var platformColor: Color {
        switch link.platform {
        case "YouTube": return Color(red: 0.90, green: 0.15, blue: 0.15)
        case "Instagram": return Color(red: 0.70, green: 0.20, blue: 0.65)
        default: return themeManager.currentTheme.accentColor
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top Thumbnail Preview Container
            ZStack {
                if let thumbnailURL = thumbnailURL {
                    AsyncImage(url: thumbnailURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure, .empty:
                            thumbnailPlaceholder
                        @unknown default:
                            thumbnailPlaceholder
                        }
                    }
                    .frame(height: 115)
                    .clipped()
                } else {
                    thumbnailPlaceholder
                }

                // Dark overlay gradient for contrast
                Color.black.opacity(0.2)

                // Overlay Play Button Icon
                ZStack {
                    Circle()
                        .fill(Color.black.opacity(0.55))
                        .frame(width: 38, height: 38)

                    Image(systemName: "play.fill")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)
                }

                // Platform Badge at Top Right
                VStack {
                    HStack {
                        Spacer()
                        Text(link.platform)
                            .font(.caption2.bold())
                            .foregroundStyle(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(platformColor.opacity(0.9))
                            .clipShape(Capsule())
                            .padding(6)
                    }
                    Spacer()
                }
            }
            .frame(height: 115)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            // Bottom Title & Meta Info Container
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
            .padding(10)
        }
        .appNeumorphicCard(cornerRadius: 14)
    }

    @ViewBuilder
    private var thumbnailPlaceholder: some View {
        ZStack {
            LinearGradient(
                colors: [platformColor.opacity(0.8), platformColor.opacity(0.4)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Image(systemName: platformIcon)
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white.opacity(0.85))
        }
        .frame(height: 115)
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
