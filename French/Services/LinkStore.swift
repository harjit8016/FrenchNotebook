import SwiftUI
import Combine

struct SavedLink: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    let urlString: String
    let title: String
    let platform: String // "YouTube", "Instagram", "Web"
    let dateAdded: Date
}

final class LinkStore: ObservableObject {
    static let shared = LinkStore()
    @Published var links: [SavedLink] = []

    private let storageKey = "SavedMediaLinksKey_v2"

    private init() {
        loadLinks()
    }

    func loadLinks() {
        let newInstagramURL = "https://www.instagram.com/reel/DZM4KtGsu-y/?utm_source=ig_web_copy_link&igsh=MzRlODBiNWFlZA=="

        if let data = UserDefaults.standard.data(forKey: storageKey),
           var decoded = try? JSONDecoder().decode([SavedLink].self, from: data),
           !decoded.isEmpty {
            // Automatically update any existing Instagram links to the new Reel URL
            for i in 0..<decoded.count {
                if decoded[i].platform == "Instagram" || decoded[i].urlString.contains("instagram.com") {
                    decoded[i] = SavedLink(
                        id: decoded[i].id,
                        urlString: newInstagramURL,
                        title: "French Instagram Reel",
                        platform: "Instagram",
                        dateAdded: decoded[i].dateAdded
                    )
                }
            }
            self.links = decoded
            saveLinks()
        } else {
            // Default pre-populated links requested by user
            self.links = [
                SavedLink(
                    urlString: "https://www.youtube.com/shorts/UWiGRO2k1_0",
                    title: "French Pronunciation Short",
                    platform: "YouTube",
                    dateAdded: Date()
                ),
                SavedLink(
                    urlString: newInstagramURL,
                    title: "French Instagram Reel",
                    platform: "Instagram",
                    dateAdded: Date()
                )
            ]
            saveLinks()
        }
    }

    func addLink(urlString: String, title: String) {
        var cleanURL = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
        if !cleanURL.lowercased().hasPrefix("http://") && !cleanURL.lowercased().hasPrefix("https://") {
            cleanURL = "https://" + cleanURL
        }

        let platform: String
        if cleanURL.contains("youtube.com") || cleanURL.contains("youtu.be") {
            platform = "YouTube"
        } else if cleanURL.contains("instagram.com") {
            platform = "Instagram"
        } else {
            platform = "Web"
        }

        let userTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let finalTitle = userTitle.isEmpty ? "\(platform) Lesson" : userTitle

        let newLink = SavedLink(
            urlString: cleanURL,
            title: finalTitle,
            platform: platform,
            dateAdded: Date()
        )
        links.insert(newLink, at: 0)
        saveLinks()
    }

    func deleteLink(_ link: SavedLink) {
        links.removeAll(where: { $0.id == link.id })
        saveLinks()
    }

    private func saveLinks() {
        if let data = try? JSONEncoder().encode(links) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
}
