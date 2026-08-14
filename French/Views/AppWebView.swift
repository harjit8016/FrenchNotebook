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

// MARK: - Native Web View with Auto-Unmute & Interactive Video Playback

struct AppWebView: UIViewRepresentable {
    let url: URL
    let webView: WKWebView

    init(url: URL, webView: WKWebView = WKWebView()) {
        self.url = url
        self.webView = webView
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let config = webView.configuration
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.allowsPictureInPictureMediaPlayback = true

        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator

        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false

        let urlString = url.absoluteString
        if let videoID = YouTubeEmbedHelper.extractVideoID(from: urlString) {
            let html = YouTubeEmbedHelper.generateEmbedHTML(for: videoID)
            webView.loadHTMLString(html, baseURL: URL(string: "https://www.youtube-nocookie.com"))
        } else {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            let js = """
            (function() {
                function unmuteAndPlay() {
                    // Click "Continue on web" or "Watch on Instagram" if present
                    const buttons = document.querySelectorAll('button, a, div[role="button"]');
                    for (let btn of buttons) {
                        const text = (btn.innerText || '').toLowerCase();
                        if (text.includes('continue on web') || text.includes('watch on web') || text === 'continue' || text === 'not now') {
                            try { btn.click(); } catch(e) {}
                        }
                    }

                    // Unmute and play video elements automatically
                    const videos = document.getElementsByTagName('video');
                    for (let vid of videos) {
                        vid.playsInline = true;
                        vid.muted = false;
                        vid.volume = 1.0;

                        var promise = vid.play();
                        if (promise !== undefined) {
                            promise.catch(function(error) {
                                vid.muted = true;
                                vid.play().then(function() {
                                    setTimeout(function() { vid.muted = false; }, 300);
                                }).catch(function(){});
                            });
                        }
                    }
                }

                unmuteAndPlay();
                var count = 0;
                var interval = setInterval(function() {
                    unmuteAndPlay();
                    count++;
                    if (count > 8) clearInterval(interval);
                }, 300);
            })();
            """
            webView.evaluateJavaScript(js, completionHandler: nil)
        }

        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let targetURL = navigationAction.request.url {
                let scheme = targetURL.scheme?.lowercased() ?? ""
                if scheme == "instagram" || scheme == "youtube" {
                    decisionHandler(.cancel)
                    return
                }
            }
            decisionHandler(.allow)
        }
    }
}

// MARK: - Dedicated Web Detail Screen (Clean HIG Top Navigation, Zero Bottom Toolbar Clutter)

struct WebViewDetailView: View {
    let link: SavedLink
    @ObservedObject private var themeManager = ThemeManager.shared
    @State private var webView = WKWebView()
    @State private var showShareSheet: Bool = false

    var body: some View {
        ZStack {
            themeManager.currentTheme.backgroundColor
                .ignoresSafeArea()

            if let url = URL(string: link.urlString) {
                AppWebView(url: url, webView: webView)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
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
        .sheet(isPresented: $showShareSheet) {
            if let url = URL(string: link.urlString) {
                ActivityViewController(activityItems: [link.title, url])
            } else {
                ActivityViewController(activityItems: [link.title, link.urlString])
            }
        }
        .appBackground()
        .appNavigationStyle(title: link.title, displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    HapticManager.shared.tapWord()
                    showShareSheet = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(themeManager.currentTheme.accentColor)
                }

                if let url = URL(string: link.urlString) {
                    Link(destination: url) {
                        Image(systemName: "safari")
                            .foregroundStyle(themeManager.currentTheme.accentColor)
                    }
                }
            }
        }
    }
}

// MARK: - Native iOS Activity View Controller (Share Sheet)

struct ActivityViewController: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
