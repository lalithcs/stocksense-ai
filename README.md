# StockSense AI

A Material 3, offline-first Flutter stock research application.

## Features

- Responsive market dashboard with indices and trending stocks
- Debounced ticker/company search with local search history
- Stock detail views with key valuation metrics and local rule-based AI insights
- Hive-backed watchlist and portfolio holdings
- Light, dark, and system themes
- A unit test for the analysis engine

## Architecture

The project follows a feature-first clean-architecture layout:

```
lib/
  core/       # cross-cutting configuration and storage
  shared/     # reusable UI
  features/   # dashboard, stock, search, analysis, portfolio, watchlist, settings
```

Feature code is separated into data, domain, and presentation responsibilities where applicable. The market repository is intentionally injectable, so a remote data provider and cache can replace the included local sample source without changing UI code.

## Setup

1. Install the current stable Flutter SDK.
2. Run `flutter pub get`.
3. Run `flutter analyze` and `flutter test`.
4. Run `flutter run`.

## Data and safety

The bundled quotes are sample data. The local analysis engine is educational only and does not provide investment advice. Hive stores portfolio, watchlist, search history, and theme preference locally on-device.
