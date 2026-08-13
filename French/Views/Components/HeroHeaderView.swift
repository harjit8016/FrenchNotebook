import SwiftUI

struct HeroHeaderView: View {
    let title: String
    let subtitle: String
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .font(.system(size: 26, weight: .bold, design: .rounded))
                .foregroundStyle(themeManager.currentTheme.primaryTextColor)

            Text(subtitle)
                .font(.system(size: 13.5, weight: .medium))
                .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 4)
    }
}

#Preview {
    HeroHeaderView(title: "French Notebook", subtitle: "Master French vocabulary & grammar")
        .padding()
}
