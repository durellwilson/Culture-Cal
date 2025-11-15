import SwiftUI

enum ThemeColor {
    static let primary = Color("FistGreen")
    static let background = Color(UIColor.systemBackground)
    static let secondaryBackground = Color(UIColor.secondarySystemBackground)
    static let text = Color(UIColor.label)
    static let secondaryText = Color(UIColor.secondaryLabel)
    static let accent = Color("AccentColor")
}

struct ThemeFont {
    static let largeTitle = Font.largeTitle.weight(.bold)
    static let title = Font.title.weight(.semibold)
    static let headline = Font.headline.weight(.semibold)
    static let body = Font.body
    static let callout = Font.callout
    static let caption = Font.caption
}

struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(ThemeColor.primary)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}