import 'package:union_shop/models/personalization_model.dart';

/// Model class representing an item in the shopping cart
/// Stores product information, user selections (size, color), and optional personalization
class CartItemModel {
  final String productId;
  final String productName;
  final String productImage;

  final double price;
  final String selectedSize;

  final String selectedColor;

  int quantity;
  final PersonalizationModel? personalization;

  /// Creates a new cart item with all required product details and user selections
  /// [quantity] defaults to 1
  CartItemModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.selectedSize,
    required this.selectedColor,
    this.quantity = 1,
    this.personalization,
  });

  /// Calculate the total price for this cart item
  double get totalPrice =>
      (price + (personalization?.additionalCost ?? 0.0)) * quantity;

  /// Convert cart item to JSON format for local storage
  /// Note: Personalization is not included in basic JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'productImage': productImage,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
      'quantity': quantity,
    };
  }

  /// Create a CartItemModel from JSON data (deserialization)
  /// Used when loading saved cart from local storage
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      productImage: json['productImage'] ?? '',
      selectedSize: json['selectedSize'] ?? '',
      selectedColor: json['selectedColor'] ?? '',
      quantity: json['quantity'] ?? 1,
    );
  }

  CartItemModel copyWith({
    String? productId,
    String? productName,
    String? productImage,
    double? price,
    String? selectedSize,
    String? selectedColor,
    int? quantity,
    PersonalizationModel? personalization,
  }) {
    return CartItemModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      quantity: quantity ?? this.quantity,
      personalization: personalization ?? this.personalization,
    );
  }
}
