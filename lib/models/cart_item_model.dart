import 'package:union_shop/models/personalization_model.dart';

class CartItemModel {
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final String selectedSize;
  final String selectedColor;
  int quantity;
  final PersonalizationModel? personalization;

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

  double get totalPrice =>
      (price + (personalization?.additionalCost ?? 0.0)) * quantity;

  // Convert to JSON for local storage
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

  // Create from JSON
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
