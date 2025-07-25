# CryptoTracker — Real-Time Cryptocurrency Dashboard (iOS)

CryptoTracker is a SwiftUI-based iOS application that displays real-time cryptocurrency market data. It features interactive charts, a favorites system, and clean, modern UI built using Swift Concurrency, MVVM architecture, and native Swift Charts.

---

## Features

- Live Market Data — Fetches top 50 coins using the CoinGecko API
- Favorites — Mark and filter your favorite cryptocurrencies
- Interactive Charts — Time-range line charts for each coin using Swift Charts
- MVVM Architecture — Scalable and modular project structure
- Light/Dark Mode — Fully responsive across themes
- Async/Await Networking — Swift Concurrency for API calls
- UserDefaults Persistence — Favorites saved across sessions

---



## Tech Stack

- SwiftUI  
- Swift Concurrency (`async/await`)  
- Swift Charts (`import Charts`)  
- MVVM Architecture  
- UserDefaults for lightweight persistence  
- CoinGecko API (Free Tier)

---

## Project Structure

```
CryptoTracker/
├── Models/
│   └── Crypto.swift
│   └── ChartData.swift
├── Services/
│   └── APIService.swift
├── ViewModels/
│   ├── CryptoListViewModel.swift
│   └── CryptoDetailViewModel.swift
├── Views/
│   ├── CryptoListView.swift
│   ├── CryptoRowView.swift
│   └── CryptoDetailView.swift
├── Managers/
│   └── FavoritesManager.swift
├── CryptoTrackerApp.swift
```

---

## API

This app uses the [CoinGecko API](https://www.coingecko.com/en/api) for free cryptocurrency data.

> No API key required.

---

## Setup & Run

1. Clone the repo  
2. Open `CryptoTracker.xcodeproj` in Xcode  
3. Run on iOS Simulator or real device (iOS 15.0+)  
4. Internet connection required for data fetch

---

## Author

**Deepinder**  
GitHub: [@DeepinderN](https://github.com/DeepinderN)

---

## License

This project is licensed under the MIT License.
