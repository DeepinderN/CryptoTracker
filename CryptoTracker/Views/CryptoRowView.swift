//
//  CryptoRowView.swift
//  CryptoTracker
//
//  Created by Deepinder on 7/25/25.
//

import SwiftUI

import SwiftUI

struct CryptoRowView: View {
    let crypto: Crypto
    @EnvironmentObject var favs: FavoritesManager

    var body: some View {
        HStack(spacing: 12) {
            // Coin Image
            AsyncImage(url: crypto.image) { img in
                img.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 36, height: 36)
            .clipShape(Circle())

            // Name + Symbol
            VStack(alignment: .leading, spacing: 4) {
                Text(crypto.name)
                    .font(.headline)
                Text(crypto.symbol.uppercased())
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Price + Change
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(crypto.current_price, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text("\(crypto.price_change_percentage_24h, specifier: "%.2f")%")
                    .font(.caption2)
                    .foregroundColor(
                        crypto.price_change_percentage_24h >= 0 ? .green : .red
                    )
            }

            // Favorite Star
            Button {
                favs.toggle(crypto.id)
            } label: {
                Image(systemName: favs.isFavorite(crypto.id) ? "star.fill" : "star")
                    .foregroundColor(favs.isFavorite(crypto.id) ? .yellow : .gray)
                    .imageScale(.medium)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 8)
    }
}


struct CryptoRowView_Previews: PreviewProvider {
    static var previews: some View {
        let sample = Crypto(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            image: URL(string: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png")!,
            current_price: 56000,
            price_change_percentage_24h: 3.2
        )
        CryptoRowView(crypto: sample)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
