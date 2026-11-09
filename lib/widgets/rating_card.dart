import 'package:flutter/material.dart';

class RatingCard extends StatefulWidget {
  const RatingCard({
    super.key, //
    required this.index, //
    required this.name, //
  });

  final int index;
  final String name;

  @override
  State<RatingCard> createState() => _RatingCardState();
}

class _RatingCardState extends State<RatingCard> {
  int _rating = 0;

  void _incrementRating() {
    if (_rating >= 5) return;
    setState(() => _rating++);
  }

  void _decrementRating() {
    if (_rating <= 0) return;
    setState(() => _rating--);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(padding: const EdgeInsets.all(12), child: _mainRow()),
    );
  }

  Widget _mainRow() {
    return Row(
      children: [
        _name(), //
        _ratingIconsList(), //
        _buttonsList(), //
        _dragHandle(), //
      ],
    );
  }

  Widget _dragHandle() {
    return ReorderableDragStartListener(
      index: widget.index,
      child: const Icon(Icons.drag_handle),
    );
  }

  Widget _buttonsList() {
    return Column(
      children: [
        Row(children: [_incrementButton(), _decrementButton()]),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _incrementButton() {
    return Card(
      child: IconButton(
        onPressed: _incrementRating,
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _decrementButton() {
    return Card(
      child: IconButton(
        onPressed: _decrementRating,
        icon: const Icon(Icons.remove),
      ),
    );
  }

  Widget _name() {
    return Expanded(
      child: Text(
        widget.name,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
    );
  }

  Widget _ratingIconsList() {
    return Column(
      children: [
        Row(
          children: [
            _ratingIcon(1),
            _ratingIcon(2),
            _ratingIcon(3),
            _ratingIcon(4),
            _ratingIcon(5),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _ratingIcon(int position) {
    return Row(
      children: [
        Icon(
          position <= _rating ? Icons.star : Icons.star_outline,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
