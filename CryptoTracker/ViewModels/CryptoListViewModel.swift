//
//  CryptoListViewModel.swift
//  CryptoTracker
//
//  Created by Deepinder on 7/25/25.
//

import Foundation

@MainActor
class CryptoListViewModel: ObservableObject {
    @Published var cryptos: [Crypto] = []
    private let service = APIService()

    func loadCryptos() async {
        do {
            cryptos = try await service.fetchTopCryptos()
        } catch {
            print("Error fetching cryptos:", error)
        }
    }
}
