import '../../stock/domain/stock_quote.dart';

abstract class MarketRepository {
  Future<List<StockQuote>> indices();
  Future<List<StockQuote>> search(String query);
}

class DemoMarketRepository implements MarketRepository {
  static const _quotes = [
    StockQuote(symbol: 'NIFTY 50', name: 'Nifty 50', price: 24631.30, change: 115.20, percentChange: .47, sector: 'Index'),
    StockQuote(symbol: 'SENSEX', name: 'BSE Sensex', price: 80604.65, change: 384.24, percentChange: .48, sector: 'Index'),
    StockQuote(symbol: 'NASDAQ', name: 'NASDAQ Composite', price: 17862.23, change: -74.18, percentChange: -.41, sector: 'Index', exchange: 'US'),
    StockQuote(symbol: 'DJI', name: 'Dow Jones', price: 39118.86, change: 153.43, percentChange: .39, sector: 'Index', exchange: 'US'),
    StockQuote(symbol: 'SPX', name: 'S&P 500', price: 5460.48, change: 12.71, percentChange: .23, sector: 'Index', exchange: 'US'),
    StockQuote(symbol: 'RELIANCE', name: 'Reliance Industries', price: 3024.10, change: 48.30, percentChange: 1.62, sector: 'Energy', volume: 3429100, marketCap: 20470000000000, peRatio: 29.1, eps: 103.9, dividendYield: .33),
    StockQuote(symbol: 'TCS', name: 'Tata Consultancy Services', price: 3895.45, change: -12.60, percentChange: -.32, sector: 'Technology', volume: 1890000, marketCap: 14090000000000, peRatio: 30.2, eps: 128.9, dividendYield: 1.48),
    StockQuote(symbol: 'HDFCBANK', name: 'HDFC Bank', price: 1692.25, change: 34.10, percentChange: 2.06, sector: 'Financials', volume: 6220000, marketCap: 12900000000000, peRatio: 18.5, eps: 91.4, dividendYield: 1.15),
    StockQuote(symbol: 'INFY', name: 'Infosys', price: 1542.80, change: 22.90, percentChange: 1.51, sector: 'Technology', volume: 4210000, marketCap: 6390000000000, peRatio: 24.0, eps: 64.3, dividendYield: 2.62),
  ];

  @override Future<List<StockQuote>> indices() async => _quotes.take(5).toList();

  @override Future<List<StockQuote>> search(String query) async {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return const [];
    return _quotes.where((quote) =>
      quote.symbol.toLowerCase().contains(normalized) ||
      quote.name.toLowerCase().contains(normalized)).toList();
  }
}
