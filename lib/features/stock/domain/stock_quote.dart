class StockQuote {
  const StockQuote({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
    required this.percentChange,
    required this.sector,
    this.exchange = 'NSE',
    this.volume = 0,
    this.marketCap = 0,
    this.peRatio,
    this.eps,
    this.dividendYield,
  });

  final String symbol;
  final String name;
  final double price;
  final double change;
  final double percentChange;
  final String sector;
  final String exchange;
  final int volume;
  final double marketCap;
  final double? peRatio;
  final double? eps;
  final double? dividendYield;

  bool get isPositive => change >= 0;

  Map<String, dynamic> toMap() => {
    'symbol': symbol, 'name': name, 'price': price, 'change': change,
    'percentChange': percentChange, 'sector': sector, 'exchange': exchange,
    'volume': volume, 'marketCap': marketCap, 'peRatio': peRatio, 'eps': eps,
    'dividendYield': dividendYield,
  };

  factory StockQuote.fromMap(Map<dynamic, dynamic> map) => StockQuote(
    symbol: map['symbol'] as String, name: map['name'] as String,
    price: (map['price'] as num).toDouble(),
    change: (map['change'] as num).toDouble(),
    percentChange: (map['percentChange'] as num).toDouble(),
    sector: map['sector'] as String, exchange: map['exchange'] as String? ?? 'NSE',
    volume: (map['volume'] as num?)?.toInt() ?? 0,
    marketCap: (map['marketCap'] as num?)?.toDouble() ?? 0,
    peRatio: (map['peRatio'] as num?)?.toDouble(), eps: (map['eps'] as num?)?.toDouble(),
    dividendYield: (map['dividendYield'] as num?)?.toDouble(),
  );
}
