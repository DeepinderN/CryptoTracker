//
//  ChartData.swift
//  CryptoTracker
//
//  Created by Deepinder on 7/25/25.
//

// Models/ChartData.swift

import Foundation

struct ChartData: Identifiable {
    let id = UUID()
    let date: Date
    let price: Double
}
