import Foundation
import Kingfisher

@MainActor
@Observable
final class CoffeeUseCase {
    var currentImage: CoffeeImage?
    var favorites: [CoffeeImage] = []
    var isLoading = false
    var errorMessage: String?

    private let repository = CoffeeRepository()
    private let storage = FavoritesStorage()

    init() {
        loadFavorites()
    }

    func fetchNewCoffee() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let image = try await repository.fetchRandomCoffee()
            currentImage = image
            
            // Preload image for offline access
            KingfisherManager.shared.retrieveImage(with: image.url) { _ in }
            
        } catch {
            errorMessage = "No internet connection"
        }
        
        isLoading = false
    }

    func toggleFavorite() {
        guard let image = currentImage else { return }
        
        if let index = favorites.firstIndex(where: { $0.id == image.id }) {
            favorites.remove(at: index)
        } else {
            favorites.insert(image, at: 0) // Add to front
        }
        
        storage.save(favorites)
    }
    
    func isFavorite(_ image: CoffeeImage?) -> Bool {
        guard let image else { return false }
        return favorites.contains(where: { $0.id == image.id })
    }

    func removeFavorite(_ image: CoffeeImage) {
        favorites.removeAll { $0.id == image.id }
        storage.save(favorites)
    }

    private func loadFavorites() {
        favorites = storage.load()
    }

    func randomBrewTip() -> String {
        [
            "Perfect flat white",
            "Cold brew vibes",
            "Espresso royalty",
            "Oat milk approved",
            "Morning magic"
        ].randomElement() ?? "Delicious"
    }
}
