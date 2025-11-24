//
//  MockCoffeeRepository.swift
//  VeryGoodCoffee
//
//  Created by wellington ferreira on 24/11/25.
//


import Foundation
@testable import VeryGoodCoffee

final class MockCoffeeRepository {
    var shouldThrowError = false
    var mockImage: CoffeeImage?
    
    func fetchRandomCoffee() async throws -> CoffeeImage {
        if shouldThrowError {
            throw URLError(.notConnectedToInternet)
        }
        
        if let mockImage {
            return mockImage
        }
        
        let url = URL(string: "https://coffee.alexflipnote.dev/mock.jpg")!
        return CoffeeImage(url: url)
    }
}