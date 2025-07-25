//
//  CryptoListView.swift
//  CryptoTracker
//
//  Created by Deepinder on 7/25/25.
//

import SwiftUI

struct CryptoListView: View {
    @EnvironmentObject var vm: CryptoListViewModel
    @EnvironmentObject var favs: FavoritesManager
    @State private var showOnlyFavorites = false

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                // Toggle
                Toggle("Show Only Favorites", isOn: $showOnlyFavorites)
                    .padding(.horizontal)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))

                // Filtered List
                List {
                    ForEach(filteredCryptos) { coin in
                        NavigationLink(destination: CryptoDetailView(crypto: coin)) {
                            CryptoRowView(crypto: coin)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("CryptoTracker")
            .task {
                await vm.loadCryptos()
            }
        }
    }

    // Filter logic
    var filteredCryptos: [Crypto] {
        if showOnlyFavorites {
            return vm.cryptos.filter { favs.isFavorite($0.id) }
        } else {
            return vm.cryptos
        }
    }
}
