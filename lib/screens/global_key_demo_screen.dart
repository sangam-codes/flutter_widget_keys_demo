import 'package:flutter/material.dart';

import '../widgets/demo_child_form.dart';
import '../widgets/section_header.dart';

class GlobalKeyDemoScreen extends StatefulWidget {
  const GlobalKeyDemoScreen({super.key});

  @override
  State<GlobalKeyDemoScreen> createState() => _GlobalKeyDemoScreenState();
}

class _GlobalKeyDemoScreenState extends State<GlobalKeyDemoScreen> {
  final GlobalKey<DemoChildFormState> _formKey =
      GlobalKey<DemoChildFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GlobalKey Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _heading(),
            const SizedBox(height: 24),
            _withoutGlobalKeySection(context),
            const SizedBox(height: 32),
            _withGlobalKeySection(context),
          ],
        ),
      ),
    );
  }

  Widget _heading() {
    return const Text(
      'Scenario: A parent has a "Validate" button and needs to call validate() '
      'on a child Form. Without GlobalKey the parent has no reference to the child\'s State.',
      style: TextStyle(fontSize: 14),
    );
  }

  Widget _withoutGlobalKeySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: 'Without GlobalKey',
          subtitle:
              'Parent cannot access the child\'s State. There is no way to call '
              'child.validate() or read child state from the parent.',
          isProblem: true,
        ),
        const SizedBox(height: 8),
        const DemoChildForm(),
        ElevatedButton(
          onPressed: () => _showCannotValidateSnackBar(context),
          child: const Text('Validate (no key)'),
        ),
      ],
    );
  }

  Widget _withGlobalKeySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionHeader(
          title: 'With GlobalKey<DemoChildFormState>',
          subtitle:
              'Parent holds formKey. Child is built with key: formKey. '
              'Parent can call formKey.currentState?.validate().',
          isProblem: false,
        ),
        const SizedBox(height: 8),
        DemoChildForm(key: _formKey),
        ElevatedButton(
          onPressed: _onValidateWithKey,
          child: const Text('Validate (uses GlobalKey)'),
        ),
      ],
    );
  }

  void _showCannotValidateSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Cannot validate from parent — no reference to child State.',
        ),
      ),
    );
  }

  void _onValidateWithKey() {
    _formKey.currentState?.validate();
    if (_formKey.currentState?.isValid ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Valid!'), backgroundColor: Colors.green),
      );
    }
  }
}
