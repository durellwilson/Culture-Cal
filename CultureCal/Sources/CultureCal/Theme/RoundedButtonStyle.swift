import SwiftUI

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

#if DEBUG
struct RoundedButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Preview Button") {}
            .buttonStyle(RoundedButtonStyle())
            .padding()
    }
}
#endif