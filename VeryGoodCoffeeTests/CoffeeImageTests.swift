//
//  CoffeeImageTests.swift
//  VeryGoodCoffee
//
//  Created by wellington ferreira on 24/11/25.
//


import XCTest
@testable import VeryGoodCoffee

final class CoffeeImageTests: XCTestCase {
    
    func testCoffeeImage_InitializesWithURL() {
        // Given
        let url = URL(string: "https://coffee.alexflipnote.dev/test.jpg")!
        
        // When
        let image = CoffeeImage(url: url)
        
        // Then
        XCTAssertEqual(image.url, url)
        XCTAssertNotNil(image.id)
        XCTAssertNotNil(image.addedAt)
    }
    
    func testCoffeeImage_TwoInstancesWithSameURL_AreNotEqual() {
        // Given
        let url = URL(string: "https://coffee.alexflipnote.dev/test.jpg")!
        
        // When
        let image1 = CoffeeImage(url: url)
        let image2 = CoffeeImage(url: url)
        
        // Then
        XCTAssertNotEqual(image1, image2) // Different IDs
    }
    
    func testCoffeeImage_IsEncodableAndDecodable() throws {
        // Given
        let url = URL(string: "https://coffee.alexflipnote.dev/test.jpg")!
        let originalImage = CoffeeImage(url: url)
        
        // When
        let encoder = JSONEncoder()
        let data = try encoder.encode(originalImage)
        
        let decoder = JSONDecoder()
        let decodedImage = try decoder.decode(CoffeeImage.self, from: data)
        
        // Then
        XCTAssertEqual(originalImage.id, decodedImage.id)
        XCTAssertEqual(originalImage.url, decodedImage.url)
    }
}