import 'package:flutter/material.dart';

import '../widgets/rating_card.dart';
import '../widgets/section_header.dart';

class ValueKeyDemoScreen extends StatefulWidget {
  const ValueKeyDemoScreen({super.key});

  @override
  State<ValueKeyDemoScreen> createState() => _ValueKeyDemoScreenState();
}

class _ValueKeyDemoScreenState extends State<ValueKeyDemoScreen> {
  final List<String> _nameList = ['Justin', 'Harry'];
  final List<String> _nameList2 = ['Justin', 'Harry'];

  // ReorderableListView requires a key. These stay on the position, so State does not follow the label.
  final List<Key> _keys = [UniqueKey(), UniqueKey()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ValueKey Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _heading(),
            const SizedBox(height: 24),
            _withoutValueKeySection(),
            const SizedBox(height: 32),
            _withValueKeySection(),
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

  Column _withoutValueKeySection() {
    return Column(
      children: [
        const SectionHeader(
          title: 'Without ValueKey',
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
              final String item = _nameList.removeAt(oldIndex);
              _nameList.insert(newIndex, item);
            });
          },
          children: [
            for (var index = 0; index < _nameList.length; index++)
              RatingCard(
                index: index,
                key: _keys[index], 
                name: _nameList[index],
              ),
          ],
        ),
      ],
    );
  }

  Column _withValueKeySection() {
    return Column(
      children: [
        const SectionHeader(
          title: 'With ValueKey',
          subtitle: 'Each card has ValueKey(id). Drag the handle and the rating follows the card.',
          isProblem: false,
        ),
        const SizedBox(height: 8),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          buildDefaultDragHandles: false,
          onReorderItem: (int oldIndex, int newIndex) {
            setState(() {
              final String item = _nameList2.removeAt(oldIndex);
              _nameList2.insert(newIndex, item);
            });
          },
          children: [
            for (var index = 0; index < _nameList2.length; index++)
              RatingCard(
                index: index,
                key: ValueKey(_nameList2[index]),
                name: _nameList2[index],
              ),
          ],
        ),
      ],
    );
  }
}
