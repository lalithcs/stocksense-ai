import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/market_repository.dart';
import '../../stock/domain/stock_quote.dart';

final marketRepositoryProvider = Provider<MarketRepository>(
  (ref) => DemoMarketRepository(),
);

final indicesProvider = FutureProvider<List<StockQuote>>(
  (ref) => ref.watch(marketRepositoryProvider).indices(),
);
