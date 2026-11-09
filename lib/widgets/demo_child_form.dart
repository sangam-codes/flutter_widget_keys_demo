import 'package:flutter/material.dart';

/// Child form whose state we want to access from the parent (e.g. validate, get value).
/// Used in GlobalKey demo.
class DemoChildForm extends StatefulWidget {
  const DemoChildForm({super.key});

  @override
  State<DemoChildForm> createState() => DemoChildFormState();
}

class DemoChildFormState extends State<DemoChildForm> {
  final _controller = TextEditingController();
  String? _error;

  void validate() {
    setState(() {
      if (_controller.text.isEmpty) {
        _error = 'Cannot be empty';
      } else {
        _error = null;
      }
    });
  }

  bool get isValid => _controller.text.isNotEmpty;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: _formContent(context),
      ),
    );
  }

  Widget _formContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Child form: enter something'),
        const SizedBox(height: 8),
        _textField(context),
      ],
    );
  }

  Widget _textField(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        errorText: _error,
        border: const OutlineInputBorder(),
      ),
      onChanged: (_) => setState(() => _error = null),
    );
  }
}
