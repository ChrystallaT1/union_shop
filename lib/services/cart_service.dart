import 'package:union_shop/models/cart_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class CartService {
  // Singleton pattern
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Store cart items in memory
  final List<CartItemModel> _cartItems = [];

  // ✅ Add ValueNotifier for cart count
  final ValueNotifier<int> cartCountNotifier = ValueNotifier<int>(0);

  List<CartItemModel> get cartItems => List.unmodifiable(_cartItems);

  // Item count
  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Total price
  double get totalPrice =>
      _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  // Calculate subtotal
  double get subtotal => totalPrice;

  // Calculate tax (20% VAT)
  double get tax => subtotal * 0.20;

  // Calculate shipping (free over £50, otherwise £4.99)
  double get shipping => subtotal >= 50.0 ? 0.0 : 4.99;

  // Calculate total with tax and shipping
  double get total => subtotal + tax + shipping;

  // Initialize cart (load from storage)
  Future<void> initializeCart() async {
    final user = _auth.currentUser;

    if (user != null) {
      // Logged-in user - load from Firebase
      await _loadFromFirebase(user.uid);
    } else {
      // Guest user - load from local storage
      await _loadFromLocalStorage();
    }

    // ✅ Update cart count notifier after loading
    cartCountNotifier.value = itemCount;
  }

  // Load cart from Firebase
  Future<void> _loadFromFirebase(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();

      _cartItems.clear();
      for (var doc in snapshot.docs) {
        final data = doc.data();
        _cartItems.add(CartItemModel(
          productId: data['productId'] ?? '',
          productName: data['productName'] ?? '',
          price: (data['price'] ?? 0.0).toDouble(),
          productImage: data['productImage'] ?? '', // ✅ Changed from imageUrl
          selectedSize: data['selectedSize'] ?? '',
          selectedColor: data['selectedColor'] ?? '',
          quantity: data['quantity'] ?? 1,
        ));
      }
    } catch (e) {
      print('Error loading cart from Firebase: $e');
    }
  }

  // Load cart from local storage
  Future<void> _loadFromLocalStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString('guest_cart');

      if (cartJson != null && cartJson.isNotEmpty) {
        final List<dynamic> cartList = json.decode(cartJson);
        _cartItems.clear();
        for (var item in cartList) {
          _cartItems.add(CartItemModel.fromJson(item));
        }
      }
    } catch (e) {
      print('Error loading cart from local storage: $e');
    }
  }

  // Save cart to storage
  Future<void> _saveCart() async {
    final user = _auth.currentUser;

    if (user != null) {
      // Logged-in user - save to Firebase
      await _saveToFirebase(user.uid);
    } else {
      // Guest user - save to local storage
      await _saveToLocalStorage();
    }

    cartCountNotifier.value = itemCount;
  }

  // Save to Firebase
  Future<void> _saveToFirebase(String userId) async {
    try {
      // Clear existing cart in Firebase
      final batch = _firestore.batch();
      final cartDocs = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();

      for (var doc in cartDocs.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      // Add all current items
      for (var item in _cartItems) {
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('cart')
            .add({
          'productId': item.productId,
          'productName': item.productName,
          'price': item.price,
          'productImage': item.productImage,
          'selectedSize': item.selectedSize,
          'selectedColor': item.selectedColor,
          'quantity': item.quantity,
          'addedAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error saving to Firebase: $e');
    }
  }

  // Save to local storage
  Future<void> _saveToLocalStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson =
          json.encode(_cartItems.map((item) => item.toJson()).toList());
      await prefs.setString('guest_cart', cartJson);
    } catch (e) {
      print('Error saving to local storage: $e');
    }
  }

  // Add to cart
  Future<bool> addToCart(CartItemModel item) async {
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

      // Save to storage
      await _saveCart();
      return true;
    } catch (e) {
      print('Error adding to cart: $e');
      return false;
    }
  }

  // Update quantity
  Future<void> updateQuantity(int index, int newQuantity) async {
    if (index >= 0 && index < _cartItems.length) {
      if (newQuantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity = newQuantity;
      }
      await _saveCart();
    }
  }

  // Remove item
  Future<void> removeItem(int index) async {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
      await _saveCart();
    }
  }

  // Clear cart
  Future<void> clearCart() async {
    _cartItems.clear();
    await _saveCart();
  }

  // Check if item is in cart
  bool isInCart(String productId, String size, String color) {
    return _cartItems.any(
      (item) =>
          item.productId == productId &&
          item.selectedSize == size &&
          item.selectedColor == color,
    );
  }

  // Get item quantity
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

  // Sync local cart to Firebase when user logs in
  Future<void> syncCartOnLogin() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      // Get local cart
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString('guest_cart');

      if (cartJson != null && cartJson.isNotEmpty) {
        // There's a local cart, merge it with Firebase cart
        final List<dynamic> localCartList = json.decode(cartJson);
        final localCart =
            localCartList.map((item) => CartItemModel.fromJson(item)).toList();

        // Load Firebase cart first
        await _loadFromFirebase(user.uid);

        // Merge local items into current cart
        for (var localItem in localCart) {
          final existingIndex = _cartItems.indexWhere(
            (item) =>
                item.productId == localItem.productId &&
                item.selectedSize == localItem.selectedSize &&
                item.selectedColor == localItem.selectedColor,
          );

          if (existingIndex != -1) {
            // Item exists, add quantities
            _cartItems[existingIndex].quantity += localItem.quantity;
          } else {
            // New item, add to cart
            _cartItems.add(localItem);
          }
        }

        // Save merged cart to Firebase
        await _saveToFirebase(user.uid);

        // Clear local storage after syncing
        await prefs.remove('guest_cart');
      } else {
        // ✅ No local cart, just load from Firebase
        await _loadFromFirebase(user.uid);
      }

      // ✅ Update cart count notifier
      cartCountNotifier.value = itemCount;
    } catch (e) {
      print('Error syncing cart: $e');
    }
  }

  Future<void> clearCartOnLogout() async {
    try {
      _cartItems.clear();
      cartCountNotifier.value = 0;

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('guest_cart');
    } catch (e) {
      print('Error clearing cart on logout: $e');
    }
  }
}
