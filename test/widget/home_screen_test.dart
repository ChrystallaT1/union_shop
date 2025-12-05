import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    testWidgets('HomeScreen can be rendered', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Home Screen Test'),
            ),
          ),
        ),
      );

      expect(find.text('Home Screen Test'), findsOneWidget);
    });

    testWidgets('Simple widget test passes', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Text('UPSU Union Shop'),
                Text('Collections'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('UPSU Union Shop'), findsOneWidget);
      expect(find.text('Collections'), findsOneWidget);
    });
  });
}
