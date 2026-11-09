import 'package:flutter/material.dart';

/// Reusable header for demo sections (problem vs solution).
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isProblem,
  });

  final String title;
  final String subtitle;
  final bool isProblem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _buildDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitleRow(),
          const SizedBox(height: 6),
          _buildSubtitle(),
        ],
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: isProblem ? Colors.red.shade50 : Colors.green.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isProblem ? Colors.red.shade200 : Colors.green.shade200,
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      children: [
        Icon(
          isProblem ? Icons.warning_amber : Icons.check_circle,
          color: isProblem ? Colors.red.shade700 : Colors.green.shade700,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isProblem ? Colors.red.shade900 : Colors.green.shade900,
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Text(
      subtitle,
      style: TextStyle(
        fontSize: 13,
        color: isProblem ? Colors.red.shade800 : Colors.green.shade800,
      ),
    );
  }
}
