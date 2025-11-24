import SwiftUI
import Kingfisher

struct FavoritesView: View {
    @Environment(CoffeeUseCase.self) private var useCase
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            Group {
                if useCase.favorites.isEmpty {
                    emptyStateView
                } else {
                    favoritesGridView
                }
            }
            .navigationTitle("Favorites")
        }
    }
    
    // MARK: - Subviews
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.slash")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)
            
            Text("No favorites yet")
                .font(.title2)
            
            Text("Double-tap any coffee you love")
                .foregroundStyle(.secondary)
        }
    }
    
    private var favoritesGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(useCase.favorites) { image in
                    favoriteImageCard(image)
                }
            }
            .padding()
        }
    }
    
    private func favoriteImageCard(_ image: CoffeeImage) -> some View {
        KFImage(image.url)
            .cacheOriginalImage(true)
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(alignment: .topTrailing) {
                Button {
                    useCase.removeFavorite(image)
                } label: {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                        .padding(8)
                        .background(.ultraThinMaterial, in: Circle())
                }
                .padding(8)
            }
    }
}
