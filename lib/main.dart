import 'package:flutter/material.dart';

import 'menu_screen.dart';

/// Starts the app at [MyApp].
void main() {
  runApp(const MyApp());
}

/// Root widget. Sets the theme and opens [MenuScreen].
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Keys Demo',
      theme: _buildTheme(),
      home: const MenuScreen(),
    );
  }

  /// Deep purple seed. Flutter fills the rest of the color scheme from it.
  static ThemeData _buildTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    );
  }
}
