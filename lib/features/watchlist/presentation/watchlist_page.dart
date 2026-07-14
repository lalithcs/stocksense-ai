import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/services/local_store.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});
  @override Widget build(BuildContext context) {
    final box = Hive.box<String>(LocalStore.watchlistBox);
    return Scaffold(appBar: AppBar(title: const Text('Watchlist')), body: ValueListenableBuilder<Box<String>>(
      valueListenable: box.listenable(), builder: (_, value, __) => value.isEmpty ? const Center(child: Text('Save stocks here to track them.')) : ReorderableListView(children: [for (var index = 0; index < value.length; index++) ListTile(key: ValueKey(value.keyAt(index)), title: Text(value.getAt(index)!), trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => value.deleteAt(index)), onTap: () => context.push('/stock/${value.getAt(index)}'))], onReorder: (oldIndex, newIndex) async { if (newIndex > oldIndex) newIndex--; final symbol = value.getAt(oldIndex)!; await value.deleteAt(oldIndex); await value.putAt(newIndex, symbol); }),
    ), floatingActionButton: FloatingActionButton.extended(onPressed: () => context.go('/search'), icon: const Icon(Icons.add), label: const Text('Add stock')));
  }
}
