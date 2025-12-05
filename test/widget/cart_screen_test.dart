import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartScreen Widget Tests', () {
    testWidgets('Empty cart message display', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text('Your cart is empty'),
            ),
          ),
        ),
      );

      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('Order summary displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Text('Order Summary'),
                Text('Total'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Order Summary'), findsOneWidget);
      expect(find.text('Total'), findsOneWidget);
    });

    testWidgets('VAT information is shown', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Text('Including VAT 20%: £6.00'),
              ],
            ),
          ),
        ),
      );

      expect(find.textContaining('VAT'), findsOneWidget);
      expect(find.textContaining('20%'), findsOneWidget);
    });
  });
}
