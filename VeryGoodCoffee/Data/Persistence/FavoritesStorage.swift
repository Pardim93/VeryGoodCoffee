import Foundation

struct FavoritesStorage {
    private let key = "VeryGoodCoffee_Favorites_v3"

    func save(_ images: [CoffeeImage]) {
        Logger.info("Saving favorite coffee")
        if let data = try? JSONEncoder().encode(images) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() -> [CoffeeImage] {
        Logger.info("Fetching favorite coffee list")
        guard let data = UserDefaults.standard.data(forKey: key),
              let images = try? JSONDecoder().decode([CoffeeImage].self, from: data)
        else { return [] }
        return images
    }
}
