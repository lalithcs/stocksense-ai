Exit code: 0
Wall time: 5.3 seconds
Output:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../analysis/domain/analysis_engine.dart';
import '../../dashboard/presentation/market_providers.dart';
import '../domain/stock_quote.dart';

class StockDetailPage extends ConsumerWidget {
  const StockDetailPage({required this.symbol, super.key});
  final String symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(marketRepositoryProvider);
    return FutureBuilder<List<StockQuote>>(
      future: repository.search(symbol),
      builder: (context, snapshot) {
        final matches = snapshot.data;
        final quote = matches?.where((item) => item.symbol == symbol).cast<StockQuote?>().firstOrNull;
        if (quote == null) return Scaffold(appBar: AppBar(), body: const Center(child: CircularProgressIndicator()));
        final insight = AnalysisEngine.evaluate(quote);
        return Scaffold(
          appBar: AppBar(title: Text(quote.symbol)),
          body: ListView(padding: const EdgeInsets.all(16), children: [
            Text(quote.name, style: Theme.of(context).textTheme.headlineSmall),
            Text('${quote.exchange} â€¢ ${quote.sector}'),
            const SizedBox(height: 20),
            Text('â‚¹${quote.price.toStringAsFixed(2)}', style: Theme.of(context).textTheme.displaySmall),
            Text('${quote.change >= 0 ? '+' : ''}${quote.percentChange.toStringAsFixed(2)}% today',
              style: TextStyle(color: quote.isPositive ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _MetricGrid(quote: quote),
            const SizedBox(height: 24),
            Text('AI insight', style: Theme.of(context).textTheme.titleLarge),
            Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(insight.recommendation, style: Theme.of(context).textTheme.titleMedium),
              Text('Confidence: ${insight.confidence}%'),
              const SizedBox(height: 8),
              ...insight.reasons.map((reason) => Padding(padding: const EdgeInsets.only(bottom: 4), child: Text('â€¢ $reason'))),
            ]))),
          ]),
        );
      },
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.quote});
  final StockQuote quote;
  @override
  Widget build(BuildContext context) {
    final values = {'P/E': quote.peRatio?.toStringAsFixed(1) ?? 'â€”', 'EPS': quote.eps?.toStringAsFixed(2) ?? 'â€”', 'Volume': quote.volume.toString(), 'Dividend yield': quote.dividendYield == null ? 'â€”' : '${quote.dividendYield}%'};
    return GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 2.7,
      children: values.entries.map((entry) => Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(entry.key), Text(entry.value, style: Theme.of(context).textTheme.titleMedium)])))).toList());
  }
}

