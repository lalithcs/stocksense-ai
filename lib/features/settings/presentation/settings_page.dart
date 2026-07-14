import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/theme.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});
  @override Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    return Scaffold(appBar: AppBar(title: const Text('Settings')), body: ListView(children: [
      const Padding(padding: EdgeInsets.fromLTRB(16, 20, 16, 4), child: Text('Appearance')),
      ...ThemeMode.values.map((value) => RadioListTile<ThemeMode>(title: Text(value.name[0].toUpperCase() + value.name.substring(1)), value: value, groupValue: mode, onChanged: (next) { if (next != null) ref.read(themeModeProvider.notifier).setTheme(next); })),
      const Divider(), const ListTile(title: Text('About StockSense AI'), subtitle: Text('Local-first stock research companion. Not investment advice.')),
    ]));
  }
}
