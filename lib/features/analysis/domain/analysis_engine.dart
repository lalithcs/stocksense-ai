import '../../stock/domain/stock_quote.dart';

class AnalysisInsight {
  const AnalysisInsight({required this.recommendation, required this.confidence, required this.reasons});
  final String recommendation;
  final int confidence;
  final List<String> reasons;
}

abstract final class AnalysisEngine {
  static AnalysisInsight evaluate(StockQuote quote) {
    final bullish = quote.percentChange > 0;
    final quality = (quote.peRatio ?? 30) < 28 && (quote.eps ?? 0) > 0;
    final score = (bullish ? 35 : 15) + (quality ? 35 : 15) + 20;
    return AnalysisInsight(
      recommendation: score >= 65 ? 'Buy' : score >= 45 ? 'Hold' : 'Sell',
      confidence: score,
      reasons: [
        bullish ? 'Positive price momentum supports the current trend.' : 'Price momentum is currently weak.',
        quality ? 'Valuation and earnings inputs are favourable.' : 'Fundamental inputs need closer review.',
        'This local rule-based insight is educational, not investment advice.',
      ],
    );
  }
}
