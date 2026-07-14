import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/services/local_store.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});
  @override Widget build(BuildContext context) {
    final box = Hive.box<Map>(LocalStore.portfolioBox);
    return Scaffold(appBar: AppBar(title: const Text('Portfolio')), body: ValueListenableBuilder<Box<Map>>(valueListenable: box.listenable(), builder: (_, holdings, __) {
      final invested = holdings.values.fold<double>(0, (sum, item) => sum + ((item['quantity'] as num) * (item['cost'] as num)));
      return ListView(padding: const EdgeInsets.all(16), children: [Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Total investment'), Text('â‚¹${invested.toStringAsFixed(2)}', style: Theme.of(context).textTheme.headlineMedium), const Text('Add holdings to see performance and sector allocation.')])), const SizedBox(height: 16), ...holdings.values.map((item) => ListTile(title: Text(item['symbol'] as String), subtitle: Text('${item['quantity']} shares at â‚¹${item['cost']}'), trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => holdings.delete(item['symbol'])))]);
    }), floatingActionButton: FloatingActionButton.extended(onPressed: () => _addHolding(context, box), icon: const Icon(Icons.add), label: const Text('Add holding')));
  }
  Future<void> _addHolding(BuildContext context, Box<Map> box) async {
    final symbol = TextEditingController(); final quantity = TextEditingController(); final cost = TextEditingController();
    await showDialog<void>(context: context, builder: (context) => AlertDialog(title: const Text('Add holding'), content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: symbol, decoration: const InputDecoration(labelText: 'Symbol')), TextField(controller: quantity, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Quantity')), TextField(controller: cost, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Average cost'))]), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')), FilledButton(onPressed: () { final q = double.tryParse(quantity.text); final c = double.tryParse(cost.text); if (symbol.text.isNotEmpty && q != null && c != null) { box.put(symbol.text.toUpperCase(), {'symbol': symbol.text.toUpperCase(), 'quantity': q, 'cost': c}); Navigator.pop(context); } }, child: const Text('Save'))]));
    symbol.dispose(); quantity.dispose(); cost.dispose();
  }
}
