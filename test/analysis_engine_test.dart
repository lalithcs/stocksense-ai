import 'package:flutter_test/flutter_test.dart';
import 'package:stocksense_ai/features/analysis/domain/analysis_engine.dart';
import 'package:stocksense_ai/features/stock/domain/stock_quote.dart';

void main() {
  test('positive, reasonably valued stock produces a buy signal', () {
    final quote = StockQuote(symbol: 'TEST', name: 'Test', price: 100, change: 2, percentChange: 2, sector: 'Tech', peRatio: 20, eps: 5);
    expect(AnalysisEngine.evaluate(quote).recommendation, 'Buy');
  });
}
