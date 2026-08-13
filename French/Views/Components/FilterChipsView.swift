import SwiftUI

struct FilterChipsView: View {
    let tags: [String]
    @Binding var selectedTag: String
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    let isSelected = selectedTag == tag
                    Button {
                        HapticManager.shared.tapWord()
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.70)) {
                            selectedTag = isSelected ? "All" : tag
                        }
                    } label: {
                        Text(tag)
                            .font(.system(size: 13, weight: isSelected ? .bold : .medium))
                            .foregroundStyle(isSelected ? Color.white : themeManager.currentTheme.primaryTextColor)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 7)
                            .background(
                                Group {
                                    if isSelected {
                                        AppGradients.indigoViolet
                                    } else {
                                        themeManager.currentTheme.cardBackgroundColor.opacity(0.85)
                                    }
                                }
                            )
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .strokeBorder(isSelected ? Color.clear : themeManager.currentTheme.secondaryTextColor.opacity(0.15), lineWidth: 1)
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 2)
        }
    }
}

#Preview {
    FilterChipsView(tags: ["All", "Accents", "Gender", "Cognates", "Verbs", "Phrases"], selectedTag: .constant("All"))
        .padding()
}
