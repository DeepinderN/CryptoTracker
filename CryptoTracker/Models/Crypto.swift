//
//  Crypto.swift
//  CryptoTracker
//
//  Created by Deepinder on 7/25/25.
//
import Foundation

struct Crypto: Identifiable, Codable {
    let id: String
    let symbol: String
    let name: String
    let image: URL
    let current_price: Double
    let price_change_percentage_24h: Double
}
