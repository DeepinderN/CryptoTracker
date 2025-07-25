//
//  CryptoDetailViewModel.swift
//  CryptoTracker
//
//  Created by Deepinder on 7/25/25.
//

// ViewModels/CryptoDetailViewModel.swift

import Foundation

@MainActor
class CryptoDetailViewModel: ObservableObject {
    @Published var history: [ChartData] = []
    @Published var selectedRange: RangeOption = .sevenDays

    enum RangeOption: Int, CaseIterable, Identifiable {
        case oneDay = 1, sevenDays = 7, thirtyDays = 30
        var id: Int { rawValue }
        var title: String {
            switch self {
            case .oneDay: return "1D"
            case .sevenDays: return "7D"
            case .thirtyDays: return "30D"
            }
        }
    }

    private let service = APIService()
    private let cryptoID: String

    init(cryptoID: String) {
        self.cryptoID = cryptoID
    }

    func loadHistory() async {
        do {
            let days = selectedRange.rawValue
            history = try await service.fetchHistoricPrices(for: cryptoID, days: days)
        } catch {
            print("Failed loading history:", error)
        }
    }

    func changeRange(to option: RangeOption) {
        selectedRange = option
        Task { await loadHistory() }
    }
}
