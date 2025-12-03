import 'package:union_shop/models/cart_item_model.dart';

class CartService {
  // Singleton pattern
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  // store cart items in memory
  final List<CartItemModel> _cartItems = [];

  List<CartItemModel> get cartItems => List.unmodifiable(_cartItems);

  //  item count
  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  // total price
  double get totalPrice =>
      _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  bool addToCart(CartItemModel item) {
    try {
      // Check if item with same product, size, and color already exists
      final existingIndex = _cartItems.indexWhere(
        (cartItem) =>
            cartItem.productId == item.productId &&
            cartItem.selectedSize == item.selectedSize &&
            cartItem.selectedColor == item.selectedColor,
      );

      if (existingIndex != -1) {
        // Item exists, increase quantity
        _cartItems[existingIndex].quantity += item.quantity;
      } else {
        // New item, add to cart
        _cartItems.add(item);
      }

      return true;
    } catch (e) {
      print('Error adding to cart: $e');
      return false;
    }
  }

  // Update  quantity
  void updateQuantity(int index, int newQuantity) {
    if (index >= 0 && index < _cartItems.length) {
      if (newQuantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity = newQuantity;
      }
    }
  }

  // Remove item
  void removeItem(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
    }
  }

  void clearCart() {
    _cartItems.clear();
  }

  bool isInCart(String productId, String size, String color) {
    return _cartItems.any(
      (item) =>
          item.productId == productId &&
          item.selectedSize == size &&
          item.selectedColor == color,
    );
  }

  int getItemQuantity(String productId, String size, String color) {
    try {
      final item = _cartItems.firstWhere(
        (item) =>
            item.productId == productId &&
            item.selectedSize == size &&
            item.selectedColor == color,
      );
      return item.quantity;
    } catch (e) {
      return 0;
    }
  }
}
