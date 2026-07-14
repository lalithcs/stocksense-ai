import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../dashboard/presentation/market_providers.dart';
import '../../stock/domain/stock_quote.dart';
import '../../../core/services/local_store.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});
  @override ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  Timer? _debounce;
  List<StockQuote> _results = const [];
  bool _loading = false;
  Future<void> _search(String value) async {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      if (value.trim().isEmpty) return setState(() => _results = const []);
      setState(() => _loading = true);
      final results = await ref.read(marketRepositoryProvider).search(value);
      if (!mounted) return;
      setState(() { _results = results; _loading = false; });
    });
  }
  @override void dispose() { _debounce?.cancel(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Search stocks')),
    body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
      TextField(onChanged: _search, autofocus: true, decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Ticker or company name')),
      const SizedBox(height: 16),
      if (_loading) const LinearProgressIndicator(),
      Expanded(child: _results.isEmpty ? ValueListenableBuilder<Box<String>>(valueListenable: Hive.box<String>(LocalStore.searchBox).listenable(), builder: (_, box, __) => ListView(children: [const Text('Recent searches'), ...box.values.map((item) => ListTile(title: Text(item), onTap: () => _search(item)))])) : ListView(children: _results.map((quote) => ListTile(title: Text(quote.symbol), subtitle: Text(quote.name), trailing: Text('â‚¹${quote.price.toStringAsFixed(2)}'), onTap: () async { await Hive.box<String>(LocalStore.searchBox).put(quote.symbol, quote.symbol); if (mounted) context.push('/stock/${quote.symbol}'); })).toList())),
    ])),
  );
}
