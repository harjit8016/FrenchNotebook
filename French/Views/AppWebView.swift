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
}

// MARK: - Safe Future-Proof Auto-Bypass & Auto-Play Script

private let safeAutoPlayJS = """
(function() {
    'use strict';
    function safeExecute() {
        try {
            // Keywords to match "Continue on web", "Watch on web", "Not now", etc.
            const keywords = ['continue', 'web', 'watch', 'play', 'open', 'not now', 'stay', 'view', 'proceed', 'accept', 'allow'];

            const elements = document.querySelectorAll('button, a, div[role="button"], span[role="button"], p, div, input[type="button"]');
            for (let i = 0; i < elements.length; i++) {
                const el = elements[i];
                if (!el || typeof el.innerText !== 'string') continue;
                const text = el.innerText.trim().toLowerCase();
                if (text.length > 0 && text.length < 80) {
                    const matches = keywords.some(function(k) { return text.indexOf(k) !== -1; });
                    if (matches) {
                        try {
                            el.click();
                            el.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true, view: window }));
                        } catch(e) {}
                    }
                }
            }

            // Safely auto-play HTML5 video elements
            const videos = document.getElementsByTagName('video');
            for (let i = 0; i < videos.length; i++) {
                const vid = videos[i];
                if (vid && vid.paused) {
                    vid.playsInline = true;
                    vid.setAttribute('playsinline', '');
                    vid.setAttribute('webkit-playsinline', '');
                    const promise = vid.play();
                    if (promise !== undefined) {
                        promise.catch(function() {
                            vid.muted = true;
                            vid.play().catch(function(){});
                        });
                    }
                }
            }
        } catch(err) {}
    }

    safeExecute();

    try {
        const observer = new MutationObserver(function() { safeExecute(); });
        if (document.body) {
            observer.observe(document.body, { childList: true, subtree: true, attributes: true });
        }
    } catch(e) {}

    var attempts = 0;
    var timer = setInterval(function() {
        safeExecute();
        attempts++;
        if (attempts > 15) clearInterval(timer);
    }, 300);
})();
"""

// MARK: - Native Web View with Interactive Navigation & Safe Script Injection

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

        // Inject safe future-proof auto-play script into all frames
        let userScript = WKUserScript(source: safeAutoPlayJS, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        config.userContentController.addUserScript(userScript)

        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator

        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1"
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.showsVerticalScrollIndicator = false

        let urlString = url.absoluteString
        if let videoID = YouTubeEmbedHelper.extractVideoID(from: urlString) {
            let html = YouTubeEmbedHelper.generateEmbedHTML(for: videoID)
            webView.loadHTMLString(html, baseURL: URL(string: "https://www.youtube-nocookie.com"))
        } else if let reelID = InstagramEmbedHelper.extractReelID(from: urlString) {
            if let embedURL = URL(string: "https://www.instagram.com/reel/\(reelID)/embed/") {
                webView.load(URLRequest(url: embedURL))
            } else {
                webView.load(URLRequest(url: url))
            }
        } else {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript(safeAutoPlayJS, completionHandler: nil)
        }

        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }
    }
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

        // Inject safe future-proof auto-play script into direct web view as well
        let userScript = WKUserScript(source: safeAutoPlayJS, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        config.userContentController.addUserScript(userScript)

        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4 Mobile/15E148 Safari/604.1"
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
