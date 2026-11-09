import 'package:flutter/material.dart';

import '../widgets/section_header.dart';
import '../widgets/counter_widget.dart';

class UniqueKeyDemoScreen extends StatefulWidget {
  const UniqueKeyDemoScreen({super.key});

  @override
  State<UniqueKeyDemoScreen> createState() => _UniqueKeyDemoScreenState();
}

class _UniqueKeyDemoScreenState extends State<UniqueKeyDemoScreen> {
  int _rebuildCountWithout = 0;
  Key _keyWith = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _heading(),
            const SizedBox(height: 24),
            _withoutUniqueKeySection(context),
            const SizedBox(height: 32),
            _withUniqueKeySection(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('UniqueKey Demo'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    );
  }

  Text _heading() {
    return const Text(
      'Scenario: One counter widget. You want a "Reset" that recreates the widget '
      '(fresh state). The widget stays in the tree; we only change whether its key changes.',
      style: TextStyle(fontSize: 14),
    );
  }

  Widget _withoutUniqueKeySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: 'Without UniqueKey on Reset',
          subtitle:
              'We use no key. "Reset" calls setState() but the key does not change. '
              'Flutter matches by position/type → reuses same State → counter does NOT reset.',
          isProblem: true,
        ),
        const SizedBox(height: 8),
        const CounterWidget(label: 'Counter'),
        ElevatedButton(
          onPressed: () => setState(() => _rebuildCountWithout++),
          child: Text(
            'Reset (setState only, key unchanged) — tapped $_rebuildCountWithout times',
          ),
        ),
      ],
    );
  }

  Widget _withUniqueKeySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: 'With UniqueKey() on Reset',
          subtitle:
              'On "Reset" we assign a new UniqueKey() to the widget. '
              'Flutter sees a new key → new widget → new State → counter resets to 0.',
          isProblem: false,
        ),
        const SizedBox(height: 8),
        CounterWidget(key: _keyWith, label: 'Counter'),
        ElevatedButton(
          onPressed: () => setState(() => _keyWith = UniqueKey()),
          child: const Text('Reset (new UniqueKey() → fresh state)'),
        ),
      ],
    );
  }
}
