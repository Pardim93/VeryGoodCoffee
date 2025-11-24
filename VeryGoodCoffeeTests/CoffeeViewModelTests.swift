//import XCTest
//@testable import VeryGoodCoffee
//
//final class CoffeeViewModelTests: XCTestCase {
//
//    var viewModel: CoffeeViewModel!
//    let mockURL = URL(string: "https://coffee.alexflipnote.dev/mock.jpg")!
//
//    override func setUp() {
//        super.setUp()
//        viewModel = CoffeeViewModel()
//        viewModel.favorites.removeAll()
//        viewModel.currentURL = nil
//        viewModel.isLoading = false
//        viewModel.errorMessage = nil
//    }
//
//    // MARK: - Fetching
//    func testFetchNewImage_Succeeds_SetsCurrentImageURL() async {
//        // Given – mock successful network response
//        URLProtocol.registerClass(MockURLProtocol.self)
//        MockURLProtocol.requestHandler = { request in
//            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
//            let json = #"{"file": "https://coffee.alexflipnote.dev/123.jpg"}"#.data(using: .utf8)!
//            return (response, json)
//        }
//
//        // When
//        await viewModel.fetchNewImage()
//
//        // Then
//        XCTAssertNotNil(viewModel.currentImageURL)
//        XCTAssertNil(viewModel.errorMessage)
//        XCTAssertFalse(viewModel.isLoading)
//    }
//
//    func testFetchNewImage_Fails_SetsErrorMessage() async {
//        URLProtocol.registerClass(MockURLProtocol.self)
//        MockURLProtocol.requestHandler = { _ in
//            throw URLError(.notConnectedToInternet)
//        }
//
//        await viewModel.fetchNewImage()
//
//        XCTAssertNil(viewModel.currentImageURL)
//        XCTAssertNotNil(viewModel.errorMessage)
//        XCTAssertFalse(viewModel.isLoading)
//    }
//
//    // MARK: - Favorites
//    func testToggleFavorite_AddsAndRemovesCorrectly() {
//        viewModel.currentImageURL = mockURL
//
//        viewModel.toggleFavorite()
//        XCTAssertTrue(viewModel.favorites.contains(mockURL.absoluteString))
//
//        viewModel.toggleFavorite()
//        XCTAssertFalse(viewModel.favorites.contains(mockURL.absoluteString))
//    }
//
//    func testRemoveFromFavorites_RemovesOnlySpecifiedURL() {
//        let url1 = "https://coffee.alexflipnote.dev/1.jpg"
//        let url2 = "https://coffee.alexflipnote.dev/2.jpg"
//        viewModel.favorites = [url1, url2]
//
//        viewModel.removeFromFavorites(url1)
//
//        XCTAssertFalse(viewModel.favorites.contains(url1))
//        XCTAssertTrue(viewModel.favorites.contains(url2))
//    }
//
//    func testFavoritesArePersistedAcrossInstances() {
//        // Add favorite in first instance
//        let vm1 = CoffeeViewModel()
//        vm1.currentImageURL = mockURL
//        vm1.toggleFavorite()
//
//        // Create second instance (simulates app restart)
//        let vm2 = CoffeeViewModel()
//
//        XCTAssertTrue(vm2.favorites.contains(mockURL.absoluteString))
//    }
//
//    func testBrewTip_ReturnsNonEmptyString() {
//        XCTAssertFalse(viewModel.brewTip().isEmpty)
//    }
//}
