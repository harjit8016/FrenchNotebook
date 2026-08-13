import SwiftUI

struct HeroHeaderView: View {
    let title: String
    let subtitle: String
    @ObservedObject private var progressStore = ProgressStore.shared
    @ObservedObject private var themeManager = ThemeManager.shared

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(themeManager.currentTheme.primaryTextColor)

                Text(subtitle)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(themeManager.currentTheme.secondaryTextColor)
            }

            Spacer()

            // Interactive Hero Stats Chips
            HStack(spacing: 8) {
                // Streak Chip
                HStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(.orange)
                    Text("\(progressStore.progress.streakDays)")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                }
                .padding(.horizontal, 9)
                .padding(.vertical, 6)
                .background(Color.orange.opacity(0.12))
                .clipShape(Capsule())

                // Heart Chip
                HStack(spacing: 4) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(.red)
                    Text("\(progressStore.progress.hearts)")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                }
                .padding(.horizontal, 9)
                .padding(.vertical, 6)
                .background(Color.red.opacity(0.12))
                .clipShape(Capsule())

                // XP Chip
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(.yellow)
                    Text("\(progressStore.progress.xp)")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                        .foregroundStyle(themeManager.currentTheme.primaryTextColor)
                }
                .padding(.horizontal, 9)
                .padding(.vertical, 6)
                .background(Color.yellow.opacity(0.15))
                .clipShape(Capsule())
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    HeroHeaderView(title: "French Notebook", subtitle: "Master French vocabulary & grammar")
        .padding()
}
