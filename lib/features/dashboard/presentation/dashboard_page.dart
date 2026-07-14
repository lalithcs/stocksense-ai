Exit code: 0
Wall time: 6.3 seconds
Output:
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/quote_card.dart';
import 'market_providers.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indices = ref.watch(indicesProvider);
    return CustomScrollView(slivers: [
      SliverAppBar(
        floating: true,
        title: const Text('StockSense AI'),
        actions: [IconButton(onPressed: () => context.go('/search'), icon: const Icon(Icons.search))],
      ),
      SliverPadding(
        padding: const EdgeInsets.all(16),
        sliver: indices.when(
          loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
          error: (_, __) => SliverFillRemaining(child: _ErrorView(onRetry: () => ref.invalidate(indicesProvider))),
          data: (quotes) => SliverList(delegate: SliverChildListDelegate([
            Text('Market overview', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 6),
            Text('Live data is refreshed when you reconnect.', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 16),
            SizedBox(height: 168, child: ListView.separated(
              scrollDirection: Axis.horizontal, itemCount: quotes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, index) => SizedBox(width: 172, child: QuoteCard(quote: quotes[index])),
            )),
            const SizedBox(height: 28),
            Text('Trending stocks', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            ...quotes.skip(1).map((quote) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(child: Text(quote.symbol.substring(0, 1))),
              title: Text(quote.name), subtitle: Text(quote.sector),
              trailing: Text('${quote.percentChange >= 0 ? '+' : ''}${quote.percentChange.toStringAsFixed(2)}%',
                style: TextStyle(color: quote.isPositive ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),
              onTap: () => context.push('/stock/${quote.symbol}'),
            )),
            const SizedBox(height: 24),
            Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Market summary', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                const Text('Breadth is positive with financials and energy leading today.'),
              ],
            ))),
          ])),
        ),
      ),
    ]);
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});
  final VoidCallback onRetry;
  @override Widget build(BuildContext context) => Center(child: FilledButton.icon(onPressed: onRetry, icon: const Icon(Icons.refresh), label: const Text('Retry')));
}

