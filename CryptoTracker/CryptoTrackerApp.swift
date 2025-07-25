//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Deepinder on 7/25/25.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject private var listVM = CryptoListViewModel()
    @StateObject private var favs = FavoritesManager.shared

    var body: some Scene {
        WindowGroup {
            CryptoListView()
                .environmentObject(listVM)
                .environmentObject(favs)
        }
    }
}

