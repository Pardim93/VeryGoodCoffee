//
//  MockFavoritesStorage.swift
//  VeryGoodCoffee
//
//  Created by wellington ferreira on 24/11/25.
//


import Foundation
@testable import VeryGoodCoffee

final class MockFavoritesStorage {
    private var storage: [CoffeeImage] = []
    var saveCallCount = 0
    var loadCallCount = 0
    
    func save(_ images: [CoffeeImage]) {
        saveCallCount += 1
        storage = images
    }
    
    func load() -> [CoffeeImage] {
        loadCallCount += 1
        return storage
    }
    
    func reset() {
        storage = []
        saveCallCount = 0
        loadCallCount = 0
    }
}