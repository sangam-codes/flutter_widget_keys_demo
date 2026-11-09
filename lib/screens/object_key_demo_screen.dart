import 'package:flutter/material.dart';

import '../models/item.dart';
import '../widgets/rating_card.dart';
import '../widgets/section_header.dart';

class ObjectKeyDemoScreen extends StatefulWidget {
  const ObjectKeyDemoScreen({super.key});

  @override
  State<ObjectKeyDemoScreen> createState() => _ObjectKeyDemoScreenState();
}

class _ObjectKeyDemoScreenState extends State<ObjectKeyDemoScreen> {
  final List<Item> _items = [Item(1, 'Justin'), Item(2, 'Harry')];
  final List<Item> _items2 = [Item(1, 'Justin'), Item(2, 'Harry')];

  // ReorderableListView requires a key. These stay on the position, so State does not follow the label.
  final List<Key> _keys = [UniqueKey(), UniqueKey()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ObjectKey Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _heading(),
            const SizedBox(height: 24),
            _withoutObjectKeySection(),
            const SizedBox(height: 32),
            _withObjectKeySection(),
          ],
        ),
      ),
    );
  }

  Text _heading() {
    return const Text(
      'Each card has its own rating. Move the cards and see which rating stays with which label.',
      style: TextStyle(fontSize: 14),
    );
  }

  Column _withoutObjectKeySection() {
    return Column(
      children: [
        const SectionHeader(
          title: 'Without ObjectKey',
          subtitle: 'These cards are matched by position. Drag one, and the rating stays at that position.',
          isProblem: true,
        ),
        const SizedBox(height: 8),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          buildDefaultDragHandles: false,
          onReorderItem: (int oldIndex, int newIndex) {
            setState(() {
              final Item item = _items.removeAt(oldIndex);
              _items.insert(newIndex, item);
            });
          },
          children: [
            for (var index = 0; index < _items.length; index++)
              RatingCard(
                index: index,
                key: _keys[index],
                name: _items[index].label,
              ),
          ],
        ),
      ],
    );
  }

  Column _withObjectKeySection() {
    return Column(
      children: [
        const SectionHeader(
          title: 'With ObjectKey',
          subtitle: 'Each card has ObjectKey(item). Drag the handle and the rating follows that object.',
          isProblem: false,
        ),
        const SizedBox(height: 8),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          buildDefaultDragHandles: false,
          onReorderItem: (int oldIndex, int newIndex) {
            setState(() {
              final Item item = _items2.removeAt(oldIndex);
              _items2.insert(newIndex, item);
            });
          },
          children: [
            for (var index = 0; index < _items2.length; index++)
              RatingCard(
                index: index,
                key: ObjectKey(_items2[index]),
                name: _items2[index].label,
              ),
          ],
        ),
      ],
    );
  }
}
