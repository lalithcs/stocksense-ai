import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../features/stock/domain/stock_quote.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({required this.quote, this.onTap, super.key});
  final StockQuote quote;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = quote.isPositive ? Colors.green : Theme.of(context).colorScheme.error;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(quote.symbol, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 4),
            Text(NumberFormat.currency(symbol: 'â‚¹', decimalDigits: 2).format(quote.price),
              style: Theme.of(context).textTheme.titleLarge),
            const Spacer(),
            Row(children: [
              Icon(quote.isPositive ? Icons.north_east : Icons.south_east, size: 16, color: color),
              const SizedBox(width: 4),
              Text('${quote.change.abs().toStringAsFixed(2)} (${quote.percentChange.abs().toStringAsFixed(2)}%)',
                style: TextStyle(color: color, fontWeight: FontWeight.w600)),
            ]),
          ]),
        ),
      ),
    );
  }
}
