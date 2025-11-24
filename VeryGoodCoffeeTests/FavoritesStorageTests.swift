//
//  FavoritesStorageTests.swift
//  VeryGoodCoffee
//
//  Created by wellington ferreira on 24/11/25.
//


import XCTest
@testable import VeryGoodCoffee

final class FavoritesStorageTests: XCTestCase {
    var sut: FavoritesStorage!
    let testKey = "VeryGoodCoffee_Favorites_Test"
    
    override func setUp() {
        super.setUp()
        // Use a different key for testing to not affect production data
        sut = FavoritesStorage()
        UserDefaults.standard.removeObject(forKey: testKey)
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: testKey)
        sut = nil
        super.tearDown()
    }
    
    func testSave_StoresImagesInUserDefaults() {
        // Given
        let url1 = URL(string: "https://coffee.alexflipnote.dev/1.jpg")!
        let url2 = URL(string: "https://coffee.alexflipnote.dev/2.jpg")!
        let images = [CoffeeImage(url: url1), CoffeeImage(url: url2)]
        
        // When
        sut.save(images)
        
        // Then
        let loaded = sut.load()
        XCTAssertEqual(loaded.count, 2)
        XCTAssertEqual(loaded[0].url, url1)
        XCTAssertEqual(loaded[1].url, url2)
    }

    
    func testSave_OverwritesPreviousData() {
        // Given
        let url1 = URL(string: "https://coffee.alexflipnote.dev/1.jpg")!
        let url2 = URL(string: "https://coffee.alexflipnote.dev/2.jpg")!
        
        sut.save([CoffeeImage(url: url1)])
        
        // When
        sut.save([CoffeeImage(url: url2)])
        
        // Then
        let loaded = sut.load()
        XCTAssertEqual(loaded.count, 1)
        XCTAssertEqual(loaded[0].url, url2)
    }

}
