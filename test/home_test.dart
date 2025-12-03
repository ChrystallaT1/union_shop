import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/main.dart';

void main() {
  group('Home Page Tests', () {
    testWidgets('should display home page with basic elements', (tester) async {
      // Use MyApp instead of UnionShopApp
      await tester.pumpWidget(const MyApp());
      await tester
          .pumpAndSettle(); // Wait for all animations and async operations

      // Check that the navbar is present
      expect(find.text('UPSU Union Shop'), findsOneWidget);

      // Check that hero section is present
      expect(find.text('Welcome to UPSU Shop'), findsOneWidget);
      expect(
        find.text(
            'Official merchandise and essentials for Portsmouth students'),
        findsOneWidget,
      );

      // Check that browse button exists
      expect(find.text('BROWSE PRODUCTS'), findsOneWidget);

      // Check that featured products section exists
      expect(find.text('FEATURED PRODUCTS'), findsOneWidget);
      expect(find.text('VIEW ALL PRODUCTS'), findsOneWidget);
    });

    testWidgets('should display navbar elements', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Check navbar links exist
      expect(find.text('UPSU Union Shop'), findsOneWidget);

      // Check that cart icon is present
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    });

    testWidgets('should navigate to collections page', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Find and tap the browse products button
      final browseButton = find.text('BROWSE PRODUCTS');
      expect(browseButton, findsOneWidget);

      await tester.tap(browseButton);
      await tester.pumpAndSettle();

      // Verify navigation to collections page
      expect(find.text('Collections'), findsOneWidget);
    });

    testWidgets('should display featured products', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Check that featured products section is visible
      expect(find.text('FEATURED PRODUCTS'), findsOneWidget);

      // Check that at least one product card is displayed
      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('should display footer', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Scroll to bottom to see footer
      await tester.dragUntilVisible(
        find.text('© 2025 UPSU Union Shop'),
        find.byType(SingleChildScrollView),
        const Offset(0, -300),
      );

      // Check that footer is present
      expect(find.text('© 2025 UPSU Union Shop'), findsOneWidget);
      expect(
        find.text('This is a coursework project, not the real shop.'),
        findsOneWidget,
      );
    });

    testWidgets('should open mobile drawer on small screens', (tester) async {
      // Set a small screen size
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Find and tap the menu icon
      final menuButton = find.byIcon(Icons.menu);
      expect(menuButton, findsOneWidget);

      await tester.tap(menuButton);
      await tester.pumpAndSettle();

      // Check that drawer opened
      expect(find.text('Menu'), findsOneWidget);

      // Reset screen size
      addTearDown(tester.view.resetPhysicalSize);
    });

    testWidgets('should display cart icon in navbar', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Check that cart icon is present
      expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    });

    testWidgets('should navigate to cart page when cart icon is tapped',
        (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Find and tap the cart icon
      final cartIcon = find.byIcon(Icons.shopping_cart_outlined);
      expect(cartIcon, findsOneWidget);

      await tester.tap(cartIcon);
      await tester.pumpAndSettle();

      // Verify navigation to cart page
      expect(find.text('Shopping Cart'), findsOneWidget);
    });

    testWidgets('should display "View All Products" button', (tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Scroll to find the button
      await tester.dragUntilVisible(
        find.text('VIEW ALL PRODUCTS'),
        find.byType(SingleChildScrollView),
        const Offset(0, -100),
      );

      expect(find.text('VIEW ALL PRODUCTS'), findsOneWidget);

      // Tap the button
      await tester.tap(find.text('VIEW ALL PRODUCTS'));
      await tester.pumpAndSettle();

      // Verify navigation to collections
      expect(find.text('Collections'), findsOneWidget);
    });
  });
}
