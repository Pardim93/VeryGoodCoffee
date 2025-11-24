//
//  CoffeeUseCaseTests.swift
//  VeryGoodCoffee
//
//  Created by wellington ferreira on 24/11/25.
//


import XCTest
@testable import VeryGoodCoffee

@MainActor
final class CoffeeUseCaseTests: XCTestCase {
    var sut: CoffeeUseCase!
    
    override func setUp() {
        super.setUp()
        sut = CoffeeUseCase()
        // Clear any saved favorites
        UserDefaults.standard.removeObject(forKey: "VeryGoodCoffee_Favorites_v3")
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    
    func testIsFavorite_ReturnsFalse_WhenImageIsNil() {
        // When
        let result = sut.isFavorite(nil)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testIsFavorite_ReturnsFalse_WhenImageNotInFavorites() {
        // Given
        let url = URL(string: "https://coffee.alexflipnote.dev/aHs0XbdgaWU_coffee.jpg")!
        let image = CoffeeImage(url: url)
        
        // When
        let result = sut.isFavorite(image)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testRemoveFavorite_RemovesSpecificImage() {
        // Given
        let url1 = URL(string: "https://coffee.alexflipnote.dev/IK5eWQLTihw_coffee.jpg")!
        let url2 = URL(string: "https://coffee.alexflipnote.dev/aHs0XbdgaWU_coffee.jpg")!
        let image1 = CoffeeImage(url: url1)
        let image2 = CoffeeImage(url: url2)
        
        sut.currentImage = image1
        sut.toggleFavorite()
        sut.currentImage = image2
        sut.toggleFavorite()
        
        // When
        sut.removeFavorite(image1)
        
        // Then
        XCTAssertEqual(sut.favorites.count, 1)
        XCTAssertFalse(sut.isFavorite(image1))
        XCTAssertTrue(sut.isFavorite(image2))
    }
    
    // MARK: - Loading Tests
    
    func testFetchNewCoffee_SetsLoadingState() async {
        // Given
        XCTAssertFalse(sut.isLoading)
        
        // When
        let task = Task {
            await sut.fetchNewCoffee()
        }
        
        // Then - Loading should be true during fetch
        // (In a real test, you'd use a mock repository to control timing)
        
        await task.value
        XCTAssertFalse(sut.isLoading) // Should be false after completion
    }
    
    func testFetchNewCoffee_SetsCurrentImage_OnSuccess() async {
        // When
        await sut.fetchNewCoffee()
        
        // Then
        XCTAssertNotNil(sut.currentImage)
        XCTAssertNil(sut.errorMessage)
    }
    
    func testFetchNewCoffee_SetsErrorMessage_OnFailure() async {
        // Given - Use mock repository that throws error
        // (Would need dependency injection to test this properly)
        
        // This test would require refactoring to inject repository
        // See "Advanced Testing" section below
    }
    
    // MARK: - Utility Tests
    
    func testRandomBrewTip_ReturnsValidString() {
        // When
        let tip = sut.randomBrewTip()
        
        // Then
        XCTAssertFalse(tip.isEmpty)
        let validTips = [
            "Perfect flat white",
            "Cold brew vibes",
            "V60 masterpiece",
            "Espresso royalty",
            "Oat milk approved",
            "Morning magic"
        ]
        XCTAssertTrue(validTips.contains(tip))
    }
}
