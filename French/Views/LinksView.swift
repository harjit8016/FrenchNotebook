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

// MARK: - Main Media Links View (Multi-Select & Native iOS Share)

struct LinksView: View {
    @ObservedObject private var store = LinkStore.shared
    @ObservedObject private var themeManager = ThemeManager.shared
    @State private var showAddSheet: Bool = false

    // Multi-Selection State
    @State private var isSelectionMode: Bool = false
    @State private var selectedIDs: Set<UUID> = []

    // Native iOS Share Sheet State
    @State private var shareItems: [Any] = []
    @State private var showShareSheet: Bool = false

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    private var allSelected: Bool {
        !store.links.isEmpty && selectedIDs.count == store.links.count
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(store.links) { link in
                            let isSelected = selectedIDs.contains(link.id)

                            Group {
                                if isSelectionMode {
                                    Button {
                                        HapticManager.shared.tapWord()
                                        toggleSelection(for: link.id)
                                    } label: {
                                        LinkCardView(link: link, isSelectionMode: true, isSelected: isSelected)
                                    }
                                    .buttonStyle(.plain)
                                } else {
                                    NavigationLink(destination: WebViewDetailView(link: link)) {
                                        LinkCardView(link: link, isSelectionMode: false, isSelected: false)
                                    }
                                    .buttonStyle(.plain)
                                    .contextMenu {
                                        Button {
                                            shareSingleLink(link)
                                        } label: {
                                            Label("Share Link", systemImage: "square.and.arrow.up")
                                        }

                                        Button {
                                            UIPasteboard.general.string = link.urlString
                                            HapticManager.shared.tapWord()
                                        } label: {
                                            Label("Copy Link", systemImage: "doc.on.doc")
                                        }

                                        Button(role: .destructive) {
                                            store.deleteLink(link)
                                        } label: {
                                            Label("Delete Link", systemImage: "trash")
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .padding(.bottom, isSelectionMode ? 85 : 12)
                }

                // Floating Bottom Action Bar in Selection Mode
                if isSelectionMode {
                    HStack {
                        Button {
                            HapticManager.shared.tapWord()
                            toggleSelectAll()
                        } label: {
                            Text(allSelected ? "Deselect All" : "Select All")
                                .font(themeManager.fontSizeScale.bodyFont.bold())
                                .foregroundStyle(themeManager.currentTheme.accentColor)
                        }

                        Spacer()

                        Text("\(selectedIDs.count) Selected")
                            .font(themeManager.fontSizeScale.captionFont)
                            .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                        Spacer()

                        Button {
                            HapticManager.shared.tapWord()
                            shareSelectedLinks()
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 15, weight: .bold))
                                Text("Share (\(selectedIDs.count))")
                                    .font(themeManager.fontSizeScale.bodyFont.bold())
                            }
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(selectedIDs.isEmpty ? Color.gray.opacity(0.5) : themeManager.currentTheme.accentColor)
                            .clipShape(Capsule())
                        }
                        .disabled(selectedIDs.isEmpty)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .appFloatingCard(cornerRadius: 24)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            .animation(.spring(response: 0.35, dampingFraction: 0.8), value: isSelectionMode)
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: selectedIDs)
            .appBackground()
            .appNavigationStyle(title: isSelectionMode ? "\(selectedIDs.count) Selected" : "Media Links", displayMode: .inline)
            .toolbar {
                if isSelectionMode {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(allSelected ? "Deselect All" : "Select All") {
                            HapticManager.shared.tapWord()
                            toggleSelectAll()
                        }
                        .foregroundStyle(themeManager.currentTheme.accentColor)
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            HapticManager.shared.tapWord()
                            isSelectionMode = false
                            selectedIDs.removeAll()
                        }
                        .bold()
                        .foregroundStyle(themeManager.currentTheme.accentColor)
                    }
                } else {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Select") {
                            HapticManager.shared.tapWord()
                            isSelectionMode = true
                        }
                        .foregroundStyle(themeManager.currentTheme.accentColor)
                    }

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
            }
            .sheet(isPresented: $showAddSheet) {
                AddLinkSheetView()
            }
            .sheet(isPresented: $showShareSheet) {
                ActivityViewController(activityItems: shareItems)
            }
        }
    }

    private func toggleSelection(for id: UUID) {
        if selectedIDs.contains(id) {
            selectedIDs.remove(id)
        } else {
            selectedIDs.insert(id)
        }
    }

    private func toggleSelectAll() {
        if allSelected {
            selectedIDs.removeAll()
        } else {
            selectedIDs = Set(store.links.map { $0.id })
        }
    }

    private func shareSingleLink(_ link: SavedLink) {
        if let url = URL(string: link.urlString) {
            shareItems = [link.title, url]
        } else {
            shareItems = ["\(link.title): \(link.urlString)"]
        }
        showShareSheet = true
    }

    private func shareSelectedLinks() {
        let chosenLinks = store.links.filter { selectedIDs.contains($0.id) }
        guard !chosenLinks.isEmpty else { return }

        if chosenLinks.count == 1, let single = chosenLinks.first {
            shareSingleLink(single)
            return
        }

        var formattedText = "📱 French Learning Media Links:\n\n"
        var itemsToShare: [Any] = []

        for (index, link) in chosenLinks.enumerated() {
            formattedText += "\(index + 1). \(link.title)\n\(link.urlString)\n\n"
            if let url = URL(string: link.urlString) {
                itemsToShare.append(url)
            }
        }

        itemsToShare.insert(formattedText, at: 0)
        shareItems = itemsToShare
        showShareSheet = true
    }
}

// MARK: - 2-Column Rich Thumbnail Link Card View with Selection Overlay

private struct LinkCardView: View {
    let link: SavedLink
    var isSelectionMode: Bool = false
    var isSelected: Bool = false
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

                // Overlay Play Button Icon (when not selecting)
                if !isSelectionMode {
                    ZStack {
                        Circle()
                            .fill(Color.black.opacity(0.55))
                            .frame(width: 38, height: 38)

                        Image(systemName: "play.fill")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }

                // Selection Checkmark Circle Badge (Top-Left)
                if isSelectionMode {
                    VStack {
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(isSelected ? themeManager.currentTheme.accentColor : Color.black.opacity(0.50))
                                    .frame(width: 26, height: 26)

                                Image(systemName: isSelected ? "checkmark" : "circle")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                            .padding(8)

                            Spacer()
                        }
                        Spacer()
                    }
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
        .appNeumorphicCard(cornerRadius: 14, isPressed: isSelected)
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

                        TextField(
                            "",
                            text: $urlString,
                            prompt: Text("https://youtube.com/shorts/... or instagram.com/...")
                                .foregroundColor(themeManager.currentTheme.secondaryTextColor.opacity(0.55))
                        )
                        .font(themeManager.fontSizeScale.bodyFont)
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        .padding(12)
                        .appNeumorphicCard(cornerRadius: 10)
                        .autocapitalization(.none)
                        .keyboardType(.URL)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Title (Optional)")
                            .font(themeManager.fontSizeScale.captionFont)
                            .foregroundStyle(themeManager.currentTheme.secondaryTextColor)

                        TextField(
                            "",
                            text: $title,
                            prompt: Text("e.g., French Pronunciation Lesson")
                                .foregroundColor(themeManager.currentTheme.secondaryTextColor.opacity(0.55))
                        )
                        .font(themeManager.fontSizeScale.bodyFont)
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
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
