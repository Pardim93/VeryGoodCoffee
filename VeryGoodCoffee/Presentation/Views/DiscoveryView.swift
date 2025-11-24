import SwiftUI
import Kingfisher

struct DiscoveryView: View {
    @Environment(CoffeeUseCase.self) private var useCase
    @State private var opacity = 0.0

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()

                if useCase.isLoading && useCase.currentImage == nil {
                    ProgressView("Brewing your coffee…")
                        .scaleEffect(1.5)
                }
                else if useCase.errorMessage != nil {
                    errorView
                }
                else if let image = useCase.currentImage {
                    coffeeImageView(image)
                }
                else {
                    welcomeView
                }
            }
            .task {
                await useCase.fetchNewCoffee()
            }
        }
    }
    
    // MARK: - Subviews
    
    private var errorView: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)
            
            Text("No internet connection")
            
            Button("Try Again") {
                opacity = 0
                Task { await useCase.fetchNewCoffee() }
            }
            .buttonStyle(.borderedProminent)
            .tint(.brown)
        }
    }
    
    private func coffeeImageView(_ image: CoffeeImage) -> some View {
        VStack(spacing: 32) {
            KFImage(image.url)
                .cacheOriginalImage(true)
                .placeholder { ProgressView() }
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 28))
                .shadow(radius: 20)
                .opacity(opacity)
                .id(image.id)
                .onChange(of: useCase.currentImage?.id) { _, _ in
                    opacity = 0
                    withAnimation(.easeIn(duration: 0.8)) {
                        opacity = 1
                    }
                }
                .onAppear {
                    withAnimation(.easeIn(duration: 0.8)) {
                        opacity = 1
                    }
                }
                .onTapGesture(count: 2) {
                    useCase.toggleFavorite()
                }
                .gesture(
                    DragGesture(minimumDistance: 80)
                        .onEnded { gesture in
                            if gesture.translation.width < -80 {
                                opacity = 0
                                Task { await useCase.fetchNewCoffee() }
                            }
                        }
                )
                .overlay(alignment: .bottom) {
                    Text(useCase.randomBrewTip())
                        .font(.caption.bold())
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial, in: Capsule())
                        .padding(.bottom, 20)
                }

            VStack(spacing: 24) {
                Button("Next Cup") {
                    opacity = 0
                    Task { await useCase.fetchNewCoffee() }
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)

                Button {
                    useCase.toggleFavorite()
                } label: {
                    Image(systemName: useCase.isFavorite(image) ? "heart.fill" : "heart")
                        .font(.system(size: 60))
                        .foregroundStyle(useCase.isFavorite(image) ? .red : .secondary)
                        .contentTransition(.symbolEffect(.replace))
                }
                .sensoryFeedback(.impact, trigger: useCase.favorites.count)
            }
        }
        .padding(.horizontal)
    }
    
    private var welcomeView: some View {
        VStack(spacing: 20) {
            Image(systemName: "cup.and.saucer.fill")
                .font(.system(size: 80))
                .foregroundStyle(.brown)
            
            Text("Very Good Coffee")
                .font(.largeTitle.bold())
            
            Button("Start Brewing") {
                Task { await useCase.fetchNewCoffee() }
            }
            .buttonStyle(.borderedProminent)
            .tint(.brown)
        }
    }
}
