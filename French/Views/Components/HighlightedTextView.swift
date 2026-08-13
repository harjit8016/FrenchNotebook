import SwiftUI

struct HighlightedTextView: View {
    let fullText: String
    let activeRange: NSRange?
    let font: Font
    var normalColor: Color = .primary
    var highlightColor: Color = .blue

    var body: some View {
        if let activeRange = activeRange,
           let swiftRange = Range(activeRange, in: fullText) {
            let prefix = String(fullText[..<swiftRange.lowerBound])
            let highlighted = String(fullText[swiftRange])
            let suffix = String(fullText[swiftRange.upperBound...])

            (
                Text(prefix)
                    .font(font)
                    .foregroundColor(normalColor) +
                Text(highlighted)
                    .font(font.bold())
                    .foregroundColor(highlightColor) +
                Text(suffix)
                    .font(font)
                    .foregroundColor(normalColor)
            )
        } else {
            Text(fullText)
                .font(font)
                .foregroundColor(normalColor)
        }
    }
}
