import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var placeholder: String = "Search French, English, or Punjabi..."
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(themeManager.currentTheme.accentColor)

            TextField(placeholder, text: $searchText)
                .font(themeManager.fontSizeScale.bodyFont)
                .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            if !searchText.isEmpty {
                Button {
                    HapticManager.shared.tapWord()
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .appNeumorphicCard(cornerRadius: 14)
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
        .padding()
}
