//
//  FavoritesManager.swift
//  CryptoTracker
//
//  Created by Deepinder on 7/25/25.
//

import Foundation
import Combine

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()
    @Published private(set) var favorites: Set<String>

    private let key = "favoriteCryptos"
    private let defaults = UserDefaults.standard

    private init() {
        let saved = defaults.stringArray(forKey: key) ?? []
        favorites = Set(saved)
    }

    func toggle(_ id: String) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
        defaults.set(Array(favorites), forKey: key)
        objectWillChange.send()
    }

    func isFavorite(_ id: String) -> Bool {
        favorites.contains(id)
    }
}
