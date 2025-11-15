import SwiftUI

struct LoadingView: View {
    let message: String
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 20) {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(ThemeColor.primary, lineWidth: 4)
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(
                    Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false),
                    value: isAnimating
                )
                .onAppear {
                    isAnimating = true
                }
            
            Text(message)
                .font(ThemeFont.callout)
                .foregroundColor(ThemeColor.secondaryText)
        }
    }
}

struct LoadingOverlay: ViewModifier {
    let isLoading: Bool
    let message: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 3 : 0)
            
            if isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                LoadingView(message: message)
                    .transition(.opacity)
            }
        }
    }
}

extension View {
    func loading(_ isLoading: Bool, message: String = "Loading...") -> some View {
        modifier(LoadingOverlay(isLoading: isLoading, message: message))
    }
}

#if DEBUG
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            LoadingView(message: "Loading...")
            
            Color.white
                .loading(true, message: "Processing...")
        }
    }
}
#endif