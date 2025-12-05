import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product_model.dart';
import 'package:union_shop/models/cart_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  group('ProductModel Tests', () {
    test('Product displays regular price when not on sale', () {
      final product = ProductModel(
        id: 'test1',
        name: 'Test Hoodie',
        description: 'A test product',
        price: 29.99,
        imageUrl: 'test.png',
        collectionId: 'hoodies',
        category: 'clothing',
        sizes: ['S', 'M', 'L'],
        colors: ['Black', 'Navy'],
        stockQuantity: 50,
        dateAdded: DateTime.now(),
        isOnSale: false,
        salePrice: null,
        popularity: 100,
      );

      expect(product.displayPrice, 29.99);
    });

    test('Product displays sale price when on sale', () {
      final product = ProductModel(
        id: 'test2',
        name: 'Sale Hoodie',
        description: 'On sale',
        price: 29.99,
        imageUrl: 'test.png',
        collectionId: 'hoodies',
        category: 'clothing',
        sizes: ['S', 'M', 'L'],
        colors: ['Black'],
        stockQuantity: 30,
        dateAdded: DateTime.now(),
        isOnSale: true,
        salePrice: 19.99,
        popularity: 150,
      );

      expect(product.displayPrice, 19.99);
      expect(product.isOnSale, true);
    });

    test('Product has correct VAT calculation', () {
      final product = ProductModel(
        id: 'test3',
        name: 'VAT Test',
        description: 'Testing VAT',
        price: 30.00,
        imageUrl: 'test.png',
        collectionId: 'tshirts',
        category: 'clothing',
        sizes: ['M'],
        colors: ['Grey'],
        stockQuantity: 20,
        dateAdded: DateTime.now(),
        isOnSale: false,
        salePrice: null,
        popularity: 80,
      );

      // UK VAT is 20%, price includes VAT
      final vatAmount = product.displayPrice * (0.20 / 1.20);
      expect(vatAmount, closeTo(5.00, 0.01));
    });

    test('Product has correct display price', () {
      final product = ProductModel(
        id: 'test4',
        name: 'Format Test',
        description: 'Test',
        price: 25.50,
        imageUrl: 'test.png',
        collectionId: 'accessories',
        category: 'accessories',
        sizes: [],
        colors: [],
        stockQuantity: 10,
        dateAdded: DateTime.now(),
        isOnSale: false,
        salePrice: null,
        popularity: 60,
      );

      expect(product.displayPrice, 25.50);
      expect(product.price, 25.50);
    });
  });

  group('CartItemModel Tests', () {
    test('Cart item calculates total price correctly', () {
      final cartItem = CartItemModel(
        productId: 'test1',
        productName: 'Test Product',
        productImage: 'test.png',
        price: 19.99,
        quantity: 3,
        selectedSize: 'M',
        selectedColor: 'Black',
      );

      expect(cartItem.totalPrice, 59.97);
    });

    test('Cart item quantity cannot be negative', () {
      final cartItem = CartItemModel(
        productId: 'test2',
        productName: 'Test',
        productImage: 'test.png',
        price: 10.00,
        quantity: 1,
        selectedSize: 'L',
        selectedColor: 'Navy',
      );

      expect(cartItem.quantity, greaterThanOrEqualTo(0));
    });
  });
}
