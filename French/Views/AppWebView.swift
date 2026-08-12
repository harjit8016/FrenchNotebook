import SwiftUI
import WebKit

// MARK: - Instagram Embed Helper

struct InstagramEmbedHelper {
    static func extractReelID(from urlString: String) -> String? {
        if urlString.contains("instagram.com/reel/") {
            let components = urlString.components(separatedBy: "instagram.com/reel/")
            if components.count > 1 {
                let rawID = components[1].components(separatedBy: "?")[0].components(separatedBy: "/")[0]
                if !rawID.isEmpty { return rawID }
            }
        }
        if urlString.contains("instagram.com/p/") {
            let components = urlString.components(separatedBy: "instagram.com/p/")
            if components.count > 1 {
                let rawID = components[1].components(separatedBy: "?")[0].components(separatedBy: "/")[0]
                if !rawID.isEmpty { return rawID }
            }
        }
        return nil
    }

    static func generateEmbedHTML(for reelID: String) -> String {
        return """
        <!DOCTYPE html>
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
            <style>
                html, body {
                    margin: 0;
                    padding: 0;
                    width: 100%;
                    height: 100%;
                    background-color: #000000;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    overflow: hidden;
                }
                iframe {
                    border: none;
                    width: 100%;
                    height: 100%;
                    max-width: 500px;
                }
            </style>
        </head>
        <body>
            <iframe src="https://www.instagram.com/reel/\(reelID)/embed/captioned/"
                    frameborder="0"
                    scrolling="no"
                    allowtransparency="true"
                    allowfullscreen="true">
            </iframe>
            <script async src="https://www.instagram.com/embed.js"></script>
        </body>
        </html>
        """
    }
}

// MARK: - Native Web View with Instagram Embed Support

struct AppWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false

        let urlString = url.absoluteString
        if let reelID = InstagramEmbedHelper.extractReelID(from: urlString) {
            let html = InstagramEmbedHelper.generateEmbedHTML(for: reelID)
            webView.loadHTMLString(html, baseURL: URL(string: "https://www.instagram.com"))
        } else {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

// MARK: - Dedicated Web Detail Screen

struct WebViewDetailView: View {
    let link: SavedLink
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        ZStack {
            themeManager.currentTheme.backgroundColor
                .ignoresSafeArea()

            if let url = URL(string: link.urlString) {
                AppWebView(url: url)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 8)
                    .padding(.bottom, 8)
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.orange)
                    Text("Invalid URL")
                        .font(themeManager.fontSizeScale.titleFont)
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                }
            }
        }
        .appBackground()
        .appNavigationStyle(title: link.title, displayMode: .inline)
    }
}
