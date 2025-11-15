import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var appState: AppState
    @State private var currentPage = 0
    
    private let pages: [OnboardingPage] = [
        OnboardingPage(
            title: "Welcome to CultureCal",
            subtitle: "Discover and celebrate black history and achievements",
            imageName: "Fist",
            color: ThemeColor.primary
        ),
        OnboardingPage(
            title: "Cultural Events",
            subtitle: "Track important dates and cultural milestones",
            imageName: "calendar",
            color: ThemeColor.accent
        ),
        OnboardingPage(
            title: "Stay Informed",
            subtitle: "Learn about influential figures and historical events",
            imageName: "book.fill",
            color: ThemeColor.primary
        )
    ]
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(pages.indices, id: \.self) { index in
                OnboardingPageView(page: pages[index]) {
                    if index == pages.count - 1 {
                        appState.isFirstLaunch = false
                    } else {
                        withAnimation {
                            currentPage = index + 1
                        }
                    }
                }
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OnboardingPage {
    let title: String
    let subtitle: String
    let imageName: String
    let color: Color
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            Image(systemName: page.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .foregroundColor(page.color)
            
            VStack(spacing: 16) {
                Text(page.title)
                    .font(ThemeFont.largeTitle)
                    .foregroundColor(ThemeColor.text)
                
                Text(page.subtitle)
                    .font(ThemeFont.body)
                    .foregroundColor(ThemeColor.secondaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            Button(action: action) {
                Text("Continue")
                    .font(ThemeFont.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(RoundedButtonStyle())
            .padding(.horizontal)
            .padding(.bottom, 50)
        }
    }
}

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(AppState())
    }
}
#endif