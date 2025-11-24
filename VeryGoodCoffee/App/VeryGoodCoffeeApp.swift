import SwiftUI


@main
struct VeryGoodCoffeeApp: App {
    @State private var coffeeUseCase = CoffeeUseCase()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(coffeeUseCase)
        }
    }
}
