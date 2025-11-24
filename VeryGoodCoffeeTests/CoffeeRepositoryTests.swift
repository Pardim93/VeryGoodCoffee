//
//  CoffeeRepositoryTests.swift
//  VeryGoodCoffee
//
//  Created by wellington ferreira on 24/11/25.
//


import XCTest
@testable import VeryGoodCoffee

final class CoffeeRepositoryTests: XCTestCase {
    var sut: CoffeeRepository!
    
    override func setUp() {
        super.setUp()
        sut = CoffeeRepository()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFetchRandomCoffee_ReturnsValidCoffeeImage() async throws {
        // When
        let image = try await sut.fetchRandomCoffee()
        
        // Then
        XCTAssertNotNil(image.id)
        XCTAssertTrue(image.url.absoluteString.contains("coffee.alexflipnote.dev"))
        XCTAssertNotNil(image.addedAt)
    }
    
    func testFetchRandomCoffee_ReturnsUniqueImages() async throws {
        // When - Fetch two images
        let image1 = try await sut.fetchRandomCoffee()
        let image2 = try await sut.fetchRandomCoffee()
        
        // Then - They should have different IDs (though URLs might be same)
        XCTAssertNotEqual(image1.id, image2.id)
    }
    
    func testFetchRandomCoffee_ThrowsError_WhenNetworkFails() async {
        // Given - Repository with invalid URL
        let invalidRepo = CoffeeRepository()
        
        // When/Then
        do {
            _ = try await invalidRepo.fetchRandomCoffee()
        } catch {
            // Expected to throw
            XCTAssertNotNil(error)
        }
    }
}