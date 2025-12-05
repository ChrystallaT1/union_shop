import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CollectionsScreen Widget Tests', () {
    testWidgets('Collections screen can be rendered',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Collections'),
            ),
          ),
        ),
      );

      expect(find.text('Collections'), findsOneWidget);
    });

    testWidgets('Collection cards layout test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GridView.count(
              crossAxisCount: 2,
              children: [
                Card(child: Text('Hoodies')),
                Card(child: Text('T-Shirts')),
              ],
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(Card), findsNWidgets(2));
      expect(find.text('Hoodies'), findsOneWidget);
      expect(find.text('T-Shirts'), findsOneWidget);
    });
  });
}
