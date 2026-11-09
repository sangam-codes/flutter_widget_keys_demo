import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_widget_keys_demo/main.dart';
import 'package:flutter_widget_keys_demo/screens/value_key_demo_screen.dart';

void main() {
  testWidgets('keys menu lists the four key demos', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Flutter Keys Demo'), findsOneWidget);
    expect(find.text('ValueKey'), findsOneWidget);
    expect(find.text('UniqueKey'), findsOneWidget);
    expect(find.text('ObjectKey'), findsOneWidget);
    expect(find.text('GlobalKey'), findsOneWidget);
  });

  testWidgets('drag handle sits to the right of the add button', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ValueKeyDemoScreen()));

    expect(find.byIcon(Icons.drag_handle), findsNWidgets(4));

    final Rect dragHandle = tester.getRect(find.byIcon(Icons.drag_handle).first);
    final Rect addButton = tester.getRect(find.byIcon(Icons.add).first);

    expect(dragHandle.left, greaterThan(addButton.right));
    expect((dragHandle.center.dy - addButton.center.dy).abs(), lessThan(24));
  });

  testWidgets('position reorder keeps the rating in place', (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: ValueKeyDemoScreen()));

    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pump();

    final TestGesture drag = await tester.startGesture(
      tester.getCenter(find.byIcon(Icons.drag_handle).first),
    );
    await tester.pump(const Duration(milliseconds: 100));
    await drag.moveBy(const Offset(0, 40));
    await tester.pump();
    await drag.moveBy(const Offset(0, 200));
    await tester.pump();
    await drag.up();
    await tester.pumpAndSettle();

    expect(find.text('Harry'), findsNWidgets(2));
    expect(find.byIcon(Icons.star), findsOneWidget);
    final double starY = tester.getTopLeft(find.byIcon(Icons.star)).dy;
    final double harryY = tester.getTopLeft(find.text('Harry').first).dy;
    expect((starY - harryY).abs(), lessThan(40));
  });
}
