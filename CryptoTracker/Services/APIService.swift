//
//  APIService.swift
//  CryptoTracker
//
//  Created by Deepinder on 7/25/25.
//

import Foundation

enum APIError: Error { case invalidURL, invalidResponse }

class APIService {
    private let baseURL = "https://api.coingecko.com/api/v3"

    func fetchTopCryptos() async throws -> [Crypto] {
        guard let url = URL(string: "\(baseURL)/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1") else {
            throw APIError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        return try JSONDecoder().decode([Crypto].self, from: data)
    }
}
struct ChartDataPoint: Codable {
    let prices: [[Double]]   // [ [ timestamp, price ], … ]
}

extension APIService {
    /// days: 1, 7, 30, etc.
    func fetchHistoricPrices(for id: String, days: Int) async throws -> [ChartData] {
        let urlString = "\(baseURL)/coins/\(id)/market_chart?vs_currency=usd&days=\(days)"
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        let raw = try JSONDecoder().decode(ChartDataPoint.self, from: data)
        return raw.prices.map { point in
            ChartData(date: Date(timeIntervalSince1970: point[0]/1000),
                      price: point[1])
        }
    }
}
