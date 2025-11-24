import Foundation

struct CoffeeRepository {
    private let url = URL(string: "https://coffee.alexflipnote.dev/random.json")!

    func fetchRandomCoffee() async throws -> CoffeeImage {
        Logger.info("Starting network request for coffee image…")
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(APIResponse.self, from: data)
        return CoffeeImage(url: response.file)
    }
}

private struct APIResponse: Decodable {
    let file: URL
}
