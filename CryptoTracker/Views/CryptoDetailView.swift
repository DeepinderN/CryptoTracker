//
//  CryptoDetailView.swift
//  CryptoTracker
//
//  Created by Deepinder on 7/25/25.
//

// Views/CryptoDetailView.swift

import SwiftUI
import Charts

struct CryptoDetailView: View {
    let crypto: Crypto

    @StateObject private var vm: CryptoDetailViewModel
    @EnvironmentObject var favs: FavoritesManager

    init(crypto: Crypto) {
        self.crypto = crypto
        _vm = StateObject(wrappedValue: CryptoDetailViewModel(cryptoID: crypto.id))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // MARK: - Coin Header
                HStack(spacing: 12) {
                    AsyncImage(url: crypto.image) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())

                    VStack(alignment: .leading) {
                        Text(crypto.name)
                            .font(.title2).bold()
                        Text(crypto.symbol.uppercased())
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .trailing) {
                        Text("$\(crypto.current_price, specifier: "%.2f")")
                            .font(.title2)
                        Text("\(crypto.price_change_percentage_24h, specifier: "%.2f")%")
                            .foregroundColor(crypto.price_change_percentage_24h >= 0 ? .green : .red)
                            .font(.caption)
                    }

                    // Favorite Star
                    Button {
                        favs.toggle(crypto.id)
                    } label: {
                        Image(systemName: favs.isFavorite(crypto.id) ? "star.fill" : "star")
                            .font(.title2)
                            .symbolRenderingMode(.hierarchical)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)

                Divider()

                // MARK: - Range Picker
                Picker("Time Range", selection: $vm.selectedRange) {
                    ForEach(CryptoDetailViewModel.RangeOption.allCases) { option in
                        Text(option.title).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .onChange(of: vm.selectedRange) { newValue in
                    vm.changeRange(to: newValue)
                }

                // MARK: - Chart View
                if vm.history.isEmpty {
                    ProgressView("Loading chart...")
                        .frame(height: 240)
                } else {
                    Chart {
                        ForEach(vm.history) { point in
                            LineMark(
                                x: .value("Date", point.date),
                                y: .value("Price", point.price)
                            )
                            .interpolationMethod(.catmullRom)
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .chartXAxis {
                        AxisMarks(values: .automatic(desiredCount: 4)) { _ in
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel(format: .dateTime.month().day())
                        }
                    }
                    .frame(height: 240)
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.top)
        }
        .navigationTitle(crypto.symbol.uppercased())
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await vm.loadHistory()
        }
    }
}
