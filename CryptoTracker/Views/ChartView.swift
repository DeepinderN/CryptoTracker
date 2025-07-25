//
//  ChartView.swift
//  CryptoTracker
//
//  Created by Deepinder on 7/25/25.
//



import SwiftUI
import Charts

struct ChartView: View {
    let data: [ChartData]

    var body: some View {
        Chart(data) { point in
            LineMark(
                x: .value("Date", point.date),
                y: .value("Price", point.price)
            )
            .interpolationMethod(.catmullRom)
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartXAxis {
            AxisMarks(values: .automatic(desiredCount: 4)) { _ in
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime.hour().minute())
            }
        }
        .frame(height: 250)
        .padding()
    }
}
