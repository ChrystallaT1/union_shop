import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/cart_service.dart';
import 'package:union_shop/models/cart_item_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CartService Tests', () {
    late CartService cartService;

    setUp(() async {
      cartService = CartService();
      await cartService.clearCart(); // Start with empty cart
    });

    test('Cart starts empty', () {
      expect(cartService.itemCount, 0);
      expect(cartService.totalPrice, 0.0);
    });

    test('Add item to cart increases item count', () async {
      await cartService.addToCart(CartItemModel(
        productId: 'test1',
        productName: 'Test Hoodie',
        productImage: 'test.png',
        price: 29.99,
        quantity: 1,
        selectedSize: 'M',
        selectedColor: 'Black',
      ));

      expect(cartService.itemCount, 1);
    });

    test('Add multiple items calculates total correctly', () async {
      await cartService.addToCart(CartItemModel(
        productId: 'test1',
        productName: 'Hoodie',
        productImage: 'test.png',
        price: 29.99,
        quantity: 2,
        selectedSize: 'M',
        selectedColor: 'Black',
      ));

      await cartService.addToCart(CartItemModel(
        productId: 'test2',
        productName: 'T-Shirt',
        productImage: 'test.png',
        price: 15.99,
        quantity: 1,
        selectedSize: 'L',
        selectedColor: 'Navy',
      ));

      expect(cartService.itemCount, 3); // 2 + 1
      expect(cartService.totalPrice, closeTo(75.97, 0.01)); // (29.99*2) + 15.99
    });

    test('Update quantity changes total price', () async {
      await cartService.addToCart(CartItemModel(
        productId: 'test1',
        productName: 'Test',
        productImage: 'test.png',
        price: 20.00,
        quantity: 1,
        selectedSize: 'M',
        selectedColor: 'Black',
      ));

      await cartService.updateQuantity(0, 3);

      expect(cartService.itemCount, 3);
      expect(cartService.totalPrice, 60.00);
    });

    test('Remove item from cart works correctly', () async {
      await cartService.addToCart(CartItemModel(
        productId: 'test1',
        productName: 'Test',
        productImage: 'test.png',
        price: 20.00,
        quantity: 1,
        selectedSize: 'M',
        selectedColor: 'Black',
      ));

      await cartService.removeItem(0);

      expect(cartService.itemCount, 0);
      expect(cartService.totalPrice, 0.0);
    });

    test('Clear cart removes all items', () async {
      await cartService.addToCart(CartItemModel(
        productId: 'test1',
        productName: 'Test1',
        productImage: 'test.png',
        price: 20.00,
        quantity: 1,
        selectedSize: 'M',
        selectedColor: 'Black',
      ));

      await cartService.addToCart(CartItemModel(
        productId: 'test2',
        productName: 'Test2',
        productImage: 'test.png',
        price: 30.00,
        quantity: 2,
        selectedSize: 'L',
        selectedColor: 'Navy',
      ));

      await cartService.clearCart();

      expect(cartService.itemCount, 0);
      expect(cartService.cartItems, isEmpty);
    });

    test('Adding same product twice merges quantities', () async {
      await cartService.addToCart(CartItemModel(
        productId: 'test1',
        productName: 'Test',
        productImage: 'test.png',
        price: 25.00,
        quantity: 2,
        selectedSize: 'M',
        selectedColor: 'Black',
      ));

      await cartService.addToCart(CartItemModel(
        productId: 'test1',
        productName: 'Test',
        productImage: 'test.png',
        price: 25.00,
        quantity: 1,
        selectedSize: 'M',
        selectedColor: 'Black',
      ));

      expect(cartService.itemCount, 3); // 2 + 1 merged
      expect(cartService.cartItems.length, 1); // Only one cart entry
    });
  });
}
