import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DiscoveryView()
                .tabItem { Label("Discover", systemImage: "cup.and.saucer.fill") }
            FavoritesView()
                .tabItem { Label("Favorites", systemImage: "heart.fill") }
        }
        .tint(.brown)
    }
}
