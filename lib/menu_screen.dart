import 'package:flutter/material.dart';

import 'widgets/demo_tile.dart';
import 'screens/global_key_demo_screen.dart';
import 'screens/object_key_demo_screen.dart';
import 'screens/unique_key_demo_screen.dart';
import 'screens/value_key_demo_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [_buildIntro(), ..._buildDemoTiles(context)],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Flutter Keys Demo'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    );
  }

  Widget _buildIntro() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        'Each demo shows: without key → problem, with key → solution.',
        style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
      ),
    );
  }

  List<Widget> _buildDemoTiles(BuildContext context) {
    return [
      DemoTile(
        title: 'ValueKey',
        subtitle: 'Reorder: rating stays at that position, or follows its ValueKey',
        icon: Icons.drag_handle,
        onTap: () => _push(context, const ValueKeyDemoScreen()),
      ),
      DemoTile(
        title: 'UniqueKey',
        subtitle: 'Reused position: old state persists vs fresh state',
        icon: Icons.refresh,
        onTap: () => _push(context, const UniqueKeyDemoScreen()),
      ),
      DemoTile(
        title: 'ObjectKey',
        subtitle: 'List of objects: state by position vs by object',
        icon: Icons.category,
        onTap: () => _push(context, const ObjectKeyDemoScreen()),
      ),
      DemoTile(
        title: 'GlobalKey',
        subtitle: 'Access child state from parent (e.g. validate form)',
        icon: Icons.key,
        onTap: () => _push(context, const GlobalKeyDemoScreen()),
      ),
    ];
  }

  void _push(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }
}
