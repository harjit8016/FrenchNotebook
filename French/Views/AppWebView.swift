import SwiftUI
import WebKit

// MARK: - YouTube Embed Helper

struct YouTubeEmbedHelper {
    static func extractVideoID(from urlString: String) -> String? {
        if urlString.contains("/shorts/") {
            let components = urlString.components(separatedBy: "/shorts/")
            if components.count > 1 {
                let id = components[1].components(separatedBy: "?")[0].components(separatedBy: "/")[0]
                if !id.isEmpty { return id }
            }
        }
        if urlString.contains("watch?v=") {
            let components = urlString.components(separatedBy: "watch?v=")
            if components.count > 1 {
                let id = components[1].components(separatedBy: "&")[0].components(separatedBy: "/")[0]
                if !id.isEmpty { return id }
            }
        }
        if urlString.contains("youtu.be/") {
            let components = urlString.components(separatedBy: "youtu.be/")
            if components.count > 1 {
                let id = components[1].components(separatedBy: "?")[0].components(separatedBy: "/")[0]
                if !id.isEmpty { return id }
            }
        }
        return nil
    }

    static func generateEmbedHTML(for videoID: String) -> String {
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
                }
            </style>
        </head>
        <body>
            <iframe id="yt-player"
                    src="https://www.youtube-nocookie.com/embed/\(videoID)?autoplay=1&playsinline=1&enablejsapi=1&rel=0&modestbranding=1"
                    frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                    allowfullscreen>
            </iframe>
        </body>
        </html>
        """
    }
}

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
                }
            </style>
        </head>
        <body>
            <iframe id="insta-frame"
                    src="https://www.instagram.com/p/\(reelID)/embed/"
                    width="100%"
                    height="100%"
                    frameborder="0"
                    scrolling="no"
                    allowtransparency="true"
                    allowfullscreen="true"
                    allow="autoplay; clipboard-write; encrypted-media; picture-in-picture; web-share">
            </iframe>
            <script async src="https://www.instagram.com/embed.js"></script>
        </body>
        </html>
        """
    }
}

// MARK: - Native Web View with YouTube & Instagram Embed Support

struct AppWebView: UIViewRepresentable {
    let url: URL
    let webView: WKWebView

    init(url: URL, webView: WKWebView = WKWebView()) {
        self.url = url
        self.webView = webView
    }

    func makeUIView(context: Context) -> WKWebView {
        let config = webView.configuration
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.allowsPictureInPictureMediaPlayback = true

        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1"
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false

        let urlString = url.absoluteString
        if let videoID = YouTubeEmbedHelper.extractVideoID(from: urlString) {
            let html = YouTubeEmbedHelper.generateEmbedHTML(for: videoID)
            webView.loadHTMLString(html, baseURL: URL(string: "https://www.youtube-nocookie.com"))
        } else if let reelID = InstagramEmbedHelper.extractReelID(from: urlString) {
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

// MARK: - Dedicated Web Detail Screen with Native Video Controls

struct WebViewDetailView: View {
    let link: SavedLink
    @ObservedObject private var themeManager = ThemeManager.shared
    @State private var webView = WKWebView()
    @State private var isPlaying: Bool = true
    @State private var useDirectWeb: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                themeManager.currentTheme.backgroundColor
                    .ignoresSafeArea()

                if let url = URL(string: link.urlString) {
                    if useDirectWeb {
                        DirectAppWebView(url: url, webView: webView)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal, 8)
                            .padding(.top, 8)
                    } else {
                        AppWebView(url: url, webView: webView)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal, 8)
                            .padding(.top, 8)
                    }
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

            // MARK: - Native Player Control Toolbar
            HStack(spacing: 20) {
                // Native Play / Pause Toggle
                Button {
                    HapticManager.shared.tapWord()
                    isPlaying.toggle()
                    let js = isPlaying ?
                        "(document.querySelector('video')?.play() || document.getElementById('yt-player')?.contentWindow?.postMessage('{\"event\":\"command\",\"func\":\"playVideo\",\"args\":\"\"}', '*'));" :
                        "(document.querySelector('video')?.pause() || document.getElementById('yt-player')?.contentWindow?.postMessage('{\"event\":\"command\",\"func\":\"pauseVideo\",\"args\":\"\"}', '*'));"
                    webView.evaluateJavaScript(js, completionHandler: nil)
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 16, weight: .bold))
                        Text(isPlaying ? "Pause" : "Play")
                            .font(themeManager.fontSizeScale.bodyFont.bold())
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .foregroundStyle(.white)
                    .background(themeManager.currentTheme.accentColor)
                    .clipShape(Capsule())
                }

                // Reload Player Button
                Button {
                    HapticManager.shared.tapWord()
                    webView.reload()
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                        .padding(10)
                        .appNeumorphicCard(cornerRadius: 20)
                }

                Spacer()

                // Toggle Direct Web / Embed Mode
                Button {
                    HapticManager.shared.tapWord()
                    useDirectWeb.toggle()
                } label: {
                    Text(useDirectWeb ? "Embed Mode" : "Direct Mode")
                        .font(themeManager.fontSizeScale.captionFont)
                        .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .appNeumorphicCard(cornerRadius: 10)
                }

                // Open in External Safari / YouTube / Instagram App
                if let url = URL(string: link.urlString) {
                    Link(destination: url) {
                        Image(systemName: "safari")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(themeManager.currentTheme.accentColor)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(themeManager.currentTheme.cardBackgroundColor)
        }
        .appBackground()
        .appNavigationStyle(title: link.title, displayMode: .inline)
    }
}

// MARK: - Direct App Web View (Fallback)

private struct DirectAppWebView: UIViewRepresentable {
    let url: URL
    let webView: WKWebView

    func makeUIView(context: Context) -> WKWebView {
        let config = webView.configuration
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1"
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
